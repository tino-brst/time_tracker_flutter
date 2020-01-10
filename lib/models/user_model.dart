import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../entities/user.dart';

class UserModel extends User {
  final String uid;

  UserModel({@required this.uid}) : super();

  UserModel.fromFirebaseUser(FirebaseUser firebaseUser) : uid = firebaseUser.uid;
}
