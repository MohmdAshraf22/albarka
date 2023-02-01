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