//import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repsitories/base_auth_repository.dart';


class RegisterWithEmailAndPassUseCase {
  final BaseAuthRepository baseAuthRepository;

  RegisterWithEmailAndPassUseCase(this.baseAuthRepository);
  Future<Either<FirebaseAuthException, UserCredential?>> excute(
      {required String email,
      required String password,
      required String phone,
      required String address,
      required String name}) async {
    return await baseAuthRepository.registerWithEmailAndPass(
        email: email, password: password, name: name, phone: phone,address: address);
  }
}
