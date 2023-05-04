import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repsitories/base_auth_repository.dart';

class ChangePasswordUseCase{
  final BaseAuthRepository baseAuthRepository;
  ChangePasswordUseCase(this.baseAuthRepository);
  Future<Either<FirebaseAuthException, void>> change({
    required String oldPassword,
    required String newPassword,})async{
    return await baseAuthRepository.changePassword(
        newPassword: newPassword,oldPassword: oldPassword);
  }
}