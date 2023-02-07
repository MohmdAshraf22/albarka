import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../repsitories/base_auth_repository.dart';

class ForgetPasswordUseCase
{
  final BaseAuthRepository baseAuthRepository;
  ForgetPasswordUseCase(this.baseAuthRepository);
  Future<Either<FirebaseAuthException, void>> excute(
      {required String email}) async {
    return await baseAuthRepository.forgetPassword(email: email);
  }
}
