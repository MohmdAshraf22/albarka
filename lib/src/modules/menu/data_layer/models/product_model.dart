import '../../domain_layer/entities/product.dart';
class ProductModel extends Product {
   ProductModel(
      {super.image,
      required super.name,
      super.imagePaths,
      required super.newPrice,
      super.number,
      super.isEditAddToCart,
      required super.describe,
      required super.points,
      required super.oldPrice});
  factory ProductModel.fromJson(Map <String , dynamic> json) {
    return ProductModel(
        image: json['image'],
        name: json['name'],
        imagePaths: json['imagePaths'],
        describe: json['describe'],
        points: json['points'],
        oldPrice: json['oldPrice'],
        newPrice: json['newPrice']);
  }
  Map<String, dynamic> toJson(){
    return {
      'image' : image,
      'name' : name,
      'imagePaths' : imagePaths,
      'describe' : describe,
      'oldPrice' : oldPrice,
      'points' : points,
      'newPrice' : newPrice,
    };
  }
}
