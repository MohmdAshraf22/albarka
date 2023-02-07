part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}
class GetDataUserEvent extends OrderEvent{
  const GetDataUserEvent();
  @override
  List<Object?> get props => [];
}
class AddOrderEvent extends OrderEvent {
  final List<String> productNames;
  final String address;
  final String phone;
  final double total;
  final String gift;
  final bool howToPaid;
  const AddOrderEvent(
      {required this.productNames,
        required this.address,
        required this.total,
        required this.howToPaid,
        required this.phone,
        required this.gift});
  @override
  List<Object?> get props => [productNames,address,phone,total,gift,howToPaid];
}
class GetMyLocationEvent extends OrderEvent{
   const GetMyLocationEvent();
  @override
  List<Object?> get props => [];
}
class GoToLocationEvent extends OrderEvent{
  double? latitude = 28.0871;
  double? longitude = 30.7618;
   GoToLocationEvent({required this.longitude,required this.latitude});
  @override
  List<Object?> get props => [latitude,longitude];
}
class ControlEvent extends OrderEvent{
  final Completer<GoogleMapController> controller;
  ControlEvent({required this.controller});
  @override
  List<Object?> get props => [controller];
}
class NavigationToMainScreenEvent extends OrderEvent{
  final BuildContext context;
  const NavigationToMainScreenEvent({required this.context});
  @override
  List<Object?> get props => [context];
}