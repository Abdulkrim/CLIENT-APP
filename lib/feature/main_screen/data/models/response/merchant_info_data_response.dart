import 'package:json_annotation/json_annotation.dart';

part 'merchant_info_data_response.g.dart';

@JsonSerializable()
class MerchantInfoDataResponse {
  final String? id;
  final String? name;

  MerchantInfoDataResponse(this.id, this.name);

  factory MerchantInfoDataResponse.fromJson(Map<String, dynamic> json) => _$MerchantInfoDataResponseFromJson(json);
}