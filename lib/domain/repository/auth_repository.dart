import 'package:fin_assist/core/entities/user.dart';
import 'package:flutter/material.dart';

abstract class AuthRepository {
  /*Future<UserEntity> registration({
    required String name,
    required String email,
    required String password,
  });*/

  Future<UserEntity> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserEntity> logInWithGoogle();

  Future<void> logOut();

  Future<UserEntity?> checkAuthStatus();

  Future<void> forgotPassword({required String email});
}
