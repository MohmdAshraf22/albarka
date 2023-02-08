import 'package:albaraka/src/modules/authenticaion/presentation_layer/screens/forget_password.dart';
import 'package:albaraka/src/modules/authenticaion/presentation_layer/screens/register.dart';
import 'package:albaraka/src/modules/main/presentation_layer/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/constants.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../bloc/auth_bloc.dart';
import '../components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var bloc = AuthBloc.get(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isVisible = bloc.newVisibility;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white10,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0.sp),
            child: Center(
              child: SingleChildScrollView(
                  child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45.sp,
                      backgroundImage: const AssetImage('assets/images/logo.svg'),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    const Text(
                      'تسجيل الدخول',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'لازم تكتب ايميل';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp)),
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: 'الإيميل',
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: isVisible
                          ? TextInputType.text
                          : TextInputType.visiblePassword,
                      obscureText: isVisible ? false : true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'لازم تكتب باسورد';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                              onPressed: () {
                                print(
                                    'bool isVisible = bloc.currentVisibility;');
                                bloc.add(const ChangeVisibilityEvent());
                              },
                              icon: isVisible
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          labelText: 'الباسورد'),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              NavigationManager.push(context, ForgetPassword());
                            },
                            child: Text(
                              'نسيت الباسورد ؟',
                              style: TextStyle(
                                color: ColorManager.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ))),
                    SizedBox(
                      height: 10.sp,
                    ),

                    //     state is !ShopLoginLoadingState?
                    State is! LoginLoadingAuthState
                        ? Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  bloc.add(LoginEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context));
                                }
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                    color: ColorManager.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp),
                              ),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('معندكش أكونت ؟ '),
                        TextButton(
                            onPressed: () {
                              NavigationManager.push(
                                  context, const RegisterScreen());
                            },
                            child: const Text('سجل دلوقت'))
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}
