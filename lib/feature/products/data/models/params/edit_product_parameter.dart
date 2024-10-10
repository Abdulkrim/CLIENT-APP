import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';

import '../../../../dashboard/data/models/params/merchant_branch_parameter.dart';

class EditProductParameter extends MerchantBranchParameter {
  final int itemId;
  final int subCategoryId;
  final String productEnName;
  final String description;
  final ItemType productType;
  final String productPrice;
  final String buyingPrice;
  final String maxPrice;
  final String minPrice;
  final String productQuantity;
  final String barcode;
  final String discount;
  final bool productIsActive;
  final bool isOpenPrice;
  final bool isOpenQuantity;
  final XFile? logo;
  final int? suggestionImageId;
  final int offerTypeId;
  final bool canHaveStock;
  final int unitOfMeasureId;
  final List<int>? addOnsItemIds;
  final String? redeemPoint;
  final String? rechargePoint;
  final List<String>? hiddenApplications;

  EditProductParameter({
    required this.itemId,
    required this.subCategoryId,
    required this.productEnName,
    required this.description,
    required this.productPrice,
    required this.buyingPrice,
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
    required this.unitOfMeasureId,
    required this.discount,
    required this.addOnsItemIds,
    this.hiddenApplications,
    this.redeemPoint,
    this.rechargePoint,
    this.logo,
    this.suggestionImageId,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'ItemId': itemId,
        'SubCategoryId': subCategoryId,
        'quantity': productQuantity,
        'IsActive': productIsActive,
        'FacePrice': productPrice,
        'ItemNameEN': productEnName,
        'BuyingPrice': buyingPrice,
        'IsOpenPrice': isOpenPrice,
        'IsOpenQuantity': isOpenQuantity,
        'MaximumPrice': maxPrice,
        'MinimumPrice': minPrice,
        'BarCode': barcode,
        'description': description,
        'OfferTypeId': offerTypeId,
        'CanHaveStock': canHaveStock,
        'UnitOfMeasureId': unitOfMeasureId,
        'DiscountAmount': discount,
        'ItemTypeID': productType.id,
        'RedeemPoint': redeemPoint ?? '0',
        'RechargePoint': rechargePoint ?? '0',
        if (addOnsItemIds != null && !productType.isAddOnType) 'RelatedItemIds': addOnsItemIds,
        if (hiddenApplications != null && hiddenApplications!.isNotEmpty)
          'VisibleApplications': hiddenApplications!,
        if (suggestionImageId != null) 'ImageId': suggestionImageId
      };
}
