import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? image;
  final String name;
  String? imagePaths;
  int? number;
  bool? isEditAddToCart = false;
  final String describe;
  final double oldPrice;
  final double points;
  final double newPrice;
   Product(
      { this.image,
      required this.name,
      this.imagePaths,
      this.number,
      this.isEditAddToCart,
      required this.describe,
      required this.newPrice,
      required this.points,
      required this.oldPrice});

  @override
  List<Object?> get props => [image, name,imagePaths,number, describe,newPrice,points, oldPrice];
}
