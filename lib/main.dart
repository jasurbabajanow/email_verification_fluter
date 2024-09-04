import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_tok/firebase_options.dart';
import 'package:insta_tok/pages/accaunt_screen.dart';
import 'package:insta_tok/pages/home_page.dart';
import 'package:insta_tok/pages/login_screen.dart';
import 'package:insta_tok/pages/reset_password.dart';
import 'package:insta_tok/pages/signup_screen.dart';
import 'package:insta_tok/pages/verify_email.dart';
import 'package:insta_tok/services/firebase_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
      ),
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => const HomePage(),
        '/accaunt': (context) => const AccauntScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/resetPassword': (context) => const ResetPassword(),
        '/verifyEmail': (context) => const VerifyEmailScreen(),
      },
      initialRoute: '/home',
    );
  }
}
