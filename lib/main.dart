import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth_switch.dart';
import 'services/auth_service.dart';
import 'services/firebase_auth_service.dart';

void main() => runApp(TimeTracker());

class TimeTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => FirebaseAuthService(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: AuthSwitch(),
      ),
    );
  }
}
