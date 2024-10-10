// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_pricing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagePricingWithCultureResponse _$PackagePricingWithCultureResponseFromJson(
        Map<String, dynamic> json) =>
    PackagePricingWithCultureResponse(
      id: (json['id'] as num?)?.toInt(),
      currencyId: (json['currencyId'] as num?)?.toInt(),
      currency: json['currency'] == null
          ? null
          : CurrencyInfoResponse.fromJson(
              json['currency'] as Map<String, dynamic>),
      monthlyBasePrice: json['monthlyBasePrice'] as num?,
      yearlyBasePrice: json['yearlyBasePrice'] as num?,
      monthlyPriceWithDiscount: json['monthlyPriceWithDiscount'] as num?,
      yearlyPriceWithDiscount: json['yearlyPriceWithDiscount'] as num?,
    );

Map<String, dynamic> _$PackagePricingWithCultureResponseToJson(
        PackagePricingWithCultureResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currencyId': instance.currencyId,
      'currency': instance.currency,
      'monthlyBasePrice': instance.monthlyBasePrice,
      'yearlyBasePrice': instance.yearlyBasePrice,
      'monthlyPriceWithDiscount': instance.monthlyPriceWithDiscount,
      'yearlyPriceWithDiscount': instance.yearlyPriceWithDiscount,
    };
