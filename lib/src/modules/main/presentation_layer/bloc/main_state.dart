part of 'main_bloc.dart';
abstract class MainState extends Equatable {
  const MainState();
}

class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}
class ChangeGridMainState extends MainState {
  final int index;
  ChangeGridMainState({required this.index});
  @override
  List<Object?> get props => [index];
}
class LogOutState extends MainState {
  final BuildContext context;

  LogOutState({required this.context});
  @override
  List<Object?> get props => [context];
}
class NavigationToUpdateScreenState extends MainState {
  final BuildContext context;
  const NavigationToUpdateScreenState(
      {required this.context});

  @override
  List<Object?> get props => [context];
}

