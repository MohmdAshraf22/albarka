import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../domain_layer/repsitories/base_menu_repository.dart';
import '../data_sources/menu_remote_data_source.dart';
import '../models/product_model.dart';

class MenuRepository extends BaseMenuRepository{
  final BaseMenuRemoteDataSource baseMenuRemoteDataSource;
  MenuRepository(this.baseMenuRemoteDataSource);
  @override
  Future<Either<FirebaseException,  List<ProductModel>>> getKoshary()async {
    return await baseMenuRemoteDataSource.getKoshary();
  }
  Future<Either<FirebaseException,  List<ProductModel>>> getHalaweyat()async {
    return await baseMenuRemoteDataSource.getHalaweyat();
  }
  Future<Either<FirebaseException,  List<ProductModel>>> getMashweyat()async {
    return await baseMenuRemoteDataSource.getMashweyat();
  }
  // @override
  // Future<Either<FirebaseException,void>>  setOrder({
  //   required List<String> productNames,
  //   required String address,
  //   required double total,
  //   required String gift
  // }) async {
  //   return await baseMenuRemoteDataSource.setOrder(
  //       productNames: productNames, address: address, total: total, gift: gift);
  // }
}