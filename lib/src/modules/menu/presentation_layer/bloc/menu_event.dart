part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class GetMashweyatEvent extends MenuEvent {
  const GetMashweyatEvent();
  @override
  List<Object?> get props => [];
}

class GetKosharyEvent extends MenuEvent {
  const GetKosharyEvent();
  @override
  List<Object?> get props => [];
}

class GetHalaweyatEvent extends MenuEvent {
  const GetHalaweyatEvent();
  @override
  List<Object?> get props => [];
}

class NavagationToProductsDetailsEvent extends MenuEvent {
  final BuildContext context;
  final ProductModel product;
  final int index;
  final int collectionIndex;

  const NavagationToProductsDetailsEvent(
      {required this.context,
      required this.product,
      required this.index,
      required this.collectionIndex});

  @override
  List<Object?> get props => [context, product, index, collectionIndex];
}

class ChangeTabBarEvent extends MenuEvent {
  final int changeTab;
  const ChangeTabBarEvent({required this.changeTab});
  @override
  List<Object?> get props => [changeTab];
}

class IsSelectedProductEvent extends MenuEvent {
  const IsSelectedProductEvent();
  @override
  List<Object?> get props => [];
}

class ChangeIsSelectedEvent extends MenuEvent {
  const ChangeIsSelectedEvent();
  @override
  List<Object?> get props => [];
}

class DeleteProductFromCartEvent extends MenuEvent {
  const DeleteProductFromCartEvent();
  @override
  List<Object?> get props => [];
}

class SelectAllProductEvent extends MenuEvent {
  const SelectAllProductEvent();
  @override
  List<Object?> get props => [];
}

class AddProductToCartEvent extends MenuEvent {
  final ProductModel product;
  const AddProductToCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class EditAddProductToCartEvent extends MenuEvent {
  final ProductModel product;
  const EditAddProductToCartEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class BackToDefaultBeforeSelectEvent extends MenuEvent {
  const BackToDefaultBeforeSelectEvent();
  @override
  List<Object?> get props => [];
}

class PlusNumberOfProductEvent extends MenuEvent {
  const PlusNumberOfProductEvent();
  @override
  List<Object?> get props => [];
}

class MinusNumberOfProductEvent extends MenuEvent {
  const MinusNumberOfProductEvent();
  @override
  List<Object?> get props => [];
}
