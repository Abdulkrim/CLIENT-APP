import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/main_category/main_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/sub_category/sub_category_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/search_box_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../product_details_widgets/category_details_dialog.dart';
import '../sub_categories/sub_categories_list_widget.dart';

class MobileSubCategories extends StatefulWidget {
  const MobileSubCategories({super.key});

  @override
  State<MobileSubCategories> createState() => _MobileSubCategoriesState();
}

class _MobileSubCategoriesState extends State<MobileSubCategories> {
  @override
  void initState() {
    super.initState();
    context.read<SubCategoryBloc>().add(const ClearSearchResultEvent());
    context.read<MainCategoryBloc>().add(const GetMainCategoriesEvent());
  }

  int selectedMainCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      context.watch<MenuDrawerCubit>().selectedPageContent.text,
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  RoundedBtnWidget(
                    onTap: () {
                      if (selectedMainCategoryId > 0) {
                        Get.dialog(MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: BlocProvider.of<MainCategoryBloc>(context),
                              ),
                              BlocProvider.value(
                                value: BlocProvider.of<SubCategoryBloc>(context),
                              ),
                            ],
                            child: const CategoryDetailsDialog(
                              isSub: true,
                            )));
                      } else {
                        context.showCustomeAlert(S.current.plzSelectCategory);
                      }
                    },
                    btnText: S.current.addSubCategory,
                    btnIcon: SvgPicture.asset(Assets.iconsAddStock, color: Colors.white, height: 20),
                    wrapWidth: true,
                    height: 35,
                  ),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              SizedBox(
                width: 350,
                child: SearchBoxWidget(
                  searchTextController: context.read<SubCategoryBloc>().searchController,
                  hint: S.current.searchBySubNme,
                  onSearchTapped: (String? text) {
                    if (text != null && text.isNotEmpty) {
                      context.read<SubCategoryBloc>().add(SearchSubCategoriesEvent(text));
                    } else {
                      context.read<SubCategoryBloc>().add(const ClearSearchResultEvent());
                    }
                  },
                ),
              ),
              context.sizedBoxHeightExtraSmall,
              Expanded(child: SubCategoriesListWidget(
                onMainCatgoryTap: (mainCategoryId) {
                  selectedMainCategoryId = mainCategoryId;
                },
              ))
            ],
          ),
        ],
      ),
    ));
  }
}
