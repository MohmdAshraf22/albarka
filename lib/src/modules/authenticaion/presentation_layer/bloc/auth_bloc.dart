import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/constants.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../main/presentation_layer/screens/main_screen.dart';
import '../../domain_layer/use_cases/forget_password_usecase.dart';
import '../../domain_layer/use_cases/login_with_email&pass_usecase.dart';
import '../../domain_layer/use_cases/register_with_email&pass_usecase.dart';
import '../components/components.dart';
import '../screens/login.dart';
import '../screens/register.dart';
import '../screens/register2.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);
  List<Widget> pages = [
    const LoginScreen(),
    const RegisterScreen(),
  ];
  int currentIndex = 0;
  String email="";
  String password="";
  String name="";

  Widget currentPages = const LoginScreen();

  /// change visibility
  bool currentVisibility = false;
  IconData currentSuffix = Icons.visibility;
  TextInputType type = TextInputType.visiblePassword;
  void changeVisibility()
  {
    currentVisibility = !currentVisibility;
    currentSuffix = currentVisibility ? Icons.visibility : Icons.visibility_off;
    type = currentVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }

  AuthBloc(AuthInitial authInitial) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is ChangeButtonAuthenticationEvent) {
        currentPages = pages[event.index];
        currentIndex = event.index;
        emit(ChangeButtonAuthState(index: event.index));
      }
      else if (event is ChangeVisibilityEvent) {
        changeVisibility();
        emit(ChangeVisibilityAuthState(isVisible: currentVisibility));
      }
      else if (event is LoginEvent) {
        emit(LoginLoadingAuthState());
        final result = await LoginWithEmailAndPassUseCase(sl()).excute(
          email: event.email,
          password: event.password,
        );
        uId = await CacheHelper.getData(key: 'uid');
        result.fold((l) {
          errorToast(msg: l.message!);
          emit(LoginErrorAuthState());
        }, (r)  {
          NavigationManager.pushAndRemove(event.context, MainScreen());
          defaultToast(msg: "Login Successfully");
          emit(LoginSuccessfulAuthState(context: event.context , uid: uId!));
        });
      }
      else if (event is RegisterPhaseOneEvent1) {
           NavigationManager.push(event.context, RegisterScreen2(
             email: event.email,
             name: event.name,
             password: event.password,
           ));
           emit(RegisterPhaseOneSuccessfulAuthState(context: event.context));
           print("name = $name");
           print("password = $password");
           print("email = $email");
      }
      else if (event is RegisterPhasetwoEvent) {
        emit(RegisterPhasetwoLoadingAuthState());

        final result = await RegisterWithEmailAndPassUseCase(sl()).excute(
          phone: event.phone,
          address: event.address,
          email: event.email, password: event.password, name: event.name
        );
        uId = await CacheHelper.getData(key: 'uid') ?? '' ;
        result.fold((l) {
          errorToast(msg: l.message!);
          emit(RegisterErrorAuthState());
        }, (r)  {
          defaultToast(msg: "Account Created Successfully");
          NavigationManager.pushAndRemove(event.context, MainScreen());
          emit(RegisterPhasetwoSuccessfulAuthState(context: event.context ,  uid: uId!));
        });
      }
      else if (event is ForgetPasswordAuthEvent) {
        final result = await ForgetPasswordUseCase(sl()).excute(email: event.email).catchError((e)
        {
         // print("forgetPassword from bloc error " + e.toString());
        });
        result.fold((l) {
          errorToast(msg: l.message!);
        }, (r) {
          defaultToast(msg: "Please Check Your Mail");
        });
      }
    });
  }
}