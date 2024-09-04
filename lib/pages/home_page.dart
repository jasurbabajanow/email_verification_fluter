import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_tok/pages/accaunt_screen.dart';
import 'package:insta_tok/pages/login_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Auth'),
        actions: [
          IconButton(
            onPressed: () {
              if (user == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccauntScreen(),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.login,
            ),
          ),
        ],
      ),
      body: Center(
        child: (user == null)
            ? const Text(
                "Example 1",
                style: TextStyle(fontSize: 28),
              )
            : const Text(
                "Example 2",
                style: TextStyle(fontSize: 28),
              ),
      ),
    );
  }
}
