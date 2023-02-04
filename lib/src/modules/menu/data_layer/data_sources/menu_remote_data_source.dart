import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

abstract class BaseMenuRemoteDataSource {

  Future<Either<FirebaseException, List<ProductModel>>> getKoshary();
  Future<Either<FirebaseException, List<ProductModel>>> getMashweyat();
  Future<Either<FirebaseException, List<ProductModel>>> getHalaweyat();
  Future<Either<FirebaseException,void>>  setOrder({
    required List<String> productNames,
    required String address,
    required double total,
    required String gift
  });
}

class MenuRemoteDataSource extends BaseMenuRemoteDataSource {
  List<ProductModel> koshary = [];
  List<ProductModel> mashweyat = [];
  List<ProductModel> halaweyat = [];

  @override
  Future<Either<FirebaseException, List<ProductModel>>> getKoshary() async {
    koshary = [];
    try {
      await FirebaseFirestore.instance
          .collection("koshary")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          koshary.add(ProductModel.fromJson(element.data()));
        });
      });

      return Right(koshary);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  Future<Either<FirebaseException, List<ProductModel>>> getMashweyat() async {
    mashweyat = [];
    try {
      await FirebaseFirestore.instance
          .collection("mashweyat")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          mashweyat.add(ProductModel.fromJson(element.data()));
        });
      });

      return Right(mashweyat);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  Future<Either<FirebaseException, List<ProductModel>>> getHalaweyat() async {
    halaweyat = [];
    try {
      await FirebaseFirestore.instance
          .collection("halaweyat")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          halaweyat.add(ProductModel.fromJson(element.data()));
        });
      });

      return Right(halaweyat);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException,void>> setOrder({
    required List<String> productNames,
    required String address,
    required double total,
    required String gift
})async {
    OrderModel orderModel = OrderModel(
      productNames: productNames,
      address: address,
      gift: gift,
      total: total,
    );
    try {
      await FirebaseFirestore.instance
          .collection("order")
          .doc().set(orderModel.toJson());
      return const Right(true);
    }on FirebaseException catch (error) {
      return Left(error);
    }
  }

}
