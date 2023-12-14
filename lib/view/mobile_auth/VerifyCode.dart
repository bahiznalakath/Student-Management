import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/auth_controller.dart';


class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool loading = false;
  final verifyController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var apid = context.watch<AuthController>();
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: verifyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '6 digit code',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ))),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: ()  {

                      // apid.otpVerification(verificationId, verifyController.text, context);
                      // setState(() {
                      //   loading = true;
                      // });
                      // final credential = PhoneAuthProvider.credential(
                      //     verificationId: widget.verifcationId,
                      //     smsCode: verifyController.text.toString());
                      // try {
                      //   await auth.signInWithCredential(credential);
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => HomePage()),
                      //   );
                      // } catch (e) {
                      //   setState(() {
                      //     loading = false;
                      //   });
                      //   // apid.toastMessage(e.toString());
                      // }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
