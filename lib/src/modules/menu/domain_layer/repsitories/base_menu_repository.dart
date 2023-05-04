import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';
import '../../data_layer/models/product_model.dart';

abstract class BaseMenuRepository {

  Future<Either<FirebaseException, List<ProductModel>>> getKoshary();
  Future<Either<FirebaseException, List<ProductModel>>> getMashweyat();
  Future<Either<FirebaseException, List<ProductModel>>> getHalaweyat();
}
