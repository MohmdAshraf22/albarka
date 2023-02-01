import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/color_manager.dart';
import '../bloc/main_bloc.dart';

Widget ItemGrid(Item item, BuildContext context, index) {
  var bloc = MainBloc.get(context);
  return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
    return InkWell(
      onTap: () {
        bloc.add(ChangeGridMainEvent(context: context, index: index));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.black12,
                elevation: 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(8),
                        bottomStart: Radius.circular(8)),
                  ),
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                          child: Icon(
                        item.image,
                        size: 40.sp,
                        color: ColorManager.white,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorManager.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

class Item {
  Item({required this.title, required this.image});
  final String title;
  final IconData image;
}

List<Item> items = [
  Item(title: "المنيو", image: Icons.fastfood),
  Item(title: "سلة المشتريات", image: Icons.shopping_cart_rounded),
  Item(title: "اطلب ديليفري", image: Icons.motorcycle_rounded),
  Item(title: "العروض", image: Icons.local_offer_rounded),
  Item(title: "تابعنا على الفيس بوك", image: Icons.facebook),
];
