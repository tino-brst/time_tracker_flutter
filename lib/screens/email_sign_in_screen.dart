import 'package:flutter/material.dart';

import '../core/validators.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: EmailSignInForm(authService: authService),
        ),
      ),
    );
  }
}

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
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
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _areErrorMessagesEnabled = false;
  bool _isAwaitingResponse = false;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool get _isEveryFieldValid => widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password);

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
          onPressed: _isEveryFieldValid && !_isAwaitingResponse ? _submit : null,
        ),
        SizedBox(height: 10),
        CustomFlatButton(
          // Toggle form
          secondaryButtonText,
          textColor: Colors.black.withOpacity(0.7),
          onPressed: !_isAwaitingResponse ? _toggleFormType : null,
        )
      ],
    );
  }

  // TODO investigate TextFields vs FormTextFields

  Widget _buildEmailTextField() {
    final showErrorMessage = _areErrorMessagesEnabled && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: true,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: showErrorMessage ? widget.invalidEmailText : null,
        enabled: !_isAwaitingResponse,
      ),
      onChanged: (_) => setState(() {}),
      onEditingComplete: _onEmailEditingComplete,
    );
  }

  Widget _buildPasswordTextField() {
    final showErrorMessage = _areErrorMessagesEnabled && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorMessage ? widget.invalidPasswordText : null,
        enabled: !_isAwaitingResponse,
      ),
      onChanged: (_) => setState(() {}),
      onEditingComplete: _submit,
    );
  }

  void _onEmailEditingComplete() {
    // If the entered email is not valid, the focus should be kept in the email field
    final nextFocusNode = widget.emailValidator.isValid(_email) ? _passwordFocusNode : _emailFocusNode;

    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.register ? EmailSignInFormType.signIn : EmailSignInFormType.register;
      _areErrorMessagesEnabled = false;
    });
  }

  void _submit() async {
    setState(() {
      _areErrorMessagesEnabled = true;
      _isAwaitingResponse = true;
    });

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
    } finally {
      setState(() {
        _isAwaitingResponse = false;
      });
    }
  }
}
