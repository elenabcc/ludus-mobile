import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [EmailAuthProvider()],
            showAuthActionSwitch: false,
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: constraints.maxWidth * 0.5,
                  height: constraints.maxWidth * 0.5,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Text(
                  'Benvenuto! Accedi per organizzare i tuoi giochi.',
                ),
              );
            },
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }),
            ],
          );
        }

        return const HomeScreen();
      },
    );
  }
}
