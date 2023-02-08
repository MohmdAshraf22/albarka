
import '../../domain_layer/entities/user.dart';

class UserModel extends User{
  const UserModel({required super.phone,
    required super.address,
    required super.email,
    required super.name});
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        phone: json['phone'],
        name: json['name'],
        email: json['email'],
        address: json['address']);
  }
  Map<String, dynamic> toJson(){
    return {
      'phone' : phone,
      'name' : name,
      'email' : email,
      'address' : address,
    };
  }
}