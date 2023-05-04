import 'package:albaraka/src/modules/delivery/data_layer/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import '../../../../core/services/constants.dart';
import '../models/lcation_model.dart';
import '../models/user_model.dart';

abstract class BaseOrderRemoteDataSource {
  Future<Either<FirebaseException, UserModel>> getDataUser();
  Future<Either<FirebaseException, void>> setOrder({
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


class OrderRemoteDataSource extends BaseOrderRemoteDataSource {
  UserModel? userData;
  LocationModel? locationModel;
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
  Future<Either<FirebaseException, void>> setOrder({
    required List<String> productDetails,
    required String address,
    required double total,
    required String gift,
    required String phone,
    required bool howToPaid,
    double? latitude,
    double? longitude,

  }) async {
    OrderModel orderModel = OrderModel(
      phone: phone,
      productDetails: productDetails,
      address: address,
      gift: gift,
      total: total,
      latitude: latitude,
      longitude: longitude,
      howToPaid: howToPaid,
    );
    try {
      await FirebaseFirestore.instance
          .collection("order")
          .doc()
          .set(orderModel.toJson());
      print("sent");
      return const Right(true);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, LocationModel?>> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    LocationData locationData;
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return const Right(null);
        }
      }
      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          return const Right(null);
        }
      }
      locationData = await location.getLocation();
      locationModel = LocationModel(
        longitude: locationData.longitude,
        latitude: locationData.latitude,
      );
      return Right(locationModel);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
