import 'package:flutter/foundation.dart';

import '../../services/auth_service.dart';

class SignInModel extends ChangeNotifier {
  final AuthService _authService;

  bool _isLoading = false;

  SignInModel({@required AuthService authService}) : _authService = authService;

  bool get isLoading => _isLoading;

  Future<void> signInAnonymously() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signInAnonymously();
    } catch (error) {
      print(error.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signInWithGoogle();
    } catch (error) {
      print(error.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
