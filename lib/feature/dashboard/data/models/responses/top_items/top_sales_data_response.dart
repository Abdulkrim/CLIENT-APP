import 'package:json_annotation/json_annotation.dart';

import '../../entities/top_sale_item.dart';

part 'top_sales_data_response.g.dart';

@JsonSerializable()
class TopSalesDataResponse {
  int? count;
  String? itemNameAR;
  String? itemNameTR;
  String? itemNameFR;
  num? percentage;
  String? itemNameEN;
  int? itemId;

  TopSalesDataResponse({this.count,
    this.itemNameAR,
    this.itemNameTR,
    this.itemNameFR,
    this.percentage,
    this.itemNameEN,
    this.itemId});

  factory TopSalesDataResponse.fromJson(Map<String, dynamic> json) => _$TopSalesDataResponseFromJson(json);

}


class TopSalesResponse {
  List<TopSalesDataResponse> data;


  TopSalesResponse.fromJson(List<dynamic>? json)
      : data = json?.map((e) => TopSalesDataResponse.fromJson(e)).toList() ?? [];

  List<TopSaleItem> toEntity() =>
      data.map((e) =>
          TopSaleItem(count: e.count ?? 0,
              itemNameAR: e.itemNameAR ?? '',
              itemNameTR: e.itemNameTR ?? '',
              itemNameFR: e.itemNameFR ?? '',
              percentage: e.percentage ?? 0,
              itemNameEN: e.itemNameEN ?? '',
              itemId: e.itemId ?? 0)).toList();

}