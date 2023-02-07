
import '../../domain_layer/entities/user.dart';

class UserModel extends User{
  const UserModel({required super.phone, required super.address});
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        phone: json['phone'],
        address: json['address']);
  }
}