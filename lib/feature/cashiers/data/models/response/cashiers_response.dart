import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';

import 'cashier_info_response.dart';

part 'cashiers_response.g.dart';

@JsonSerializable()
class CashiersResponse {
  @JsonKey(name: 'value')
  List<CashierInfoResponse>? data;
  int? currentPageNumber;
  int? totalPageCount;
  String? message;
  int? statusCode;

  CashiersResponse(
      {this.data = const [], this.currentPageNumber, this.totalPageCount, this.message, this.statusCode});

  factory CashiersResponse.fromJson(Map<String, dynamic> json) => _$CashiersResponseFromJson(json);

  CashierListInfo toEntity() => CashierListInfo(
        currentPageNumber: currentPageNumber ?? 1,
        totalPageCount: totalPageCount ?? 1,
        cashiers: data
                ?.map((e) => Cashier(
                      id: e.cashierId ?? '0',
                      name: e.cashierName ?? '',
                      status: e.isActive ?? false,
                      totalSales: e.total ?? 0,
                      cashierRole: e.roleName ?? '',
                      cashierRoleId: e.posRoleId ?? 0,
                    ))
                .toList() ??
            [],
      );
}
