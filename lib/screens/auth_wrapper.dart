import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'main_navigation_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    // If a user is logged in, show the main dashboard.
    // Otherwise, show the login screen.
    if (authProvider.currentUser != null) {
      return const MainNavigationScreen();
    } else {
      return const LoginScreen();
    }
  }
}
