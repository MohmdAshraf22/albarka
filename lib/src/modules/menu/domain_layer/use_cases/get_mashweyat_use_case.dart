import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_layer/models/product_model.dart';
import '../repsitories/base_menu_repository.dart';

class GetMashweyatUseCase{
  final BaseMenuRepository baseMenuRepository;
  GetMashweyatUseCase(this.baseMenuRepository);
  Future<Either<Exception,  List<ProductModel>>> get()async{
    return await baseMenuRepository.getMashweyat();
  }
}