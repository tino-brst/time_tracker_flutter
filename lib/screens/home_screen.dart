import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/platform_alert_dialog.dart';

class HomeScreen extends StatelessWidget {
  final AuthService authService;

  HomeScreen({@required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => _signOut(context),
          )
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    final didConfirmSignOut = await PlatformAlertDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      primaryActionText: 'Sign Out',
      cancelActionText: 'Cancel',
    ).show(context);

    if (didConfirmSignOut) authService.signOut();
  }
}
