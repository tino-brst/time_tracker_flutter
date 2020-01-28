import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../entities/user.dart';

class UserModel extends User {
  const UserModel({@required String id}) : super(id: id);

  UserModel.fromFirebaseUser(FirebaseUser firebaseUser) : super(id: firebaseUser.uid);
}
