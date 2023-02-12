
import 'package:albaraka/src/modules/delivery/data_layer/models/lcation_model.dart';
import 'package:albaraka/src/modules/delivery/data_layer/models/user_model.dart';

import 'package:dartz/dartz.dart';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import '../../domain_layer/repsitories/base_order_repository.dart';
import '../data_sources/order_remote_data_sources.dart';

class OrderRepository extends BaseOrderRepository{
  final BaseOrderRemoteDataSource baseOrderRemoteDataSource;
  OrderRepository(this.baseOrderRemoteDataSource);

  @override
  Future<Either<FirebaseException, UserModel>> getDataUser() {
    return baseOrderRemoteDataSource.getDataUser();
  }

  @override
  Future<Either<FirebaseException,void>>  setOrder({
    required List<String> productDetails,
    required String address,
    required double total,
    required String gift,
    required String phone,
    required bool howToPaid,
    double? latitude,
    double? longitude,
  }) async {
    return await baseOrderRemoteDataSource.setOrder(
      latitude: latitude,longitude: longitude,howToPaid: howToPaid,
        productDetails: productDetails, address: address, total: total, gift: gift,phone:phone);
  }

  @override
  Future<Either<Exception, LocationModel?>> getLocation() {
    return baseOrderRemoteDataSource.getLocation();
  }
}