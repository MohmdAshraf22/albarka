import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';
import '../bloc/menu_bloc.dart';
import '../components/components.dart';

const List<String> list = <String>['كشري', 'مشويات', 'حلويات'];

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 1;
    var bloc = MenuBloc.get(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (i == 1) {
            bloc.add(const GetKosharyEvent());
            bloc.add(const GetMashweyatEvent());
            bloc.add(const GetHalaweyatEvent());
          }
          i = 0;
          return Scaffold(
              appBar: AppBar(
                title: const Text("المنيو"),
              ),
              body: ContainedTabBarView(
                initialIndex: 0,
                onChange: (changeTab) {
                  bloc.add(ChangeTabBarEvent(changeTab: changeTab));
                },
                tabs: [
                  Text(
                    "كشري",
                    style: TextStyle(color: ColorManager.black),
                  ),
                  Text(
                    "مشويات",
                    style: TextStyle(color: ColorManager.black),
                  ),
                  Text(
                    "حلويات",
                    style: TextStyle(color: ColorManager.black),
                  ),
                ],
                views: [
                  state is! GetKosharyLoadingState
                      ? RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(const GetKosharyEvent());
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              mainAxisSpacing: 20.sp,
                              padding: EdgeInsets.all(22.sp),
                              crossAxisCount: 2,
                              childAspectRatio: 6.5.sp / 9.0.sp,
                              crossAxisSpacing: 20.sp,
                              children:
                                  List.generate(bloc.koshary.length, (index) {
                                return ItemProductGrid(
                                    bloc.koshary[index], context, index);
                              }),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  state is! GetMashweyatLoadingState
                      ? RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(const GetMashweyatEvent());
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              mainAxisSpacing: 20.sp,
                              padding: EdgeInsets.all(22.sp),
                              crossAxisCount: 2,
                              childAspectRatio: 6.5.sp / 9.0.sp,
                              crossAxisSpacing: 20.sp,
                              children:
                                  List.generate(bloc.mashweyat.length, (index) {
                                return ItemProductGrid(
                                    bloc.mashweyat[index], context, index);
                              }),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  state is! GetHalaweyatLoadingState
                      ? RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(const GetHalaweyatEvent());
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              mainAxisSpacing: 20.sp,
                              padding: EdgeInsets.all(22.sp),
                              crossAxisCount: 2,
                              childAspectRatio: 6.5.sp / 9.0.sp,
                              crossAxisSpacing: 20.sp,
                              children:
                                  List.generate(bloc.halaweyat.length, (index) {
                                return ItemProductGrid(
                                    bloc.halaweyat[index], context, index);
                              }),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ));
        },
      ),
    );
  }
}
