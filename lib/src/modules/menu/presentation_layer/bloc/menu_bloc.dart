import 'dart:async';
import 'dart:io';
import 'package:albaraka/src/modules/authenticaion/presentation_layer/components/components.dart';
import 'package:albaraka/src/modules/delivery/presentation_layer/screens/delivery_screen.dart';
import 'package:albaraka/src/modules/menu/presentation_layer/screens/cart_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../data_layer/models/product_model.dart';
import '../../domain_layer/use_cases/get_halaweyat_use_case.dart';
import '../../domain_layer/use_cases/get_koshary_use_case.dart';
import '../../domain_layer/use_cases/get_mashweyat_use_case.dart';
import '../../domain_layer/use_cases/set_order_use_case.dart';
import '../screens/product_details_screen.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  static MenuBloc get(BuildContext context) =>
      BlocProvider.of<MenuBloc>(context);
  List<ProductModel> koshary = [];
  List<ProductModel> mashweyat = [];
  List<ProductModel> halaweyat = [];
  List<ProductModel> cartItems = [];
  int changeTab = 0;
  int number = 1;

  MenuBloc(MenuInitial menuInitial) : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is GetHalaweyatEvent) {
        emit(const GetHalaweyatLoadingState());
        final result = await GetHalaweyatUseCase(sl()).get();
        result.fold((l) {
          emit(const GetHalaweyatErrorState());
        }, (r) {
          halaweyat = r;
          emit(GetHalaweyatSuccessfulState(halaweyat));
        });
      } else if (event is GetKosharyEvent) {
        emit(const GetKosharyLoadingState());
        final result = await GetKosharyUseCase(sl()).get();
        result.fold((l) {
          emit(const GetKosharyErrorState());
        }, (r) {
          koshary = r;
          emit(GetKosharySuccessfulState(koshary));
        });
      } else if (event is GetMashweyatEvent) {
        emit(const GetMashweyatLoadingState());
        final result = await GetMashweyatUseCase(sl()).get();
        result.fold((l) {
          emit(const GetMashweyatErrorState());
        }, (r) {
          mashweyat = r;
          emit(GetMashweyatSuccessfulState(mashweyat));
        });
      } else if (event is NavigationToProductsDetailsEvent) {
        NavigationManager.push(event.context,
            ProductDetails(event.index, event.product, event.collectionIndex));
        emit(NavigationToProductsDetailsStates(
            index: event.index,
            product: event.product,
            context: event.context));
      } else if (event is ChangeTabBarEvent) {
        changeTab = event.changeTab;
        emit(ChangeTabBarState(changeTab: changeTab));
      } else if (event is AddProductToCartEvent) {
        cartItems.add(event.product);
        event.product.number = number;
        emit(AddProductToCartState(product: event.product, number: number));
      } else if (event is DeleteProductFromCartEvent) {
        cartItems.remove(event.product);
        emit(DeleteProductFromCartState(event.product));
      } else if (event is PlusNumberOfProductEvent) {
        number++;
        emit(PlusNumberOfProductState(number: number));
      } else if (event is MinusNumberOfProductEvent) {
        number--;
        emit(MinusNumberOfProductState(number: number));
      } else if (event is EditAddProductToCartEvent) {
        cartItems.remove(event.product);
        emit(EditAddProductToCartState(product: event.product));
      }
      else if (event is NavigationToDeliveryScreenEvent) {
        if (event.productNames.isNotEmpty) {
          await Future.delayed(const Duration(seconds: 1));
          //if (event.context.mounted) {
            NavigationManager.push(event.context, DeliveryScreen(
              productNames: event.productNames,
              total: event.total,
            ));
            emit(NavigationToDeliveryScreenState(context: event.context));
         // }
        } else {
          errorToast(msg: "لم يتم اختيار اي منتج لشراءه ");
          emit(const NavigationToDeliveryScreenErrorState());
        }
      }
      else if (event is NavigationToCartEvent) {
        NavigationManager.push(event.context, const CartScreen());
        emit(NavigationToCartState(context:event.context));
      }
    });
  }
}
