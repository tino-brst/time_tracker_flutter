import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class EmailSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: EmailSignInForm(),
        ),
      ),
    );
  }
}
