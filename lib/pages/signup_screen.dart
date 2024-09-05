import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_tok/services/snack_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatpasswordController.dispose();

    super.dispose();
  }

  void togglePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signup() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordController.text != repeatpasswordController.text) {
      SnackBarService.showSnackBar(
        context,
        'Password will be same',
        true,
      );
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Email already in use',
          true,
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          'Unknown error. Try again',
          true,
        );
      }
    }
    navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  email != null && !EmailValidator.validate(email)
                      ? 'Input email correctly'
                      : null;
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your email',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: passwordController,
                autocorrect: false,
                obscureText: isHiddenPassword,
                validator: (value) =>
                    value != null && value.length < 6 ? 'Min 6 symbols' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Write your password',
                  suffix: InkWell(
                    onTap: togglePassword,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: repeatpasswordController,
                autocorrect: false,
                obscureText: isHiddenPassword,
                validator: (value) =>
                    value != null && value.length < 6 ? 'Min 6 symbols' : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Write your password again',
                  suffix: InkWell(
                    onTap: togglePassword,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: signup,
                child: const Center(
                  child: Text('Registration'),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Login',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
