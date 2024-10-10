import '../entity/table.dart';

class TableResponse {
  List<TableItemResponse> items;

  TableResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => TableItemResponse.fromJson(e)).toList() ?? [];

  List<Table> toEntity() => items
      .map((e) => Table(
          id: e.id ?? 0,
          tableNumber: e.tableNumber,
          tableName: e.tableName,
          tableCapacity: e.tableCapacity ?? 0,
          tableStatus: e.tableStatus ?? 0))
      .toList();
}

class TableItemResponse {
  int? id;
  int? tableNumber;
  String? tableName;
  int? tableCapacity;
  int? tableStatus;

  TableItemResponse({this.id, this.tableNumber, this.tableName, this.tableCapacity, this.tableStatus});

  TableItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tableNumber = json['tableNumber'];
    tableName = json['tableName'];
    tableCapacity = json['tableCapacity'];
    tableStatus = json['tableStatus'];
  }
}
