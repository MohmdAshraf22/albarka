import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../data_layer/models/product_model.dart';
import '../repsitories/base_menu_repository.dart';

class GetHalaweyatUseCase{
  final BaseMenuRepository baseMenuRepository;
  GetHalaweyatUseCase(this.baseMenuRepository);
  Future<Either<FirebaseException,  List<ProductModel>>> get()async{
    return await baseMenuRepository.getHalaweyat();
  }
}
