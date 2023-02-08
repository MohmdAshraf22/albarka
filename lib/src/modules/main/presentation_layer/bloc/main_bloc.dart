import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/local/shared_prefrences.dart';
import '../../../../core/services/constants.dart';
import '../../../../core/utils/navigation_manager.dart';
import '../../../authenticaion/presentation_layer/screens/login.dart';
import '../../../authenticaion/presentation_layer/screens/update.dart';
import '../../../delivery/presentation_layer/screens/delivery_screen.dart';
import '../../../menu/presentation_layer/screens/cart_screen.dart';
import '../../../menu/presentation_layer/screens/menu_screen.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static MainBloc get(BuildContext context) =>
      BlocProvider.of<MainBloc>(context);
  List<Widget> pages = [
    const MenuScreen(),
    const CartScreen(),
  ];
  MainBloc(MainInitial mainInitial) : super(MainInitial()) {
    on<MainEvent>((event, emit) async{
      if (event is ChangeGridMainEvent) {
        if (event.index == 3) {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        } else {
          NavigationManager.push(event.context, pages[event.index]);
          emit(ChangeGridMainState(index: event.index));
        }
      } else if (event is LogOutEvent) {
        CacheHelper.removeData(key: 'uid').then((value) {
          if (value) {
            NavigationManager.pushAndRemove(event.context, const LoginScreen());
          }
        });
      }
      else if (event is NavigationToUpdateScreenEvent) {
        NavigationManager.push(event.context, const UpdateScreen());
        emit(NavigationToUpdateScreenState(context:event.context));
      }
    });
  }
}
