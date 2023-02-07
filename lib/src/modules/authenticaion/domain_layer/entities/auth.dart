// import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:equatable/equatable.dart';

class Auth extends Equatable
{
  String uid;
  String token;

  Auth({
    required this.uid,
    required this.token,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token, uid];
}
