import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/custom_flat_button.dart';

class SignInScreen extends StatelessWidget {
  final AuthService authService;

  SignInScreen({@required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 0,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          SizedBox(height: 48),
          CustomFlatButton(
            'Sign in with Google',
            color: Colors.grey.shade300,
            textColor: Colors.black87,
            trailing: Image.asset('images/google-logo.png'),
            onPressed: _signInWithGoogle,
          ),
          SizedBox(height: 12),
          CustomFlatButton(
            'Sign in with Facebook',
            color: Color(0xFF3C599D),
            textColor: Colors.white,
            trailing: Image.asset('images/facebook-logo.png'),
            onPressed: () {},
          ),
          SizedBox(height: 12),
          CustomFlatButton(
            'Sign in with Email',
            color: Colors.teal,
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 24),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
          ),
          SizedBox(height: 12),
          CustomFlatButton(
            'Sign in anonymously',
            padding: EdgeInsets.zero,
            textColor: Colors.black87,
            onPressed: _signInAnonymously,
          ),
        ],
      ),
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      await authService.signInAnonymously();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await authService.signInWithGoogle();
    } catch (error) {
      print(error.toString());
    }
  }
}
