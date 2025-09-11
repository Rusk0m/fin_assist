import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_assist/core/entities/user.dart';
import 'package:fin_assist/core/error/failures.dart';
import 'package:fin_assist/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRepositoryImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  /*@override
  Future<UserEntity> registration({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      final user = credential.user!;
      return UserEntity(
        id: user.uid,
        email: user.email!,
        name: user.displayName,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseErrorToMessage(e));
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
*/
  @override
  Future<UserEntity> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user!;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw AuthFailure(message: "Профиль пользователя не найден в Firestore");
      }

      return UserEntity(
        uid: user.uid,
        email: user.email!,
        name: user.displayName,
        role: userDoc.data()!["role"] as String,
        organizations: List<String>.from(userDoc.data()!["organizations"]??[]),
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseErrorToMessage(e));
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<UserEntity> logInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthFailure(message: 'Google Sign-In cancelled');
      }
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await firebaseAuth.signInWithCredential(
          credential);
      final user = userCredential.user!;

      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw AuthFailure(message: "Профиль пользователя не найден в Firestore");
      }
      print("Firestore user data: ${userDoc.data()}");
      return UserEntity(
        uid: user.uid,
        email: user.email!,
        name: user.displayName,
        role: userDoc.data()!["role"] as String,
        organizations: List<String>.from(userDoc.data()!["organizations"]??[]),
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseErrorToMessage(e));
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerFailure(message: 'Failed to log out: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> checkAuthStatus() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return null;
      final userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

      if (!userDoc.exists) {
        throw AuthFailure(message: "Профиль пользователя не найден в Firestore");
      }

      return UserEntity(
        uid: user.uid,
        email: user.email!,
        name: user.displayName,
        role: userDoc.data()!["role"] as String,
        organizations: List<String>.from(userDoc.data()!["organizations"]??[]),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthFailure(message: _mapFirebaseErrorToMessage(e));
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  String _mapFirebaseErrorToMessage(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Пользователь не найден';
      case 'wrong-password':
        return 'Неверный пароль';
      case 'email-already-in-use':
        return 'Email уже используется';
      case 'invalid-email':
        return 'Неверный формат email';
      case 'weak-password':
        return 'Слабый пароль';
      default:
        return e.message ?? 'Ошибка авторизации';
    }
  }
}