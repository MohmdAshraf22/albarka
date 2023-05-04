part of 'order_bloc.dart';
abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class GetDataUserSuccessState extends OrderState {
  const GetDataUserSuccessState();
  @override
  List<Object?> get props => [];
}
class GetDataUserLoadingState extends OrderState {
  const GetDataUserLoadingState();
  @override
  List<Object?> get props => [];
}
class AddOrderSuccessState extends OrderState {
   const AddOrderSuccessState();
  @override
  List<Object?> get props => [];
}
class GetMyLocationState extends OrderState{
  double? latitude = 28.0871;
  double? longitude = 30.7618;
  final Completer<GoogleMapController> controller;

  GetMyLocationState({required this.latitude,required this.longitude,required this.controller});
  @override
  List<Object?> get props => [latitude,longitude,controller];
}
class GoToLocationState extends OrderState{
  double? latitude = 28.0871;
  double? longitude = 30.7618;
  final Completer<GoogleMapController> controller;

  GoToLocationState({required this.latitude,required this.longitude,required this.controller});
  @override
  List<Object?> get props => [latitude,longitude,controller];
}
class ControlState extends OrderState{
  final Completer<GoogleMapController> controller;
  ControlState({required this.controller});
  @override
  List<Object?> get props => [controller];
}
class NavigationToMainScreenState extends OrderState{
  final BuildContext context;
  const NavigationToMainScreenState({required this.context});
  @override
  List<Object?> get props => [context];
}