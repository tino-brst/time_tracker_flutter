import 'package:meta/meta.dart';

import '../entities/user.dart';

abstract class AuthService {
  Stream<User> get onAuthStateChanged;
  Future<User> get currentUser;
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword({@required String email, @required String password});
  Future<User> createUserWithEmailAndPassword({@required String email, @required String password});
  Future<void> signOut();
}
