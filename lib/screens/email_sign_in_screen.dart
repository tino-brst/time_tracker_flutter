import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/custom_flat_button.dart';

class EmailSignInScreen extends StatelessWidget {
  final AuthService authService;

  EmailSignInScreen({@required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EmailSignInForm(authService: authService),
      ),
    );
  }
}

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget {
  final AuthService authService;

  EmailSignInForm({@required this.authService});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  var _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

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
        _buildEmailTextField(),
        SizedBox(height: 12),
        _buildPasswordTextField(),
        SizedBox(height: 32),
        CustomFlatButton(
          // Sign in | Register
          primaryButtonText,
          color: Colors.indigo,
          textColor: Colors.white,
          onPressed: _submit,
        ),
        SizedBox(height: 10),
        CustomFlatButton(
          // Toggle form
          secondaryButtonText,
          color: Colors.transparent,
          textColor: Colors.black.withOpacity(0.7),
          onPressed: _toggleFormType,
        )
      ],
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: true,
      autocorrect: false,
      decoration: InputDecoration(labelText: 'Email'),
      onEditingComplete: _onEmailEditingComplete,
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      onEditingComplete: _submit,
    );
  }

  void _onEmailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.register ? EmailSignInFormType.signIn : EmailSignInFormType.register;
    });
  }

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.authService.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } else {
        await widget.authService.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      }
      Navigator.of(context).pop();
    } catch (error) {
      print(error.toString());
    }
  }
}
