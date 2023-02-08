import 'package:albaraka/src/modules/authenticaion/data_layer/models/user_model.dart';
import 'package:albaraka/src/modules/authenticaion/domain_layer/use_cases/get_user_data_use_case.dart';
import 'package:albaraka/src/modules/authenticaion/presentation_layer/screens/change_pass.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/constants.dart';
import '../../../../core/services/dep_injection.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../main/presentation_layer/screens/main_screen.dart';
import '../../domain_layer/use_cases/change_pass_use_case.dart';
import '../../domain_layer/use_cases/forget_password_usecase.dart';
import '../../domain_layer/use_cases/login_with_email&pass_usecase.dart';
import '../../domain_layer/use_cases/register_with_email&pass_usecase.dart';
import '../../domain_layer/use_cases/update_user_data_use_case.dart';
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
  Widget currentPages = const LoginScreen();
  UserModel? userModel;

  /// change old password visibility
  bool newVisibility = false;
  IconData newSuffix = Icons.visibility;
  TextInputType newType = TextInputType.visiblePassword;
  /// change old password visibility
  bool oldVisibility = false;
  IconData oldSuffix = Icons.visibility;
  TextInputType oldType = TextInputType.visiblePassword;
  void changeVisibility() {
    newVisibility = !newVisibility;
    newSuffix =
        !newVisibility ? Icons.visibility : Icons.visibility_off;
    newType =
        !newVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }
  void oldChangeVisibilityVoid() {
    oldVisibility = !oldVisibility;
    oldSuffix = !oldVisibility ? Icons.visibility : Icons.visibility_off;
    oldType =
        !oldVisibility ? TextInputType.text : TextInputType.visiblePassword;
  }

  AuthBloc(AuthInitial authInitial) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is ChangeButtonAuthenticationEvent) {
        currentPages = pages[event.index];
        currentIndex = event.index;
        emit(ChangeButtonAuthState(index: event.index));
      } else if (event is ChangeVisibilityEvent) {
        changeVisibility();
        emit(ChangeVisibilityState(isVisible: newVisibility));
      } else if (event is OldChangeVisibilityEvent) {
        oldChangeVisibilityVoid();
        emit(OldChangeVisibilityState(isVisible: newVisibility));
      } else if (event is LoginEvent) {
        emit(const LoginLoadingAuthState());
        final result = await LoginWithEmailAndPassUseCase(sl()).excute(
          email: event.email,
          password: event.password,
        );
        result.fold((l) {
          errorToast(msg: l.message!);
          emit(LoginErrorAuthState());
        }, (r) async{
          NavigationManager.pushAndRemove(event.context, MainScreen());
          defaultToast(msg: "تم تسحيل الدخول بنجاح");
          uId = await CacheHelper.getData(key: 'uid');
          emit(LoginSuccessfulAuthState(context: event.context, uid: uId!));
        });
      } else if (event is RegisterPhaseOneEvent1) {
        NavigationManager.push(
            event.context,
            RegisterScreen2(
              email: event.email,
              name: event.name,
              password: event.password,
            ));
        emit(RegisterPhaseOneSuccessfulAuthState(context: event.context));
      } else if (event is RegisterPhasetwoEvent) {
        emit(RegisterPhasetwoLoadingAuthState());
        final result = await RegisterWithEmailAndPassUseCase(sl()).excute(
            phone: event.phone,
            address: event.address,
            email: event.email,
            password: event.password,
            name: event.name);
        uId = await CacheHelper.getData(key: 'uid') ?? '';
        result.fold((l) {
          errorToast(msg: l.message!);
          emit(RegisterErrorAuthState());
        }, (r) {
          defaultToast(msg: "تم إنشاء حساب جديد بنجاح");
          NavigationManager.pushAndRemove(event.context, MainScreen());
          emit(RegisterPhasetwoSuccessfulAuthState(
              context: event.context, uid: uId!));
        });
      } else if (event is ForgetPasswordAuthEvent) {
        final result = await ForgetPasswordUseCase(sl())
            .excute(email: event.email);
        result.fold((l) {
          errorToast(msg: l.message!);
        }, (r) {
          defaultToast(msg: "من فضلك تحقق من الايميل ");
        });
      } else if (event is GetMyDataEvent) {
        emit(GetMyDataLoadingState());
        final result = await GetDataUserUseCase(sl()).get();
        result.fold((l) {}, (r) {
          userModel = r;
          emit(GetMyDataSuccessState());
        });
      } else if (event is UpdateMyDataEvent) {
        final result = await UpdateDataUserUseCase(sl()).update(
            phone: event.phone,
            address: event.address,
            name: event.name,
            oldPassword: event.oldPassword,
            email: event.email);
        result.fold((l) {
          errorToast(msg: l.message!);
          emit(UpdateMyDataErrorState());
        }, (r) {
          defaultToast(msg: "تم تحديث البيانات بنجاح");
          NavigationManager.pop(event.context);
          emit(UpdateMyDataSuccessState(context: event.context));
        });
      } else if (event is ChangePassEvent) {
        final result = await ChangePasswordUseCase(sl()).change(
            oldPassword: event.oldPassword, newPassword: event.newPassword);
        result.fold((l) {
          errorToast(msg: l.message!);
        }, (r) {
          defaultToast(msg: "تم تغير كلمة السر بنجاح");
          NavigationManager.pop(event.context);
          emit(ChangePassScreenSuccessState(context:event.context));
        });
      } else if (event is NavigationToChangePassScreenEvent) {
        NavigationManager.push(event.context, const ChangePassScreen());
        emit(NavigationToChangePassScreenState(context:event.context));
      }
    });
  }
}
