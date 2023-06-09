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

class NavigationToProductsDetailsEvent extends MenuEvent {
  final BuildContext context;
  final ProductModel product;
  final int index;
  final int collectionIndex;
  const NavigationToProductsDetailsEvent(
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

class DeleteProductFromCartEvent extends MenuEvent {
  final ProductModel product;
  const DeleteProductFromCartEvent(this.product);
  @override
  List<Object?> get props => [product];
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
class NavigationToDeliveryScreenEvent extends MenuEvent {
  final BuildContext context;
  final List<String> productDetails;
  final double total;
  final String gift;
  const NavigationToDeliveryScreenEvent({required this.context,required this.productDetails,required this.total,required this.gift});
  @override
  List<Object?> get props => [context,productDetails,total,gift];
}
class NavigationToCartEvent extends MenuEvent {
  final BuildContext context;
  const NavigationToCartEvent(
      {required this.context});

  @override
  List<Object?> get props => [context];
}
