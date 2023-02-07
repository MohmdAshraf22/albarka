import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen2 extends StatelessWidget {
  String email;
  String password;
  String name;
  RegisterScreen2({required this.name,required this.email,required this.password,super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var addressController = TextEditingController();
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
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب رقم الهاتف ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.sp)),
                                prefixIcon:
                                    const Icon(Icons.phone),
                                labelText: 'الهاتف'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.name,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'من فضلك اكتب عنوانك';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.home),
                                labelText: 'العنوان'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          State is! RegisterPhasetwoLoadingAuthState
                              ? MaterialButton(
                                  onPressed: () {
                                    // int phone =
                                    // int.parse(phoneController.text);
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(RegisterPhasetwoEvent(
                                          email: email,
                                          password: password,
                                          name: name,
                                          phone: phoneController.text,
                                          address: addressController.text,
                                          context: context));
                                    }
                                  },
                                  color: ColorManager.primary,
                                  minWidth: double.infinity,
                                  height: 1.h,
                                  elevation: 5,
                                  child: Text(
                                    'تسجيل الحساب',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                  ),
                                )
                              : const CircularProgressIndicator()
                        ]),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
