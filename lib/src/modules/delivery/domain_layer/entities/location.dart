import 'package:equatable/equatable.dart';

class myLocation extends Equatable{
   double? longitude = 0;
   double? latitude = 0;
   myLocation({ this.longitude, this.latitude});

  @override
  List<Object?> get props => [];
}