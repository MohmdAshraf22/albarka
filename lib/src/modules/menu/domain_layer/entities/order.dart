import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final List<String> productNames;
  final String address;
  final double total;
  final String gift;

  const Order({
    required this.productNames,
    required this.address,
    required this.total,
    required this.gift
});
  @override
  List<Object?> get props => [productNames,address,total,gift];

}