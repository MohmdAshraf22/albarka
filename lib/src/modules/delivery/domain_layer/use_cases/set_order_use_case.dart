import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../repsitories/base_order_repository.dart';

class SetOrderUseCase{
  final BaseOrderRepository baseOrderRepository;
  SetOrderUseCase(this.baseOrderRepository);
  Future<Either<FirebaseException,  void>> set({
    required List<String> productDetails,
    required String address,
    required double total,
    required String phone,
    required String gift,
    required bool howToPaid,
    double? latitude,
    double? longitude,
  })async{
    return await baseOrderRepository.setOrder(
        productDetails: productDetails,
        address: address,
        total: total,
        phone: phone,
        longitude: longitude,
        latitude: latitude,
        howToPaid: howToPaid,
        gift: gift);
  }
}
