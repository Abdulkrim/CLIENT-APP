import 'package:merchant_dashboard/feature/subscription/data/models/entity/currency_info.dart';

class PackagePricingWithCulture {
  final int id;
  final CurrencyInfo currency;

  final num? _monthlyBasePrice;
  num get monthlyBasePrice => _monthlyBasePrice ?? 0;

  final num? _yearlyBasePrice;
  num get yearlyBasePrice => _yearlyBasePrice ?? 0;

  bool get hasDiscountMonthly => switch (_monthlyPriceWithDiscount) {
        (num? monthlyWithDiscount) when monthlyWithDiscount == null => false,
        (num? monthlyWithDiscount) when monthlyWithDiscount != null && monthlyWithDiscount == 0 => false,
        (num? monthlyWithDiscount)
            when monthlyWithDiscount != null && monthlyWithDiscount != _monthlyBasePrice =>
          true,
        _ => false
      };

  bool get hasDiscountYearly => switch (_yearlyPriceWithDiscount) {
        (num? yearlyWithDiscount) when yearlyWithDiscount == null => false,
        (num? yearlyWithDiscount) when yearlyWithDiscount != null && yearlyWithDiscount == 0 => false,
        (num? yearlyWithDiscount) when yearlyWithDiscount != null && yearlyWithDiscount != _yearlyBasePrice =>
          true,
        _ => false
      };

  final num? _monthlyPriceWithDiscount;
  num get monthlyPriceWithDiscount => switch (_monthlyPriceWithDiscount) {
        (num? monthlyWithDiscount) when monthlyWithDiscount == null => _monthlyBasePrice ?? 0,
        (num? monthlyWithDiscount) when monthlyWithDiscount != null && monthlyWithDiscount == 0 =>
          _monthlyBasePrice ?? 0,
        (num? monthlyWithDiscount)
            when monthlyWithDiscount != null && monthlyWithDiscount != _monthlyBasePrice =>
          monthlyWithDiscount,
        (num? monthlyWithDiscount)
            when monthlyWithDiscount != null && monthlyWithDiscount == _monthlyBasePrice =>
          monthlyWithDiscount,
        _ => 0
      };

  final num? _yearlyPriceWithDiscount;
  num get yearlyPriceWithDiscount => switch (_yearlyPriceWithDiscount) {
        (num? yearlyWithDiscount) when yearlyWithDiscount == null => _yearlyBasePrice ?? 0,
        (num? yearlyWithDiscount) when yearlyWithDiscount != null && yearlyWithDiscount == 0 =>
          _yearlyBasePrice ?? 0,
        (num? yearlyWithDiscount) when yearlyWithDiscount != null && yearlyWithDiscount != _yearlyBasePrice =>
          yearlyWithDiscount,
        (num? yearlyWithDiscount) when yearlyWithDiscount != null && yearlyWithDiscount == _yearlyBasePrice =>
          yearlyWithDiscount,
        _ => 0
      };

  final num? _subFeaturePrice;
  num get subFeaturePrice => _subFeaturePrice ?? 0;

  PackagePricingWithCulture(
      {required this.id,
      required this.currency,
      num? price,
      num? monthlyBasePrice,
      num? yearlyBasePrice,
      num? monthlyPriceWithDiscount,
      num? yearlyPriceWithDiscount})
      : _subFeaturePrice = price,
        _monthlyBasePrice = monthlyBasePrice,
        _monthlyPriceWithDiscount = monthlyPriceWithDiscount,
        _yearlyBasePrice = yearlyBasePrice,
        _yearlyPriceWithDiscount = yearlyPriceWithDiscount;
}
