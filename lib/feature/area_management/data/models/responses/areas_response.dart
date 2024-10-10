import 'package:json_annotation/json_annotation.dart';
import '../entity/area_item.dart';
import 'city_areas_response.dart';

part 'areas_response.g.dart';

@JsonSerializable()
class AreaItemResponse {
  int? id;
  String? branchId;
  int? areaId;
  num? minOrderAmount;
  num? deliveryFee;
  num? maxDeliveryDiscount;
  AreaItemDetailsResponse? area;

  AreaItemResponse(
      {this.id, this.branchId, this.areaId, this.minOrderAmount, this.deliveryFee, this.maxDeliveryDiscount, this.area});

  factory AreaItemResponse.fromJson(Map<String, dynamic> json) => _$AreaItemResponseFromJson(json);

  AreaItem toEntity() => AreaItem(
      id: id ?? 0,
      areaId: areaId ?? 0,
      minOrderAmount: minOrderAmount ?? 0,
      deliveryFee: deliveryFee ?? 0,
      maxDeliveryDiscount: maxDeliveryDiscount ?? 0,
      areaDetails: area?.toEntity());
}

class AreasResponse {
  List<AreaItemResponse> items;

  AreasResponse.fromJson(List<dynamic>? json)
      : items = json
                ?.map(
                  (e) => AreaItemResponse.fromJson(e),
                )
                .toList() ??
            [];

  List<AreaItem> toEntity() => items
      .map(
        (e) => e.toEntity(),
      )
      .toList();
}
