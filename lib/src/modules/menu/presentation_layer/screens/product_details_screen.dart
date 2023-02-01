import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../data_layer/models/product_model.dart';
import '../bloc/menu_bloc.dart';

class ProductDetails extends StatelessWidget {
  ProductModel product;
  int index;
  int collectionIndex;
  ProductDetails(this.index, this.product, this.collectionIndex, {super.key});
  @override
  Widget build(BuildContext context) {
    var bloc = MenuBloc.get(context);
    if(product.number != null) {
      bloc.number = product.number!;
    }else {
      bloc.number = 1;
    }
    product.isEditAddToCart ??= false;
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: double.infinity,
                            height: 320.sp,
                            decoration: BoxDecoration(
                              color: ColorManager.card,
                              image: DecorationImage(
                                  image: NetworkImage(product.image!),
                                  fit: BoxFit.cover),
                            )),
                        Container(
                          width: 30.sp,
                          height: 30.sp,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_sharp,
                                color: ColorManager.white,
                                size: 17.sp,
                              ),
                              onPressed: () {
                                NavigationManager.pop(context);
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(product.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text("${product.oldPrice}\$",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      product.describe,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                        "تحصل علي ${product.points} من النقاط عند حصولك علي ${product.name}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20.sp,
                    ),
                    product.isEditAddToCart! ?
                    TextButton(
                      onPressed: (){
                        print("${product.isEditAddToCart!}     ${product.name}");
                        bloc.add(EditAddProductToCartEvent(product: product));
                        print("${product.isEditAddToCart!}     ${product.name}");
                      },
                      child: const Text("تم الإضافة الى سلة المشتريات هل تريد التعديل ؟"),
                    ) :
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                              bloc.add(PlusNumberOfProductEvent());
                            },
                                icon: Icon(Icons.add_circle,color: ColorManager.primary,size: 28.sp,)),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Text('${bloc.number}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),
                            SizedBox(
                              width: 10.sp,
                            ),
                            IconButton(onPressed: (){
                              if(bloc.number > 1) {
                                bloc.add(MinusNumberOfProductEvent());
                              }
                            },
                                icon: Icon(Icons.remove_circle,color: ColorManager.primary,size: 28.sp)),
                          ],
                        ),
                        SizedBox(
                          height: 15.sp,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if(!bloc.cartItems.contains(product)) {
                                bloc.add(AddProductToCartEvent(product: product));
                              }
                            },
                            child: Text(
                              "إضافة الى سلة المشتريات",
                              style: TextStyle(
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
