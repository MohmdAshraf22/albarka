import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../bloc/auth_bloc.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var oldPasswordController = TextEditingController();
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
                          Text(
                            'تغير كلمة السر ',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: oldPasswordController,
                            keyboardType: bloc.oldType,
                            obscureText: bloc.oldVisibility,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      bloc.add(
                                          const OldChangeVisibilityEvent());
                                    },
                                    icon: Icon(bloc.oldSuffix)),
                                labelText: 'كلمة السر'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب كلمة السر ';
                              }
                              // if (passwordController.text ==
                              //     oldPasswordController.text) {
                              //   return 'كلمة السر القديمة هي هي الجديدة يسطا';
                              // }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: bloc.type,
                            obscureText: bloc.currentVisibility,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      bloc.add(const ChangeVisibilityEvent());
                                    },
                                    icon: Icon(bloc.currentSuffix)),
                                labelText: 'كلمة السر الجديده'),
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
                            keyboardType: bloc.confirmType,
                            obscureText: bloc.confirmCurrentVisibility,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      bloc.add(
                                          const ConfirmChangeVisibilityEvent());
                                    },
                                    icon: Icon(bloc.confirmCurrentSuffix)),
                                labelText: 'تأكيد كلمة السر الجديده'),
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
                          Container(
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(20.sp)),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  bloc.add(ChangePassEvent(
                                    context: context,
                                    newPassword: passwordController.text,
                                    oldPassword: oldPasswordController.text));
                                }
                              },
                              child: Text(
                                "تغير",
                                style: TextStyle(
                                    color: ColorManager.white, fontSize: 15.sp),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
