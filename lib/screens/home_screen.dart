import 'package:flutter/material.dart';

import '../services/auth_service.dart';

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
            onPressed: _signOut,
          )
        ],
      ),
    );
  }

  void _signOut() {
    authService.signOut();
  }
}
