import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var bloc = AuthBloc.get(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white10,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 45.sp,
                            backgroundImage:
                                const AssetImage('assets/images/logo.svg'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Text(
                            'اكونت جديد',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب اسمك';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.person_3_outlined),
                                labelText: 'الاسم'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب الايميل';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.email_outlined),
                                labelText: 'الايميل'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: bloc.newType,
                            obscureText: bloc.newVisibility,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      bloc.add(const ChangeVisibilityEvent());
                                    },
                                    icon: Icon(bloc.newSuffix)),
                                labelText: 'كلمة السر'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب كلمة السر';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.lock_outline),
                                labelText: 'تأكيد كلمة السر'),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  passwordController.text !=
                                      confirmPasswordController.text) {
                                return 'من فضلك تأكد من كتابة كلمة السر تاني';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    bloc.add(RegisterPhaseOneEvent1(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        context: context));
                                  }
                                },
                                child: Text(
                                  'كمل',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
