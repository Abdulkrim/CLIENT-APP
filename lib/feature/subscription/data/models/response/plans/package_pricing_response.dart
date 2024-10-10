import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';

import '../../entity/package_pricing_with_culture.dart';
import 'currency_info_response.dart';

part 'package_pricing_response.g.dart';

@JsonSerializable()
class PackagePricingWithCultureResponse {
  int? id;
  int? currencyId;
  CurrencyInfoResponse? currency;
  num? monthlyBasePrice;
  num? yearlyBasePrice;
  num? monthlyPriceWithDiscount;
  num? yearlyPriceWithDiscount;

  PackagePricingWithCultureResponse(
      {this.id,
      this.currencyId,
      this.currency,
      this.monthlyBasePrice,
      this.yearlyBasePrice,
      this.monthlyPriceWithDiscount,
      this.yearlyPriceWithDiscount});

  factory PackagePricingWithCultureResponse.fromJson(Map<String, dynamic> json) =>
      _$PackagePricingWithCultureResponseFromJson(json);

  PackagePricingWithCulture toEntity() => PackagePricingWithCulture(
      id: id ?? 0,
      currency: currency?.toEntity() ?? CurrencyInfo(id: 0, name: '', symbol: ''),
      monthlyBasePrice: monthlyBasePrice ?? 0,
      yearlyBasePrice: yearlyBasePrice ?? 0,
      monthlyPriceWithDiscount: monthlyPriceWithDiscount ?? 0,
      yearlyPriceWithDiscount: yearlyPriceWithDiscount ?? 0);
}
