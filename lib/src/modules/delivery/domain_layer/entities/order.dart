import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final List<String> productDetails;
  final String address;
  final double total;
  final String gift;
  final String phone;
  double? latitude;
  double? longitude;
  final bool howToPaid;

  Order({
    required this.productDetails,
    required this.address,
    required this.total,
    required this.gift,
    required this.phone,
    required this.howToPaid,
    this.latitude,
    this.longitude,
  });
  @override
  List<Object?> get props => [productDetails,address,total,gift,phone,howToPaid];

}