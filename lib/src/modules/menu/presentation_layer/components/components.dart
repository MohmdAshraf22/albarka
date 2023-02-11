import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../../data_layer/models/product_model.dart';
import '../bloc/menu_bloc.dart';

Widget ItemProductGrid(ProductModel product, context, index) {
  var bloc = MenuBloc.get(context);
  return BlocBuilder<MenuBloc, MenuState>(
    builder: (context, state) {
      return InkWell(
        onTap: () {
          bloc.add(NavigationToProductsDetailsEvent(
              collectionIndex: bloc.changeTab,
              index: index,
              product: product,
              context: context));
        },
        child: Card(
          elevation: 7,
          color: ColorManager.card,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(8),
                  bottomStart: Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 105.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.card,
                    image: product.image == ''
                        ? null
                        : DecorationImage(
                      image: NetworkImage(
                        product.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorManager.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  child: Text(
                    "${product.newPrice}  ج.م",
                    style: TextStyle(
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


Widget itemCartList(ProductModel product, context, index) {
  var bloc = MenuBloc.get(context);
  return BlocBuilder<MenuBloc, MenuState>(
    builder: (context, state) {
      return Dismissible(
        key: Key(product.name),
        background: Padding(
          padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(20.sp),
                topStart: Radius.circular(20.sp),
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          bloc.add(DeleteProductFromCartEvent(product));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
          child: Card(
            elevation: 4.sp,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(20.sp),
                topStart: Radius.circular(20.sp),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.sp,
                  height: 80.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(20.sp),
                      topStart: Radius.circular(20.sp),
                    ),
                    color: ColorManager.card,
                    image: product.image == ''
                        ? null
                        : DecorationImage(
                      image: NetworkImage(
                        product.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      "${product.newPrice}",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "${product.number}",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 15.sp),
                ),
                SizedBox(
                  width: 12.sp,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// class ViewImage extends StatelessWidget {
//   dynamic image;
//   ViewImage({required this.image,super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(20.0.sp),
//         child: image is Uri ? Image.network(image,width: double.infinity,height: double.infinity,):
//         Image.asset("assets/image/$image"),
//       ),
//     );  }
// }
