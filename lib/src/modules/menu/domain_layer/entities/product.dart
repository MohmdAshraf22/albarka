import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? image;
  final String name;
  String? imagePaths;
  int? number;
  final String describe;
  final double oldPrice;
  final double points;
  final double newPrice;
  String? offerDetails;
  int? quantity;
  Product(
      {this.image,
      required this.name,
      this.imagePaths,
      this.number,
      this.offerDetails,
      this.quantity,
      required this.describe,
      required this.newPrice,
      required this.points,
      required this.oldPrice});

  @override
  List<Object?> get props =>
      [image, name, imagePaths, describe, newPrice, points, oldPrice,offerDetails,quantity];
}
