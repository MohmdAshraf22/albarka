import 'package:albaraka/src/modules/authenticaion/data_layer/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repsitories/base_auth_repository.dart';

class UpdateDataUserUseCase{
  final BaseAuthRepository baseAuthRepository;
  UpdateDataUserUseCase(this.baseAuthRepository);
  Future<Either<FirebaseException, void>> update({
    required String phone,
    required String address,
    required String name,
    required String oldPassword,
    required String email,})async{
    return await baseAuthRepository.updateDataUser(
        phone: phone,
        address: address, name: name, oldPassword: oldPassword, email: email);
  }
}