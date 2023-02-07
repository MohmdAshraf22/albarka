part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class ChangeButtonAuthState extends AuthState {
  final int index;
  ChangeButtonAuthState({required this.index});

  @override
  List<Object> get props => [index];
}

class ChangeVisibilityAuthState extends AuthState {
  final bool isVisible;

  ChangeVisibilityAuthState({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}

/// register states

class RegisterPhasetwoLoadingAuthState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class RegisterPhasetwoSuccessfulAuthState extends AuthState {
  String uid ;
  BuildContext context;
  RegisterPhasetwoSuccessfulAuthState({required this.context , required this.uid});
  @override
  List<Object?> get props =>  [context];
}
class RegisterErrorAuthState extends AuthState {
  @override

  List<Object?> get props => throw UnimplementedError();
}
class RegisterPhaseOneSuccessfulAuthState extends AuthState {
  BuildContext context;
  RegisterPhaseOneSuccessfulAuthState({required this.context});
  @override
  List<Object?> get props =>  [context];
}


/// login states

class LoginLoadingAuthState extends AuthState {
  @override

  List<Object?> get props => [];
}

class LoginSuccessfulAuthState extends AuthState {
 String  uid ;
  BuildContext context;
  LoginSuccessfulAuthState({required this.context ,required this.uid});
  @override

  List<Object?> get props => [context];
}

class LoginErrorAuthState extends AuthState {
  @override

  List<Object?> get props => [];
}

/// forget password states

class SendEmailSuccessfulAuthState extends AuthState {
  @override
  List<Object?> get props => throw UnimplementedError ();
}
