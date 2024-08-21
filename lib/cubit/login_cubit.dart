
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _firebaseAuth;

  LoginCubit(this._firebaseAuth) : super(LoginInitial());

  Future<void> logInWithEmailAndPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginLoading());
      emit(const LoginFailure(error: 'Email and password must not be empty'));
      return;
    }

    try {
      emit(LoginLoading());
      // Try to sign in the user
      await _signInUser(email, password);
    } catch (e) {
      // Handle specific FirebaseAuthException errors
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            // Attempt to register the user if they are not found
            await registerAndLogIn(email, password);
            break;
          case 'invalid-email':
            emit(const LoginFailure(
                error: 'The email address is badly formatted.'));
            break;
          case 'wrong-password':
            emit(const LoginFailure(error: 'The password is invalid.'));
            break;
          case 'invalid-credential':
            emit(const LoginFailure(
                error:
                    'The supplied auth credential is incorrect, malformed, or has expired.'));
            break;
          default:
            emit(
                LoginFailure(error: e.message ?? 'An unknown error occurred.'));
        }
      } else {
        emit(LoginFailure(error: e.toString()));
      }
    }
  }

  /// login the user with email and password
  Future<void> _signInUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure(error: 'Login failed.'));
      }
    } catch (e) {
      rethrow;
    }
  }

  /// create the user with email and password
  Future<void> registerAndLogIn(String email, String password) async {
    try {
      emit(LoginLoading());

      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure(error: 'Registration failed.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(error: e.message.toString()));
    }
  }

  /// logout function
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(error: e.message.toString()));
    }
  }
}
