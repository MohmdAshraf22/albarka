import 'package:albaraka/src/modules/authenticaion/data_layer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/constants.dart';

abstract class BaseAuthRemoteDataSource {
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass({
    required String email,
    required String password,
  });
  Future<Either<FirebaseAuthException, UserCredential?>>
      registerWithEmailAndPass(
          {required String email,
          required String password,
          required String phone,
          required String address,
          required String name});
  Future createUser(
      {required String phone,
      required String address,
      required String email,
      required String name,
      required String uid});
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email});
  Future<Either<FirebaseException, UserModel>> getDataUser();
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String phone,
    required String address,
    required String name,
    required String oldPassword,
    required String email,
  });
  Future<Either<FirebaseAuthException, void>> changePassword(
      {required String oldPassword, required String newPassword});
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  UserModel? userData;

  @override
  Future<Either<FirebaseAuthException, UserCredential?>> loginWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await CacheHelper.saveData(key: 'uid', value: value.user!.uid)
            .then((value) async {
          uId = await CacheHelper.getData(key: 'uid');
          print("saved");
        });
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, UserCredential?>>
      registerWithEmailAndPass({
    required String email,
    required String password,
    required String phone,
    required String address,
    required String name,
  }) async {
    try {
      UserCredential? response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        print('done');
        await createUser(
            address: address,
            phone: phone,
            name: name,
            uid: value.user!.uid,
            email: email);
        await CacheHelper.saveData(key: 'uid', value: value.user!.uid)
            .then((value) async {
          print("saved");
        });
      });
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

//
  @override
  Future createUser(
      {required String phone,
      required String address,
      required String name,
      required String email,
      required String uid}) async {
    UserModel userModel =
        UserModel(phone: phone, address: address, email: email, name: name);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toJson())
        .then((value) {
      print('done .. ');
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Future<Either<FirebaseAuthException, void>> forgetPassword(
      {required String email}) async {
    print(
        "forgetPassword forgetPassword forgetPassword forgetPassword forgetPassword forgetPassword");
    try {
      void response =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Right(response);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, UserModel>> getDataUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        userData = UserModel.fromJson(value.data()!);
      });
      return Right(userData!);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseAuthException, void>> updateDataUser({
    required String phone,
    required String address,
    required String name,
    required String oldPassword,
    required String email,
  }) async {
    UserModel userModel =
        UserModel(phone: phone, address: address, email: email, name: name);
    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: oldPassword);
      UserCredential authResult = await user.reauthenticateWithCredential(cred);
      if (authResult.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .update(userModel.toJson());
      }
      return const Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }
  @override
  Future<Either<FirebaseAuthException, void>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: oldPassword);
    try {
      user.reauthenticateWithCredential(cred);
      UserCredential authResult = await user.reauthenticateWithCredential(cred);
      if (authResult.user != null) {
        user.updatePassword(newPassword);
      }
        return const Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(error);
    }
  }
}
