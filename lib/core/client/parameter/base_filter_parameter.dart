import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class BaseFilterListParameter extends MerchantBranchParameter {
  final List<BaseFilterInfoParameter> filterInfo;
  final List<BaseSortInfoParameter> orderInfo;
  final List<String> columns;
  final int page;
  final int count;

  BaseFilterListParameter(
      {this.filterInfo = const [],
      this.orderInfo = const [],
      this.columns = const [],
      this.page = 1,
      this.count = 35});

  Map<String, dynamic> filterToJson() => {
        ...?super.branchToJson(),
        "filterInfos": filterInfo.map((e) => e.toJson()).toList(),
        "orderInfos": orderInfo.map((e) => e.toJson()).toList(),
        "columns": columns,
        "count": count,
        "page": page
      };
}

class BaseFilterInfoParameter {
  final dynamic logical;
  final String propertyName;
  final dynamic value;
  final dynamic operator;

  const BaseFilterInfoParameter({
    required this.logical,
    this.propertyName = '',
    this.value = '',
    required this.operator,
  });

  Map<String, dynamic> toJson() =>
      {"logical": logical, "propertyName": propertyName, "value": value, "operator": operator};
}

class BaseSortInfoParameter {
  final dynamic orderType;
  final String property;

  const BaseSortInfoParameter({
    this.orderType = '',
    this.property = '',
  });

  Map<String, dynamic> toJson() => {"orderType": orderType, "property": property};
}
