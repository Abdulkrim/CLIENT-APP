import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/product_details_dialog_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/item_rich_text_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:get/get.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../widgets/network_image_rounded_widget.dart';
import '../blocs/main_category/main_category_bloc.dart';
import '../blocs/products/products_bloc.dart';
import '../blocs/sub_category/sub_category_bloc.dart';

class ProductListCardWidget extends StatelessWidget {
  final Product product;


  final Function() onItemTap;
  const ProductListCardWidget({Key? key, required this.product, required this.onItemTap}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onItemTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NetworkImageRounded(url: product.logo, width: 150, height: 150),
            context.sizedBoxWidthExtraSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ItemRichTextWidget(
                    rText: '${S.current.productEngName} - ',
                    lText: product.productName,
                  ),
                  ItemRichTextWidget(
                    rText: '${S.current.price} - ',
                    lText: product.managedPrice.toString(),
                  ),
                  Visibility(
                    visible: hideForThisV,
                    child: ItemRichTextWidget(
                      rText: '${S.current.quantity} - ',
                      lText: product.quantity.toString(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
