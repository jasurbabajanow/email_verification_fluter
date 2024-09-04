import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccauntScreen extends StatefulWidget {
  const AccauntScreen({super.key});

  @override
  State<AccauntScreen> createState() => _AccauntScreenState();
}

class _AccauntScreenState extends State<AccauntScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    Future<void> signOut() async {
      final navigator = Navigator.of(context);

      await FirebaseAuth.instance.signOut();

      navigator.pushNamedAndRemoveUntil(
          '/login', (Route<dynamic> route) => false);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Accaunt"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Your email: ${user?.email}',
            ),
            TextButton(
              onPressed: signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
