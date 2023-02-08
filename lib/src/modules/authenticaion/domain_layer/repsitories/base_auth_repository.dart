import 'package:albaraka/src/modules/authenticaion/data_layer/models/user_model.dart';
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
  Future<Either<FirebaseException,UserModel>> getDataUser();
  Future<Either<FirebaseAuthException,void>> changePassword({required String oldPassword,
    required String newPassword,});
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String phone,
    required String address,
    required String name,
    required String oldPassword,
    required String email,});

}
