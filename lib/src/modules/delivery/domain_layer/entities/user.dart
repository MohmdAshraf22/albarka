import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String address;
  final String phone;
  const User({
    required this.phone,
    required this.address,
  });
  @override
  List<Object?> get props => [phone,address];

}