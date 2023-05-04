// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import '../repsitories/base_menu_repository.dart';
//
// class SetOrderUseCase{
//   final BaseMenuRepository baseMenuRepository;
//   SetOrderUseCase(this.baseMenuRepository);
//   Future<Either<FirebaseException,  void>> set({
//     required List<String> productNames,
//     required String address,
//     required double total,
//     required String gift
//   })async{
//     return await baseMenuRepository.setOrder(
//         productNames: productNames,
//         address: address,
//         total: total,
//         gift: gift);
//   }
// }
