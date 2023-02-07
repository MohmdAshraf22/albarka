import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Future loginWithEmailAndPass(
      {required String email, required String password});
  Future<Either<FirebaseAuthException, UserCredential?>>
      registerWithEmailAndPass(
          {required String email,
          required String password,
          required String phone,
          required String address,
          required String name});
  Future loginWithFaceBook();
  Future registerWithFaceBook();
  Future loginWithGmail();
  Future registerWithGmail();
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email});
}
