import 'package:albaraka/src/modules/authenticaion/data_layer/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain_layer/repsitories/base_auth_repository.dart';
import '../data_sources/auth_remote_data_sources.dart';

class AuthRepository extends BaseAuthRepository {
  BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepository(this.baseAuthRemoteDataSource);

  @override
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password}) async {
    return baseAuthRemoteDataSource.loginWithEmailAndPass(
        email: email, password: password);

  }

  @override
  Future loginWithFaceBook() {
    //TODO: implement loginWithFaceBook
    throw UnimplementedError();
  }
  @override
  Future loginWithGmail() {
    // TODO: implement loginWithGmail
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseAuthException, UserCredential?>>
      registerWithEmailAndPass(
          {required String email,
          required String password,
          required String phone,
          required String address,
          required String name}) async {
    return baseAuthRemoteDataSource.registerWithEmailAndPass(
        email: email,
        password: password,
        name: name,
        phone: phone,
        address: address);

    throw UnimplementedError();
  }

  @override
  Future registerWithFaceBook() {
    // TODO: implement registerWithFaceBook
    throw UnimplementedError();
  }

  @override
  Future registerWithGmail() {
    //  TODO: implement registerWithGmail
    throw UnimplementedError();
  }

  @override
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email}) async {
    return await baseAuthRemoteDataSource.forgetPassword(email: email);
  }

  @override
  Future<Either<FirebaseException, UserModel>> getDataUser()async {
    return await baseAuthRemoteDataSource.getDataUser();
  }
  @override
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String phone,
    required String address,
    required String name,
    required String oldPassword,
    required String email,}) async{
    return await baseAuthRemoteDataSource.updateDataUser(
        phone: phone, address: address, name: name, oldPassword: oldPassword, email: email);
  }
  @override
  Future<Either<FirebaseAuthException, void>> changePassword({
  required String oldPassword,
  required String newPassword,}) async{
    return await baseAuthRemoteDataSource.changePassword(
        newPassword: newPassword,oldPassword: oldPassword);
  }

}
