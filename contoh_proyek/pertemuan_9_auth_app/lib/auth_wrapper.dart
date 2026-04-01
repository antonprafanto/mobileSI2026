import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/verification_page.dart';

/// AuthWrapper: Widget yang listen ke auth state changes
/// dan redirect ke halaman yang sesuai
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Checking authentication...'),
                ],
              ),
            ),
          );
        }

        // User logged in
        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;

          // Check email verification
          if (!user.emailVerified) {
            return const VerificationPage();
          }

          return const HomePage();
        }

        // Not logged in
        return const LoginPage();
      },
    );
  }
}
