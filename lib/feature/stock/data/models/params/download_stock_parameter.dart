class DownloadStockParameter {
  List<dynamic>? filterInfos;
  List<dynamic>? orderInfos;
  List<dynamic>? columns;
  int count;
  int page;

  DownloadStockParameter({
    this.filterInfos,
    this.orderInfos,
    this.columns,
    this.count = 0,
    this.page = 0,
  });

  factory DownloadStockParameter.fromJson(Map<String, dynamic> json) {
    return DownloadStockParameter(
      filterInfos: json['filterInfos'] as List<dynamic>?,
      orderInfos: json['orderInfos'] as List<dynamic>?,
      columns: json['columns'] as List<dynamic>?,
      count: json['count'] as int,
      page: json['page'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'filterInfos': filterInfos,
        'orderInfos': orderInfos,
        'columns': columns,
        'count': count,
        'page': page,
      };
}
