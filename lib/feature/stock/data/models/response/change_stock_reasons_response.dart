import 'package:merchant_dashboard/feature/stock/data/models/entity/decrease_reason.dart';

class ChangeStockReasonsResponse {
  List<ReasonResponse> list;

  ChangeStockReasonsResponse.fromJson(List<dynamic>? json)
      : list = json?.map((e) => ReasonResponse.fromJson(e)).toList() ?? [];

  List<DecreaseReasons> toEntity() => list.map((e) => DecreaseReasons(e.id ?? 0, e.name ?? '')).toList();
}

class ReasonResponse {
  int? id;
  String? name;

  ReasonResponse({this.id, this.name});

  ReasonResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
