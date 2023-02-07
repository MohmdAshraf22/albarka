// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../../core/utils/values_manager.dart';
import '../bloc/auth_bloc.dart';
import '../components/components.dart';

class ForgetPassword extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20.sp,
                    horizontal: 15.sp), // width * .051),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height:  60.sp,
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: IconButton(
                              onPressed: () {
                                NavigationManager.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          )),
                      //SizedBox(height: height * .037),
                      Text(
                        'نسيت الباسورد ؟',
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(
                        height:  5.sp,
                      ),
                      Text(
                        'اكتب الايميل وهنبعتلك ايميل لتأكيد حسابك',
                        style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height:  5.sp),
                      defaultFormField(
                        prefix: Icons.email,
                        label: 'الايميل',
                        controller: emailController,
                        validatorText: "من فضلك اكتب الايميل",
                      ),
                      SizedBox(height: 20.sp),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print("forgetPassword from screen");
                              AuthBloc.get(context).add(
                                  ForgetPasswordAuthEvent(
                                      email: emailController.text));
                            }
                          },
                          child: Text(
                            'ابعت ايميل',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: ColorManager.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
