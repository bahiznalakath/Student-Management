import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/auth_controller.dart';
import 'package:student_details/view/home_page.dart';
import 'package:student_details/view/login_view.dart';
import 'package:student_details/view/mobile_auth/Moble_Login.dart';
import 'package:student_details/view/student_add.dart';
import 'controller/student_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthController()),
    ChangeNotifierProvider(create: (context) => StudentController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginView(),
        '/home': (context) => const StudentView(),
        '/studAdd': (context) => const StudentAdd(),
        "/mobile": (context) => const MobileLogin(),
      },
      initialRoute: FirebaseAuth.instance.currentUser != null ? '/home' : '/',
    );
  }
}
