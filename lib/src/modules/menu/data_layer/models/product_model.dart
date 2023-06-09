import '../../domain_layer/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {String? image,
      required String name,
      String? imagePaths,
      required double newPrice,
      int? number,
      String? offerDetails,
      int? quantity,
      required String describe,
      required double points,
      required double oldPrice})
      : super(
          describe: describe,
          name: name,
          newPrice: newPrice,
          oldPrice: oldPrice,
          points: points,
          image: image,
          imagePaths: imagePaths,
          number: number,
          offerDetails: offerDetails,
          quantity: quantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        image: json['image'],
        name: json['name'],
        imagePaths: json['imagePaths'],
        describe: json['describe'],
        points: json['points'],
        oldPrice: json['oldPrice'],
        offerDetails: json['offerDetails'],
        quantity: json['quantity'],
        newPrice: json['newPrice']);
  }
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'imagePaths': imagePaths,
      'describe': describe,
      'oldPrice': oldPrice,
      'points': points,
      'newPrice': newPrice,
      'offerDetails': offerDetails,
      'quantity': quantity,
    };
  }
}
