part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}

class ChangeTabBarState extends MenuState {
  final int changeTab;
  const ChangeTabBarState(
      {required this.changeTab});
  @override
  List<Object?> get props => [changeTab];
}
class IsSelectedProductState extends MenuState {
  final bool selectProduct;
  const IsSelectedProductState({required this.selectProduct});
  @override
  List<Object?> get props => [selectProduct];
}
class ChangeIsSelectedState extends MenuState {
  final bool isSelected;
  const ChangeIsSelectedState(this.isSelected);
  @override
  List<Object?> get props => [isSelected];
}
class DeleteProductFromCartState extends MenuState {
  const DeleteProductFromCartState();
  @override
  List<Object?> get props => [];
}
//// Koshary
class GetKosharyErrorState extends MenuState {
  const GetKosharyErrorState();
  @override
  List<Object?> get props => [];
}
class GetKosharySuccessfulState extends MenuState {
  final List<ProductModel> Koshary;
  const GetKosharySuccessfulState(this.Koshary);
  @override
  List<Object?> get props => [Koshary];
}
class GetKosharyLoadingState extends MenuState {
  const GetKosharyLoadingState();
  @override
  List<Object?> get props => [];
}
 // halaweyat

class GetHalaweyatErrorState extends MenuState {
  const GetHalaweyatErrorState();
  @override
  List<Object?> get props => [];
}
class GetHalaweyatSuccessfulState extends MenuState {
  final List<ProductModel> halaweyat;

  const GetHalaweyatSuccessfulState(this.halaweyat);
  @override
  List<Object?> get props => [halaweyat];
}
class GetHalaweyatLoadingState extends MenuState {
  const GetHalaweyatLoadingState();
  @override
  List<Object?> get props => [];
}
 // mashweyat

class GetMashweyatErrorState extends MenuState {
  const GetMashweyatErrorState();
  @override
  List<Object?> get props => [];
}
class GetMashweyatSuccessfulState extends MenuState {
  final List<ProductModel> mashweyat;
  const GetMashweyatSuccessfulState(this.mashweyat);
  @override
  List<Object?> get props => [mashweyat];
}
class GetMashweyatLoadingState extends MenuState {
  const GetMashweyatLoadingState();
  @override
  List<Object?> get props => [];
}

class NavigationToProductsDetailsStates extends MenuState {
  final BuildContext context;
  final ProductModel product;
  final int index;
  const NavigationToProductsDetailsStates({required this.context,required this.product,required this.index});
  @override
  List<Object?> get props => [context,product,index];
}
class AddProductToCartState extends MenuState {
  final ProductModel product;
  final int number;
  const AddProductToCartState({required this.product,required this.number});
  @override
  List<Object?> get props => [product];
}
class EditAddProductToCartState extends MenuState {
  final ProductModel product;
  const EditAddProductToCartState({required this.product});
  @override
  List<Object?> get props => [product];
}

class BackToDefaultBeforeSelectState extends MenuState {
  final bool isSelected;
  const BackToDefaultBeforeSelectState(this.isSelected);
  @override
  List<Object?> get props => [isSelected];
}
class SelectAllProductStates extends MenuState {
  final int length;

  const SelectAllProductStates({required this.length});
  @override
  List<Object?> get props => [length];
}
class PlusNumberOfProductState extends MenuState {
  final int number;
  const PlusNumberOfProductState({required this.number});
  @override
  List<Object?> get props => [number];
}
class MinusNumberOfProductState extends MenuState {
  final int number;
  const MinusNumberOfProductState({required this.number});
  @override
  List<Object?> get props => [number];
}