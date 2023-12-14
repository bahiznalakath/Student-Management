import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/auth_controller.dart';
import 'package:student_details/utils/constants/validators.dart';
import '../utils/widgets/new_elevated_button.dart';
import '../utils/widgets/new_icon_text_column.dart';
import '../utils/widgets/new_text_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white70,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
            top: ht * .02, left: wt * .1, right: wt * .1, bottom: ht * .03),
        child: Form(
            key: formKey,
            child: Consumer<AuthController>(
                builder: (context, authController, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: ht * .3,
                    ),
                    const Center(
                      child: Text(
                        "Hello !",
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: ht * .02,
                    ),
                    NewTextFieldWidget(
                      controller: authController.emailController,
                      labelText: 'E mail',
                      iconData: Icons.mail,
                      validator: MyValidator.validateEmail,
                      keyBoardType: TextInputType.emailAddress,
                      dark: false,
                    ),
                    SizedBox(
                      height: ht * .02,
                    ),
                    NewTextFormFieldPasswordWidget(
                        obscure: authController.isVisible,
                        controller: authController.passwordController,
                        iconButton: authController.isVisible
                            ? IconButton(
                                onPressed: () {
                                  authController.visibleChange();
                                },
                                icon: const Icon(
                                  CupertinoIcons.eye,
                                ))
                            : IconButton(
                                onPressed: () {
                                  authController.visibleChange();
                                },
                                icon: const Icon(
                                  CupertinoIcons.eye_slash,
                                ))),
                    SizedBox(
                      height: ht * .02,
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: wt * .15, right: wt * .15),
                        child: authController.isLogin
                            ? NewElevatedButtonWidget(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.createAuth(context);
                                    authController.emailController.clear();
                                    authController.passwordController.clear();
                                  }
                                },
                                buttonText: 'Sign Up',
                                dark: true,
                                color: Colors.blue,
                              )
                            : NewElevatedButtonWidget(
                                onPressed: () {
                                  try {
                                    if (formKey.currentState!.validate()) {
                                      // authController.loginAuth(context);
                                      // authController.emailController;
                                      // authController.passwordController;
                                      authController.login(
                                          context: context,
                                          email: authController
                                              .emailController.text,
                                          password: authController
                                              .passwordController.text);
                                    }
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print("Login error: $e");
                                    }
                                  }
                                },
                                buttonText: 'Login',
                                dark: true,
                                color: Colors.greenAccent,
                              )),
                    SizedBox(
                      height: ht * .01,
                    ),
                    authController.isLogin
                        ? TextButton(
                            onPressed: () {
                              authController.boolChange();
                            },
                            child: const Text("have account!!"))
                        : TextButton(
                            onPressed: () {
                              authController.boolChange();
                            },
                            child: const Text("Don't have an account?")),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: wt * .05, right: wt * .05, top: ht * .02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NewIconColumnTextWidget(
                            ht: ht,
                            iconData: MdiIcons.google,
                            wt: wt,
                            type: 'GOOGLE',
                            onTap: () {
                              authController.signInWithGoogle(context);
                            },
                          ),
                          const VerticalDivider(),
                          NewIconColumnTextWidget(
                            ht: ht,
                            iconData: Icons.phone_android_outlined,
                            wt: wt,
                            type: 'PHONE',
                            onTap: () {
                              Navigator.pushReplacementNamed(context, "/mobile");
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return Padding(
                              //       padding: EdgeInsets.only(
                              //           top: ht * .3,
                              //           bottom: ht * .3,
                              //           left: wt * .05,
                              //           right: wt * .05),
                              //       child: Card(
                              //         child: Column(
                              //           children: [
                              //             Padding(
                              //               padding: EdgeInsets.only(
                              //                   top: ht * .07,
                              //                   left: wt * .02,
                              //                   right: wt * .02),
                              //               child: NewTextFieldWidget(
                              //                 controller: authController
                              //                     .phoneNumberController,
                              //                 keyBoardType: TextInputType.phone,
                              //                 validator:
                              //                     MyValidator.validatePhone,
                              //                 labelText: 'Phone Number',
                              //                 iconData: Icons.numbers_outlined,
                              //                 dark: false,
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               height: ht * .05,
                              //             ),
                              //             NewElevatedButtonWidget(
                              //               onPressed: () {
                              //                 authController.signInWithMobile(
                              //                     "+91 ${authController.phoneNumberController.text}",
                              //                     context);
                              //               },
                              //               buttonText: 'Verify Number',
                              //               dark: true,
                              //               color: Colors.greenAccent,
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }
}
