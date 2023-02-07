
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class ChangeButtonAuthenticationEvent extends AuthEvent {
  final int index;

  ChangeButtonAuthenticationEvent({required this.index});
  @override
  List<Object?> get props => [index];
}

class LoginEvent extends AuthEvent {
  String email;
  String password;
  final context;
  LoginEvent(
      {required this.email, required this.password, required this.context});

  @override
  List<Object?> get props => [email, password, context];
}

class RegisterPhasetwoEvent extends AuthEvent {
  String email;
  String password;
  String name;
  String address;
  String phone;
  final BuildContext context;
  RegisterPhasetwoEvent(
      {required this.email,
      required this.password,
      required this.address,
      required this.phone,
      required this.name,
      required this.context});
  @override
  List<Object?> get props => [email, password, context,address,phone];
}
class RegisterPhaseOneEvent1 extends AuthEvent {
  String email;
  String password;
  String name;
  final BuildContext context;
  RegisterPhaseOneEvent1(
      {required this.email,
      required this.password,
      required this.name,
      required this.context});
  @override
  List<Object?> get props => [email, password, context];
}

class ChangeVisibilityEvent extends AuthEvent {
  bool isVisible;
  ChangeVisibilityEvent(this.isVisible);
  @override
  // TODO: implement props
  List<Object?> get props => [isVisible];
}

class ForgetPasswordAuthEvent extends AuthEvent {
  final String email;
  ForgetPasswordAuthEvent({required this.email});
  @override
  List<Object?> get props => [email];
}
