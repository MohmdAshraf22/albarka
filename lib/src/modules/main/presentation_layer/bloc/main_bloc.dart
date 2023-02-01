import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/navigation_manager.dart';
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
    on<MainEvent>((event, emit) {
      if (event is ChangeGridMainEvent) {
        NavigationManager.push(event.context,
        pages[event.index]);
        emit(ChangeGridMainState(index: event.index));
      }
    });
  }
}
