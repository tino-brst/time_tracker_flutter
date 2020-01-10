import 'package:flutter/material.dart';

import '../entities/user.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'sign_in_screen.dart';

class LandingScreen extends StatelessWidget {
  final AuthService authService;

  LandingScreen({@required this.authService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInScreen(authService: authService);
          } else {
            return HomeScreen(authService: authService);
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
