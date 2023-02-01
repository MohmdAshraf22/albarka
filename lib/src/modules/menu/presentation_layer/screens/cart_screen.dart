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
        return Scaffold(
          appBar: AppBar(
            leading: bloc.isSelected
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      bloc.add(BackToDefaultBeforeSelectEvent());
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.arrow_back_sharp),
                    onPressed: () {
                      Navigator.of(context).pop();
                      bloc.isSelected = false;
                    },
                  ),
            title: Row(
              children: [
                if (!bloc.isSelected) const Text("سلة المشتريات"),
                if (bloc.isSelected)
                  Text("${bloc.selectProducts.length} / ${bloc.cartItems.length}"),
                const Spacer(),
                if (bloc.selectProducts.isNotEmpty && bloc.isSelected)
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BlocBuilder<MenuBloc, MenuState>(
                                  builder: (context, state) {
                                    return AlertDialog(
                                      content: bloc.selectProducts.length > 1
                                          ? const Text(
                                          "سيتم إزالة هذه المنتجات من سلة المشتريات ؟")
                                          : const Text(
                                          "سيتم إزالة هذا المنتج من سلة المشتريات ؟"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("الغاء")),
                                        TextButton(
                                            onPressed: () {
                                              bloc.add(DeleteProductFromCartEvent());
                                              Navigator.pop(context);
                                            },
                                            child: const Text("إزالة")),
                                      ],
                                    );
                                  });
                            });
                      },
                      icon: const Icon(Icons.delete)),
                if (bloc.isSelected)
                  IconButton(
                      onPressed: () {
                          bloc.add(SelectAllProductEvent());
                      },
                      icon: const Icon(Icons.select_all)),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 20.sp,
              padding: EdgeInsets.all(22.sp),
              crossAxisCount: 2,
              childAspectRatio: 6.5.sp / 9.0.sp,
              crossAxisSpacing: 20.sp,
              children: List.generate(bloc.cartItems.length, (index) {
                return ItemCartGrid(bloc.cartItems[index], context, index);
              }),
            ),
          ),
        );
      },
    );
  }
}
