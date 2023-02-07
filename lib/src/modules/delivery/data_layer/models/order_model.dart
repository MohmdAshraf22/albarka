import '../../domain_layer/entities/order.dart';

class OrderModel extends Order {
  OrderModel(
      {required super.productNames,
        required super.address,
        required super.phone,
        required super.total,
        required super.howToPaid,
        super.longitude,
        super.latitude,
        required super.gift});
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      productNames: List<String>.from(json['productNames'].map((e) => e)),
      address: json['address'],
      phone: json['phone'],
      total: json['total'],
      gift: json['gift'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      howToPaid: json['howToPaid'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'productNames': productNames,
      'address': address,
      'total': total,
      'longitude': longitude,
      'latitude': latitude,
      'gift': gift,
      'howToPaid': howToPaid,
    };
  }
}
