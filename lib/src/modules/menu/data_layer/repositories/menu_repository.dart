import 'package:dartz/dartz.dart';

import '../../domain_layer/repsitories/base_menu_repository.dart';
import '../data_sources/menu_remote_data_source.dart';
import '../models/product_model.dart';

class MenuRepository extends BaseMenuRepository{
  final BaseMenuRemoteDataSource baseMenuRemoteDataSource;
  MenuRepository(this.baseMenuRemoteDataSource);

  @override
  Future<Either<Exception,  List<ProductModel>>> getKoshary()async {
    return await baseMenuRemoteDataSource.getKoshary();
  }
  Future<Either<Exception,  List<ProductModel>>> getHalaweyat()async {
    return await baseMenuRemoteDataSource.getHalaweyat();
  }
  Future<Either<Exception,  List<ProductModel>>> getMashweyat()async {
    return await baseMenuRemoteDataSource.getMashweyat();
  }
}