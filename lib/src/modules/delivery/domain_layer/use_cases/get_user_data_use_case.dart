import 'package:albaraka/src/modules/delivery/data_layer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../repsitories/base_order_repository.dart';

class GetDataUserUseCase{
  final BaseOrderRepository baseOrderRepository;
  GetDataUserUseCase(this.baseOrderRepository);
  Future<Either<FirebaseException, UserModel>> get()async{
    return await baseOrderRepository.getDataUser();
  }
}