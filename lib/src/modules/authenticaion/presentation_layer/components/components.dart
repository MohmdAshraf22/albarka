
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';


TextFormField defaultFormField(
    {required String label,
      required IconData prefix,
      IconData? suffix,
      GlobalKey? key,
      String? validatorText,
      TextInputType? type,
      void Function()? suffixFunction,
      bool obscureText = false,
      required TextEditingController controller}) {
  TextFormField textFormField = TextFormField (
    validator: (value) {
      if (value!.isEmpty) {
        return validatorText;
      }
      return null;
    },
    keyboardType: type,
    obscureText: obscureText,
    controller: controller,
    cursorColor: ColorManager.black,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix,  ),
      suffix: suffix != null
          ? InkWell(
        child: Icon(suffix),
        onTap: suffixFunction,
      )
          : const SizedBox(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.sp),
        borderSide: BorderSide(width: 2.sp, color: ColorManager.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.sp),
        borderSide: BorderSide(width: 2, color: ColorManager.primary),
      ),
      labelText: label,
      labelStyle: TextStyle(color: ColorManager.black),
    ),
    style: TextStyle(color: ColorManager.black),
  );
  return TextFormField(
    // key: key,
    // validator: (value)
    // {
    //
    //   if (controller.text == null){
    //     return validatorText ;
    //   }
    //   else {
    //     return null;
    //   }
    // },
    validator: (value) {
      if (value!.isEmpty) {
        return validatorText;
      }
      return null;
    },
    keyboardType: type,
    obscureText: obscureText,
    controller: controller,
    cursorColor: ColorManager.black,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix,),
      suffix: suffix != null
          ? InkWell(
        child: Icon(suffix),
        onTap: suffixFunction,
      )
          : const SizedBox(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.sp),
        borderSide: BorderSide(width: 2.sp, color: ColorManager.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.sp),
        borderSide: BorderSide(width: 2.sp, color: ColorManager.primary),
      ),
      labelText: label,
      labelStyle: TextStyle(color: ColorManager.black),
    ),
    style: TextStyle(color: ColorManager.primary),
  );
}

defaultToast ({required String msg , })
{

  Fluttertoast.showToast(msg: msg , backgroundColor: ColorManager.primary, textColor: ColorManager.white, toastLength: Toast.LENGTH_SHORT ,  );
}
errorToast ({required String msg ,}){
  Fluttertoast.showToast(msg: msg , backgroundColor: ColorManager.error, textColor: ColorManager.white, toastLength: Toast.LENGTH_SHORT ,  );

}

