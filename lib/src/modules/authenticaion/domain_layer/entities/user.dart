import 'package:equatable/equatable.dart';
class User extends Equatable {
  final String address;
  final String phone;
  final String name;
  final String email;

  const User({
    required this.phone,
    required this.address,
    required this.name,
    required this.email,
  });
  @override
  List<Object?> get props => [phone,address,name,email];

}