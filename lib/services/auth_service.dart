import '../entities/user.dart';

abstract class AuthService {
  Stream<User> get onAuthStateChanged;
  Future<User> get currentUser;
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<void> signOut();
}
