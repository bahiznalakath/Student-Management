import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/constants/validators.dart';
import '../utils/widgets/new_text_form_field.dart';
import '../utils/widgets/new_elevated_button.dart';
import '../view/home_page.dart';
import '../view/login_view.dart';
import '../view/mobile_auth/VerifyCode.dart';

class AuthController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isLogin = false;
  bool _isVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  final firebaseServices = FirebaseServices();
  bool get isLogin => _isLogin;
  bool get isVisible => _isVisible;
  User? get currentUser => _auth.currentUser;

  Future<void> createAuth(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = authResult.user;

      if (user != null && user.uid.isNotEmpty) {
        navigator.pushReplacementNamed('/home');
        Fluttertoast.showToast(msg: "SIGN UP SUCCESSFUL");
      } else {
        Fluttertoast.showToast(msg: "Authentication Error");
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: '${e}');
      print(e);
    }

    notifyListeners();
  }

  void login(
      {required BuildContext context,
        required String email,
        required password}) async {
    try {
      loading = true;
      notifyListeners();
      await firebaseServices.signInWithEmailAndPassword(email, password);
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
      loading = false;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something Went Wrong')));
      }
      loading = false;
      notifyListeners();
    }
  }
  Future<void> signInWithGoogle(BuildContext context) async {
    final navigator = Navigator.of(context);

    try {
      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
        await _auth.signInWithCredential(credential);
        User? user = authResult.user;

        if (user != null) {
          navigator.pushReplacementNamed('/home');
          Fluttertoast.showToast(msg: "GOOGLE SIGN IN SUCCESSFUL");
        } else {
          Fluttertoast.showToast(
              msg: "Google sign in failed", gravity: ToastGravity.BOTTOM);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during sign-in: $e');
      print(e);
    }

    notifyListeners();
  }
  signInWithMobile(String number, BuildContext context) async {
    try {
      final navigator = Navigator.of(context);

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
          User? user = authResult.user;
          if (user != null) {
            navigator.pushReplacementNamed('/home');
          } else {
            Fluttertoast.showToast(msg: "ERROR LOGIN WITH PHONE NUMBER");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
          } else if (e.code == 'invalid-verification-code') {
            Fluttertoast.showToast(
                msg: 'The provided verification code is not valid.');
          } else if (e.code == 'too-many-requests') {
            Fluttertoast.showToast(
                msg: 'Too many verification attempts. Please try again later.');
          } else {
            Fluttertoast.showToast(
                msg: 'Error during phone number verification: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyCodeScreen(
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle code auto-retrieval timeout if needed
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }


  otpVerification(String token, sms,BuildContext context) async {
    final navigator = Navigator.of(context);
    try {
      PhoneAuthCredential credential =
         await PhoneAuthProvider.credential(verificationId: token, smsCode: sms);
      await FirebaseAuth.instance.signInWithCredential(credential);
      navigator.pushReplacementNamed('/home');
      Fluttertoast.showToast(msg: "MOBILE LOGIN SUCCESSFUL");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "OTP VERIFICATION FAILED for ${e.code}");
    }
    notifyListeners();
  }

  signOut(BuildContext context) async {
    final navigator = Navigator.of(context);

    await FirebaseAuth.instance.signOut();
    navigator
        .pushReplacement(MaterialPageRoute(builder: (_) => const LoginView()));
  }

  boolChange() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  visibleChange() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
class FirebaseServices {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }}