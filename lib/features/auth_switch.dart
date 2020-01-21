import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/user.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/firestore_database_service.dart';
import 'home/home_screen.dart';
import 'sign_in/sign_in_model.dart';
import 'sign_in/sign_in_screen.dart';

class AuthSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<SignInModel>(
              create: (_) => SignInModel(authService: authService),
              child: SignInScreen(),
            );
          } else {
            return Provider<DatabaseService>(
              create: (_) => FirestoreDatabaseService(userId: user.id),
              child: HomeScreen(),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
