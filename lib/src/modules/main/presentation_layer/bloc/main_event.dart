part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}
class ChangeGridMainEvent extends MainEvent {
  final int index;
  final BuildContext context;

  ChangeGridMainEvent({required this.index,required this.context});
  @override
  List<Object?> get props => [index,context];
}