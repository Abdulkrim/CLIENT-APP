import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';

import '../../entity/package_pricing_with_culture.dart';
import '../plans/currency_info_response.dart';

part 'feature_price_with_culture_response.g.dart';

@JsonSerializable()
class FeaturePricingWithCultureResponse {
  int? id;
  int? currencyId;
  CurrencyInfoResponse? currency;
  num? price;

  FeaturePricingWithCultureResponse({this.id, this.currencyId, this.currency, this.price});

  factory FeaturePricingWithCultureResponse.fromJson(Map<String, dynamic> json) =>
      _$FeaturePricingWithCultureResponseFromJson(json);

  PackagePricingWithCulture toEntity() => PackagePricingWithCulture(
      id: id ?? 0,
      currency: currency?.toEntity() ?? CurrencyInfo(id: 0, name: '', symbol: ''),
      price: price ?? 0);
}
