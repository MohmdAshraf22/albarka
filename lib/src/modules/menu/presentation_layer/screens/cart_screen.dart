import 'package:albaraka/src/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../bloc/menu_bloc.dart';
import '../components/components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        var bloc = MenuBloc.get(context);
        double total = 0;
         bloc.cartItems.forEach((element) {
          total += element.newPrice * element.number!;
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text("سلة المشتريات"),
            // leading: bloc.isSelected
            //     ? IconButton(
            //         icon: const Icon(Icons.close),
            //         onPressed: () {
            //           bloc.add(const BackToDefaultBeforeSelectEvent());
            //         },
            //       )
            //     : IconButton(
            //         icon: const Icon(Icons.arrow_back_sharp),
            //         onPressed: () {
            //           Navigator.of(context).pop();
            //           bloc.isSelected = false;
            //         },
            //       ),
            // title: Row(
            //   children: [
            //     if (!bloc.isSelected)
            //     if (bloc.isSelected)
            //       Text(
            //           "${bloc.selectProducts.length} / ${bloc.cartItems.length}"),
            //     const Spacer(),
            //     if (bloc.selectProducts.isNotEmpty && bloc.isSelected)
            //       IconButton(
            //           onPressed: () {
            //             showDialog(
            //                 context: context,
            //                 builder: (BuildContext context) {
            //                   return BlocBuilder<MenuBloc, MenuState>(
            //                       builder: (context, state) {
            //                     return AlertDialog(
            //                       content: bloc.selectProducts.length > 1
            //                           ? const Text(
            //                               "سيتم إزالة هذه المنتجات من سلة المشتريات ؟")
            //                           : const Text(
            //                               "سيتم إزالة هذا المنتج من سلة المشتريات ؟"),
            //                       actions: [
            //                         TextButton(
            //                             onPressed: () {
            //                               Navigator.pop(context);
            //                             },
            //                             child: const Text("الغاء")),
            //                         TextButton(
            //                             onPressed: () {
            //                               bloc.add(
            //                                   const DeleteProductFromCartEvent());
            //                               Navigator.pop(context);
            //                             },
            //                             child: const Text("إزالة")),
            //                       ],
            //                     );
            //                   });
            //                 });
            //           },
            //           icon: const Icon(Icons.delete)),
            //     if (bloc.isSelected)
            //       IconButton(
            //           onPressed: () {
            //             bloc.add(const SelectAllProductEvent());
            //           },
            //           icon: const Icon(Icons.select_all)),
            //   ],
            // ),
          ),
          body: Column(
            children: [

              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) => itemCartList(bloc.cartItems[index], context, index),
                    itemCount: bloc.cartItems.length),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 10.sp),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: ColorManager.card,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    SizedBox(
                      height: 35.sp,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                       // controller: ,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          prefixIcon: const Icon(Icons.discount),
                          labelText: 'كوبون',),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("السعر الإجمالي :",style: TextStyle(
                          fontSize: 15.sp,
                          color: ColorManager.primary
                        ),),
                        const Spacer(),
                        Text("$total LE",style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(10.sp),
                    ),
                      child: MaterialButton(
                        onPressed: (){},
                      child: Text("شراء ",style: TextStyle(
                          color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp
                      ),),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
