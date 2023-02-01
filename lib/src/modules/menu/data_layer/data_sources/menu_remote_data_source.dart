import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/product_model.dart';

abstract class BaseMenuRemoteDataSource {

  Future<Either<Exception, List<ProductModel>>> getKoshary();
  Future<Either<Exception, List<ProductModel>>> getMashweyat();
  Future<Either<Exception, List<ProductModel>>> getHalaweyat();
}

class MenuRemoteDataSource extends BaseMenuRemoteDataSource {
  File? imageFiled;
  String? uploadImage;
  String? imagePaths;

  List<String> kosharyId = [];
  List<ProductModel> koshary = [];

  List<String> mashweyatId = [];
  List<ProductModel> mashweyat = [];
  List<String> halaweyatId = [];
  List<ProductModel> halaweyat = [];

  @override
  Future<Either<Exception, List<ProductModel>>> getKoshary() async {
    kosharyId = [];
    koshary = [];
    try {
      await FirebaseFirestore.instance
          .collection("koshary")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          koshary.add(ProductModel.fromJson(element.data()));
          kosharyId.add(element.id);
        });
      });

      return Right(koshary);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, List<ProductModel>>> getMashweyat() async {
    mashweyatId = [];
    mashweyat = [];
    try {
      await FirebaseFirestore.instance
          .collection("mashweyat")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          mashweyat.add(ProductModel.fromJson(element.data()));
          mashweyatId.add(element.id);
        });
      });

      return Right(mashweyat);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, List<ProductModel>>> getHalaweyat() async {
    halaweyatId = [];
    halaweyat = [];
    try {
      await FirebaseFirestore.instance
          .collection("halaweyat")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          halaweyat.add(ProductModel.fromJson(element.data()));
          halaweyatId.add(element.id);
        });
      });

      return Right(halaweyat);
    } on Exception catch (error) {
      return Left(error);
    }
  }

}
