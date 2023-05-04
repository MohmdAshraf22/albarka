import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/auth_bloc.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 1;
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var addressController = TextEditingController();
    var oldPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var bloc = AuthBloc.get(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(i == 1){
          bloc.add(const GetMyDataEvent());
        }
        i = 0;
        if(state is GetMyDataSuccessState){
          nameController.text = bloc.userModel!.name;
          emailController.text = bloc.userModel!.email;
          phoneController.text = bloc.userModel!.phone;
          addressController.text = bloc.userModel!.address;
        }
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white10,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: state is! GetMyDataLoadingState ?Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0.sp),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'تعديل حسابك ',
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
                                    borderRadius:
                                        BorderRadius.circular(15.sp)),
                                prefixIcon:
                                    const Icon(Icons.person_3_outlined),
                                labelText: 'الاسم'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب رقم الهاتف';
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك اكتب العنوان ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.sp)),
                                prefixIcon:
                                    const Icon(Icons.home),
                                labelText: 'العنوان'),
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
                                    borderRadius:
                                        BorderRadius.circular(15.sp)),
                                prefixIcon: const Icon(Icons.email_outlined),
                                labelText: 'الايميل'),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          TextFormField(
                            controller: oldPasswordController,
                            keyboardType: bloc.oldType,
                            obscureText: bloc.oldVisibility,
                            decoration: InputDecoration (
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.sp)),
                                prefixIcon:  const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      bloc.add(const OldChangeVisibilityEvent());
                                    },
                                    icon: Icon(bloc.oldSuffix)
                                ),
                                labelText: 'كلمة السر'),
                            validator: (value) {
                              if (value!.isEmpty)
                              {
                                return 'من فضلك اكتب كلمة السر ';
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
                                bloc.add(UpdateMyDataEvent(
                                  context: context,
                                  address: addressController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  oldPassword: oldPasswordController.text,
                                ));
                              },
                              child: Text(
                                "تعديل",
                                style: TextStyle(
                                    color: ColorManager.white,
                                    fontSize: 15.sp),
                              ),
                            ),
                          ),

                          TextButton(
                              onPressed: (){
                                bloc.add(NavigationToChangePassScreenEvent(context: context));
                              },
                              child: const Text(
                                "هل تريد تغير كلمة السر ؟"
                              ),)
                        ]),
                  ),
                ),
              ),
            ): const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
