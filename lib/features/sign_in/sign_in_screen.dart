import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_flat_button.dart';
import 'email_sign_in_screen.dart';
import 'sign_in_model.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final model = Provider.of<SignInModel>(context);
    final isLoading = model.isLoading;
    final signInWithGoogle = model.signInWithGoogle;
    final signInAnonymously = model.signInAnonymously;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50,
            child: Center(
              child: _buildHeader(isLoading),
            ),
          ),
          const SizedBox(height: 48),
          CustomFlatButton(
            'Sign in with Google',
            color: Colors.grey.shade300,
            textColor: Colors.black87,
            trailing: Image.asset('images/google-logo.png'),
            onPressed: isLoading ? null : signInWithGoogle,
          ),
          const SizedBox(height: 12),
          CustomFlatButton(
            'Sign in with Facebook',
            color: const Color(0xFF3C599D),
            textColor: Colors.white,
            trailing: Image.asset('images/facebook-logo.png'),
            onPressed: null,
          ),
          const SizedBox(height: 12),
          CustomFlatButton(
            'Sign in with Email',
            color: Colors.teal,
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          const SizedBox(height: 24),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          CustomFlatButton(
            'Sign in anonymously',
            padding: EdgeInsets.zero,
            textColor: Colors.black87,
            onPressed: isLoading ? null : signInAnonymously,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Text(
        'Sign in',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
        ),
      );
    }
  }

  Future<void> _signInWithEmail(BuildContext context) async {
    // TODO replace with (not implemented) 'show()' method from the EmailSignInScreen
    Navigator.of(context).push(
      // TODO replace with platform aware PlatformPageRoute (for proper iOS transitions)
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => EmailSignInScreen(),
      ),
    );
  }
}
