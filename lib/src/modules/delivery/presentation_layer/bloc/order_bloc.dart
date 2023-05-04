import 'dart:async';

import 'package:albaraka/src/core/utils/navigation_manager.dart';
import 'package:albaraka/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/services/dep_injection.dart';
import '../../data_layer/models/user_model.dart';
import '../../domain_layer/use_cases/get_mylocation_usecase.dart';
import '../../domain_layer/use_cases/get_user_data_use_case.dart';
import '../../domain_layer/use_cases/set_order_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  static OrderBloc get(BuildContext context) =>
      BlocProvider.of<OrderBloc>(context);
  UserModel? user;
  double? latitude = 28.0871;
  double? longitude = 30.7618;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Future<void> goToNewPosition(
      Completer<GoogleMapController> newController) async {
    final GoogleMapController controller = await newController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 16, target: LatLng(latitude!, longitude!))));
  }


  OrderBloc(OrderInitial menuInitial) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      if (event is GetDataUserEvent) {
        emit(const GetDataUserLoadingState());
        final result = await GetDataUserUseCase(sl()).get();
        result.fold((l) {
          print(l.message);
        }, (r) {
          user = r;
          emit(const GetDataUserSuccessState());
        });
      }
      else if (event is AddOrderEvent) {
        final result = await SetOrderUseCase(sl()).set(
            productDetails: event.productDetails,
            address: event.address,
            phone: event.phone,
            total: event.total,
            howToPaid: event.howToPaid,
            latitude: latitude,
            longitude: longitude,
            gift: event.gift);
        result.fold((l) {}, (r) {
          emit(const AddOrderSuccessState());
        });
      }
      else if (event is GetMyLocationEvent) {
        final result = await GetMyLocationUseCase(sl()).get();
        result.fold((l) {}, (r) async {
          latitude = r!.latitude;
          longitude = r.longitude;
          goToNewPosition(_controller);
          emit(GetMyLocationState(
            latitude: latitude,
            longitude: longitude,
            controller: _controller,
          ));
        });
      }
      else if (event is GoToLocationEvent) {
        latitude = event.latitude;
        longitude = event.longitude;
        goToNewPosition(_controller);
        emit(GoToLocationState(
          latitude: latitude,
          longitude: longitude,
          controller: _controller,
        ));
      }
      else if (event is ControlEvent) {
        _controller = event.controller;
        emit(ControlState(controller: event.controller));
      }
      else if (event is NavigationToMainScreenEvent) {
        NavigationManager.push(event.context, MainScreen());
        emit(NavigationToMainScreenState(context:event.context));
      }
    });
  }
}
