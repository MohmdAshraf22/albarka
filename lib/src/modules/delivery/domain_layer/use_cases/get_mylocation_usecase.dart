
import 'package:dartz/dartz.dart';
import '../../data_layer/models/lcation_model.dart';
import '../repsitories/base_order_repository.dart';


class GetMyLocationUseCase{
  final BaseOrderRepository baseOrderRepository;
  GetMyLocationUseCase(this.baseOrderRepository);
  Future<Either<Exception, LocationModel?>> get()async{
    return await baseOrderRepository.getLocation();
  }
}