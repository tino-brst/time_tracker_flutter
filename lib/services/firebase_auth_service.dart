import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../entities/user.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map((firebaseUser) {
      return UserModel.fromFirebaseUser(firebaseUser);
    });
  }

  @override
  Future<User> get currentUser async {
    final firebaseUser = await _firebaseAuth.currentUser();
    return UserModel.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    final firebaseUser = authResult.user;
    return UserModel.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final googleSignInAuthentication = await googleSignInAccount.authentication;
      final accessToken = googleSignInAuthentication.accessToken;
      final idToken = googleSignInAuthentication.idToken;

      if (accessToken != null && idToken != null) {
        final credential = GoogleAuthProvider.getCredential(
          accessToken: accessToken,
          idToken: idToken,
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);

        return UserModel.fromFirebaseUser(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google auth token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithEmailAndPassword({String email, String password}) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final firebaseUser = authResult.user;
    return UserModel.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<User> createUserWithEmailAndPassword({String email, String password}) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final firebaseUser = authResult.user;
    return UserModel.fromFirebaseUser(firebaseUser);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
