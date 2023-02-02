import 'dart:async';
import 'dart:io';
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
  List<ProductModel> selectProducts = [];
  bool selectProduct = false;
  bool isSelected = false;
  int changeTab = 0;
  int number = 1;
  double total = 0;
  void changeIsSelected() {
    selectProduct = !selectProduct;
  }

  void changeSelectProduct() {
    isSelected = !isSelected;
  }
  void deleteSelectProduct() {
    selectProducts.forEach((element) {
      total -= element.newPrice * element.number!;
      cartItems.remove(element);
    });
    selectProducts.clear();
    isSelected = false;
  }
  void determineSelectAllProduct() {
    if (selectProducts.length == cartItems.length) {
      selectProducts.clear();
    } else {
      selectProducts.clear();
      for (int i = 0; i < cartItems.length; i++) {
        selectProducts.add(cartItems[i]);
      }
    }
  }

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
      } else if (event is NavagationToProductsDetailsEvent) {
        NavigationManager.push(event.context,
            ProductDetails(event.index, event.product, event.collectionIndex));
        emit(NavigationToProductsDetailsStates(
            index: event.index,
            product: event.product,
            context: event.context));
      } else if (event is ChangeTabBarEvent) {
        changeTab = event.changeTab;
        emit(ChangeTabBarState(changeTab: changeTab));
      } else if (event is IsSelectedProductEvent) {
        changeIsSelected();
        emit(IsSelectedProductState(selectProduct: selectProduct));
      } else if (event is ChangeIsSelectedEvent) {
        changeSelectProduct();
        emit(ChangeIsSelectedState(isSelected));
      } else if (event is AddProductToCartEvent) {
        cartItems.add(event.product);
        event.product.number = number;
        emit(AddProductToCartState(product: event.product,number: number));
      } else if (event is DeleteProductFromCartEvent) {
        deleteSelectProduct();
        emit(const DeleteProductFromCartState());
      } else if (event is SelectAllProductEvent) {
        determineSelectAllProduct();
        emit(SelectAllProductStates(length: selectProducts.length));
      } else if (event is BackToDefaultBeforeSelectEvent) {
        selectProducts.clear();
        isSelected = false;
        emit(BackToDefaultBeforeSelectState(isSelected));
      } else if (event is PlusNumberOfProductEvent) {
        number++;
        emit(PlusNumberOfProductState(number: number));
      } else if (event is MinusNumberOfProductEvent) {
        number--;
        emit(MinusNumberOfProductState(number: number));
      } else if (event is EditAddProductToCartEvent) {
        //total -= event.product.newPrice * event.product.number!;
        cartItems.remove(event.product);
        emit(EditAddProductToCartState(product: event.product));
      }
      });
  }
}
