import 'package:albaraka/src/modules/delivery/domain_layer/entities/location.dart';

class LocationModel extends myLocation{
   LocationModel({ super.longitude,  super.latitude});
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}