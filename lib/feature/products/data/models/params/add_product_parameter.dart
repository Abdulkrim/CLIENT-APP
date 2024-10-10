import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

import '../entity/item_type.dart';

class AddProductParameter extends MerchantBranchParameter {
  final int subCategoryId;
  final String productEnName;
  final ItemType productType;
  final String productPrice;
  final String maxPrice;
  final String minPrice;
  final String productQuantity;
  final String description;
  final String barcode;
  final bool productIsActive;
  final String buyingPrice;
  final String discount;
  final bool isOpenPrice;
  final bool isOpenQuantity;
  final XFile? logo;
  final int offerTypeId;
  final bool canHaveStock;
  final int? initialQuantity;
  final int unitOfMeasureId;
  final List<int>? addOnsItemIds;
  final List<String>? visibleApplications;
  final String? redeemPoint;
  final String? rechargePoint;
  final int? suggestionImageId;

  AddProductParameter({
    required this.subCategoryId,
    required this.buyingPrice,
    required this.productEnName,
    required this.description,
    required this.productPrice,
    required this.productQuantity,
    required this.productIsActive,
    required this.productType,
    required this.isOpenQuantity,
    required this.minPrice,
    required this.maxPrice,
    required this.isOpenPrice,
    required this.barcode,
    required this.offerTypeId,
    required this.canHaveStock,
    required this.initialQuantity,
    required this.unitOfMeasureId,
    required this.discount,
    required this.addOnsItemIds,
    required this.visibleApplications,
    this.logo,
    this.redeemPoint,
    this.rechargePoint,
    this.suggestionImageId,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'SubCategoryId': subCategoryId,
        'ItemNameEN': productEnName,
        'quantity': productQuantity,
        'IsActive': productIsActive,
        'BuyingPrice': buyingPrice,
        'FacePrice': productPrice,
        'IsOpenPrice': isOpenPrice,
        'IsOpenQuantity': isOpenQuantity,
        'MaximumPrice': maxPrice,
        'MinimumPrice': minPrice,
        'BarCode': barcode,
        'description': description,
        'OfferTypeId': offerTypeId,
        'CanHaveStock': canHaveStock,
        'InitialQuantity': initialQuantity,
        'UnitOfMeasureId': unitOfMeasureId,
        'DiscountAmount': discount,
        'RedeemPoint': redeemPoint,
        'RechargePoint': rechargePoint,
        'ItemTypeID': productType.id,
        if (addOnsItemIds != null && !productType.isAddOnType) 'RelatedItemIds': addOnsItemIds,
        if (visibleApplications != null && visibleApplications!.isNotEmpty) 'VisibleApplications': visibleApplications!,
        if (suggestionImageId != null) 'ImageId': suggestionImageId
      };
}
