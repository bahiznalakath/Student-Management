import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import 'VerifyCode.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  String? validationError;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var authController = context.watch<AuthController>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your proper Phone Number';
                  }
                  return null;
                },
                controller: authController.phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  // prefixIcon: Text('  +91'),
                  hintText: 'Enter  Your Phone Number',
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  authController.signInWithMobile(
                      "+91 ${authController.phoneNumberController.text}",
                      context);
                  // String phoneNumber = phoneNumberController.text.trim();
                  // if (phoneNumber.isEmpty) {
                  //   setState(() {
                  //     validationError = 'Enter your proper Phone Number';
                  //   });
                  // } else {
                  //   setState(() {
                  //     validationError = null;
                  //   });
                  // }
                  // setState(() {
                  //   loading = true;
                  // });
                  // auth.verifyPhoneNumber(
                  //     phoneNumber: phoneNumberController.text,
                  //     verificationCompleted: (_) {
                  //       setState(() {
                  //         loading = false;
                  //       });
                  //     },
                  //     verificationFailed: (e) {
                  //       setState(() {
                  //         loading = false;
                  //       });
                  //       auth.toastMessage(e.toString());
                  //     },
                  //     codeSent: (String verifcationId, int? toeken) {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => VerifyCodeScreen(
                  //                     verifcationId: verifcationId,
                  //                   )));
                  //       setState(() {
                  //         loading = false;
                  //       });
                  //     },
                  //     codeAutoRetrievalTimeout: (e) {
                  //       apid.toastMessage(e.toString());
                  //       setState(() {
                  //         loading = false;
                  //       });
                  //     });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                child: const Text(
                  'Get OTP ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
