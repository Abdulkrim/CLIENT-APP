import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/main_category/main_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/sub_category/sub_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/product_details_dialog_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/item_rich_text_widget.dart';

import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';

import '../blocs/products/products_bloc.dart';

class ProductGridCardWidget extends StatelessWidget {
  final Product product;
  final Function() onItemTap;

  const ProductGridCardWidget({Key? key, required this.product, required this.onItemTap})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap:  onItemTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NetworkImageRounded(url: product.logo, width: 150, height: 150),
            context.sizedBoxHeightExtraSmall,
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
    );
  }
}
