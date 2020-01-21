import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../../widgets/platform_alert_dialog.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    const appBarTitle = Text('Account');
    final signOutButton = IconButton(
      icon: Icon(Icons.exit_to_app, color: Colors.white),
      onPressed: () => _signOut(context, authService),
    );

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: Platform.isIOS,
        elevation: 0,
        actions: [signOutButton],
      ),
    );
  }

  Future<void> _signOut(BuildContext context, AuthService authService) async {
    final didConfirmSignOut = await PlatformAlertDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      primaryActionText: 'Sign Out',
      cancelActionText: 'Cancel',
    ).show(context);

    if (didConfirmSignOut) authService.signOut();
  }
}
