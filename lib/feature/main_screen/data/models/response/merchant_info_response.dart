import 'package:merchant_dashboard/feature/main_screen/data/models/entity/merchant_info.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/response/merchant_info_data_response.dart';

class MerchantInfoResponse{
  final List<MerchantInfoDataResponse> merchantInfoList;

  MerchantInfoResponse({required this.merchantInfoList});

  factory MerchantInfoResponse.fromJson(List<dynamic> json) =>
      MerchantInfoResponse(merchantInfoList: json.map((e) => MerchantInfoDataResponse.fromJson(e)).toList());

  List<MerchantInfo> toEntity() => merchantInfoList
      .map((e) => MerchantInfo(merchantId: e.id ?? '-', merchantName: e.name ?? '-' , userName: ''))
      .toList();
}