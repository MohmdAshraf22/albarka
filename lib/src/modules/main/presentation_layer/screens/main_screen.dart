import 'package:albaraka/src/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../bloc/main_bloc.dart';
import '../components/components.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final bloc = MainBloc.get(context);
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250.sp,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                           ColorManager.primary,
                           ColorManager.blueWhite,
                          ]
                      )
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: const Text('الأعدادات '),
                  onTap: () {
                    bloc.add(NavigationToUpdateScreenEvent(context: context));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text('تسجيل الخروج'),
                  onTap: () {
                    bloc.add(LogOutEvent(context: context));
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.asset('assets/images/main.png',
                      width: double.infinity, height: 200.sp),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    children: List.generate(items.length, (index) {
                      return ItemGrid(items[index], context, index);
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
