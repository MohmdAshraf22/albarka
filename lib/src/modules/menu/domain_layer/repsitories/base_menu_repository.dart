import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../../data_layer/models/product_model.dart';

abstract class BaseMenuRepository {

  Future<Either<Exception, List<ProductModel>>> getKoshary();
  Future<Either<Exception, List<ProductModel>>> getMashweyat();
  Future<Either<Exception, List<ProductModel>>> getHalaweyat();
}
