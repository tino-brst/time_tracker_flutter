import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_flat_button.dart';
import '../../widgets/platform_alert_dialog.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
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
  bool _isLoading = false;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool get _isEveryFieldValid => widget.emailValidator.isValid(_email) && widget.passwordValidator.isValid(_password);
  bool get _isSubmitEnabled => _isEveryFieldValid && !_isLoading;

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
        const SizedBox(height: 12),
        _buildPasswordTextField(),
        const SizedBox(height: 32),
        CustomFlatButton(
          // Sign in | Register
          primaryButtonText,
          color: Colors.indigo,
          textColor: Colors.white,
          onPressed: _isSubmitEnabled ? _submit : null,
        ),
        const SizedBox(height: 10),
        CustomFlatButton(
          // Toggle form
          secondaryButtonText,
          textColor: Colors.black.withOpacity(0.7),
          onPressed: !_isLoading ? _toggleFormType : null,
        )
      ],
    );
  }

  Widget _buildEmailTextField() {
    final showErrorMessage = _areErrorMessagesEnabled && !widget.emailValidator.isValid(_email);
    return TextField(
      key: const Key('email'),
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: true,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: showErrorMessage ? widget.invalidEmailText : null,
        enabled: !_isLoading,
      ),
      onChanged: (_) => setState(() {}),
      onEditingComplete: _onEmailEditingComplete,
    );
  }

  Widget _buildPasswordTextField() {
    final showErrorMessage = _areErrorMessagesEnabled && !widget.passwordValidator.isValid(_password);
    return TextField(
      key: const Key('password'),
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorMessage ? widget.invalidPasswordText : null,
        enabled: !_isLoading,
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

  Future<void> _submit() async {
    setState(() {
      _areErrorMessagesEnabled = true;
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await authService.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      } else {
        await authService.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      }
      Navigator.of(context).pop();
    } catch (error) {
      PlatformAlertDialog(
        title: 'Sign In Failed',
        content: error.toString(),
        primaryActionText: 'OK',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
}
