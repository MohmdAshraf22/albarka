import 'package:albaraka/src/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/menu_bloc.dart';
import '../components/components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen() : super();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        var bloc = MenuBloc.get(context);
        double total = 0;
        int test = 0;
        String gift = '';
        List<String> productDetails = [];
        bloc.cartItems.forEach((element) {
          total += element.newPrice * element.number!;
          if(element.quantity != null) {
            test = element.number! ~/ element.quantity!;
          }
          gift = (test > 0)?' $test ${element.offerDetails} ': 'no';
          productDetails.add(" ${element.number}  ${element.name} ");
        });
        return Scaffold(
          appBar: AppBar(
            title: const Text("سلة المشتريات"),
          ),

          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) =>
                        itemCartList(bloc.cartItems[index], context, index),
                    itemCount: bloc.cartItems.length),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
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
                          labelText: 'كوبون',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "السعر الإجمالي :",
                          style: TextStyle(
                              fontSize: 15.sp, color: ColorManager.primary),
                        ),
                        const Spacer(),
                        Text(
                          "${total.toStringAsFixed(1)}  ج.م",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          bloc.add(NavigationToDeliveryScreenEvent(
                              context: context,
                              total: total,
                              gift: gift,
                              productDetails: productDetails));
                        },
                        child: Text(
                          "شراء ",
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                        ),
                      ),
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
