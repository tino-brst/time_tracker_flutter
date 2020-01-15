import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../entities/user.dart';

class UserModel extends User {
  UserModel({@required String uid}) : super(uid: uid);

  UserModel.fromFirebaseUser(FirebaseUser firebaseUser) : super(uid: firebaseUser.uid);
}
