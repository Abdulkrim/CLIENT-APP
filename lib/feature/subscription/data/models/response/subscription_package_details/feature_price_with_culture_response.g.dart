// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_price_with_culture_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturePricingWithCultureResponse _$FeaturePricingWithCultureResponseFromJson(
        Map<String, dynamic> json) =>
    FeaturePricingWithCultureResponse(
      id: (json['id'] as num?)?.toInt(),
      currencyId: (json['currencyId'] as num?)?.toInt(),
      currency: json['currency'] == null
          ? null
          : CurrencyInfoResponse.fromJson(
              json['currency'] as Map<String, dynamic>),
      price: json['price'] as num?,
    );

Map<String, dynamic> _$FeaturePricingWithCultureResponseToJson(
        FeaturePricingWithCultureResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currencyId': instance.currencyId,
      'currency': instance.currency,
      'price': instance.price,
    };
