
import 'package:json_annotation/json_annotation.dart';

part 'device_data_response.g.dart';

@JsonSerializable()
class DeviceDataResponse{

  final int? id;
  final String? name;
  final String? logo;


  const DeviceDataResponse({this.id , this.name, this.logo});

  factory DeviceDataResponse.fromJson(Map<String , dynamic> json) => _$DeviceDataResponseFromJson(json);
}