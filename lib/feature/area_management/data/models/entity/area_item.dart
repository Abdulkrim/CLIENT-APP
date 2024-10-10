import 'package:equatable/equatable.dart';

import 'area_details.dart';

class AreaItem {
  final int id;
  final int areaId;
  final num minOrderAmount;
  final num deliveryFee;
  final num maxDeliveryDiscount;
  final AreaDetails? areaDetails;

  const AreaItem({required this.id,
    required this.areaId,
    required this.minOrderAmount,
    required this.deliveryFee,
    required this.maxDeliveryDiscount,
    required this.areaDetails});

  AreaItem copyWith(AreaItem item) =>
      AreaItem(id: id,
          areaId: areaId,
          minOrderAmount: item.minOrderAmount,
          deliveryFee: item.deliveryFee,
          maxDeliveryDiscount: item.maxDeliveryDiscount,
          areaDetails: areaDetails);
}
