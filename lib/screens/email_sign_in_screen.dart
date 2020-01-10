import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/custom_flat_button.dart';

class EmailSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EmailSignInForm(),
      ),
    );
  }
}

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _formType = EmailSignInFormType.signIn;

  @override
  Widget build(BuildContext context) {
    String primaryButtonText;
    String secondaryButtonText;

    if (_formType == EmailSignInFormType.signIn) {
      primaryButtonText = 'Sign in';
      secondaryButtonText = 'Need an account? Register';
    } else {
      primaryButtonText = 'Create account';
      secondaryButtonText = 'Already have an account? Sign in';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'example@email.com',
          ),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        SizedBox(height: 32),
        CustomFlatButton(
          primaryButtonText,
          color: Colors.indigo,
          textColor: Colors.white,
          onPressed: () {},
        ),
        SizedBox(height: 10),
        CustomFlatButton(
          secondaryButtonText,
          color: Colors.transparent,
          textColor: Colors.black.withOpacity(0.7),
          onPressed: _toggleFormType,
        )
      ],
    );
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.register ? EmailSignInFormType.signIn : EmailSignInFormType.register;
    });
  }
}
