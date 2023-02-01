import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../bloc/main_bloc.dart';
import '../components/components.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc,MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.asset('assets/images/main.png',width: double.infinity,height: 200.sp),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    children: List.generate(items.length,(index)
                    {
                      return ItemGrid(items[index],context,index);
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    ,);
  }
}
