import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

import '../../../../../widgets/network_image_rounded_widget.dart';
import '../../../data/models/entity/products.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/sub_category/sub_category_bloc.dart';
import '../product_details_widgets/category_details_dialog.dart';

class MainCategoryItemWidget extends StatelessWidget {
  const MainCategoryItemWidget({
    super.key,
    required this.mainCategory,
  });

  final ProductsCategory mainCategory;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () => Get.dialog(MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<MainCategoryBloc>(context),
            ),
            BlocProvider.value(
              value: BlocProvider.of<SubCategoryBloc>(context),
            ),
          ],
          child: CategoryDetailsDialog(
            mainCatId: mainCategory.categoryId,
            catArName: mainCategory.categoryNameAR,
            catTrName: mainCategory.categoryNameTR,
            catFrName: mainCategory.categoryNameFR,
            catEnName: mainCategory.categoryNameEN,
            catIsActive: mainCategory.isActive,
            catLogo: mainCategory.imageUrl,
            visibleApplications: mainCategory.visibleApplications,
          ))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                NetworkImageRounded(
                  url: mainCategory.imageUrl,
                  width: double.infinity,
                  height: 110,
                ),
                context.sizedBoxHeightMicro,
                Text(
                  mainCategory.categoryName,
                  style: context.textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Visibility(
                visible: !mainCategory.isActive,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration:
                      BoxDecoration(color: const Color(0x74c2c2c2), borderRadius: BorderRadius.circular(8)),
                )),
          ],
        ),
      ),
    );
  }
}
