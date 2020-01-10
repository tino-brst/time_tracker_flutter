import 'package:flutter/material.dart';

import 'screens/landing_screen.dart';
import 'services/firebase_auth_service.dart';

void main() => runApp(TimeTracker());

class TimeTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LandingScreen(authService: FirebaseAuthService()),
    );
  }
}
