import 'package:albaraka/src/modules/menu/domain_layer/entities/order.dart';

class OrderModel extends Order {
  const OrderModel(
      {required super.productNames,
      required super.address,
      required super.total,
      required super.gift});
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        productNames: List<String>.from(json['productNames'].map((e) => e)),
        address: json['address'],
        total: json['total'],
        gift: json['gift'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'productNames':productNames,
      'address': address,
      'total': total,
      'gift': gift,
    };
  }
}
