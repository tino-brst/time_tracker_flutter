import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../widgets/platform_alert_dialog.dart';

class JobsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => _signOut(context, authService),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  void _signOut(BuildContext context, AuthService authService) async {
    final didConfirmSignOut = await PlatformAlertDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      primaryActionText: 'Sign Out',
      cancelActionText: 'Cancel',
    ).show(context);

    if (didConfirmSignOut) authService.signOut();
  }
}
