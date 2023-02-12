import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../data_layer/models/lcation_model.dart';
import '../../data_layer/models/user_model.dart';

abstract class BaseOrderRepository{
  Future<Either<FirebaseException,UserModel>> getDataUser();
  Future<Either<FirebaseException,void>>  setOrder({
    required List<String> productDetails,
    required String address,
    required double total,
    required String gift,
    required String phone,
    required bool howToPaid,
    double? latitude,
    double? longitude,
  });
  Future<Either<Exception, LocationModel?>> getLocation();
}