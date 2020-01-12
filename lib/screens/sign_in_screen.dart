import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/custom_flat_button.dart';
import 'email_sign_in_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

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
            onPressed: () => _signInWithGoogle(authService),
          ),
          SizedBox(height: 12),
          CustomFlatButton(
            'Sign in with Facebook',
            color: Color(0xFF3C599D),
            textColor: Colors.white,
            trailing: Image.asset('images/facebook-logo.png'),
            onPressed: null,
          ),
          SizedBox(height: 12),
          CustomFlatButton(
            'Sign in with Email',
            color: Colors.teal,
            textColor: Colors.white,
            onPressed: () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymously(authService),
          ),
        ],
      ),
    );
  }

  Future<void> _signInAnonymously(AuthService authService) async {
    try {
      await authService.signInAnonymously();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _signInWithGoogle(AuthService authService) async {
    try {
      await authService.signInWithGoogle();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => EmailSignInScreen(),
      ),
    );
  }
}
