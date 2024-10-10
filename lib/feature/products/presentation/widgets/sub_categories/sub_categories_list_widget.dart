import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/network_image_rounded_widget.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../data/models/entity/products.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/sub_category/sub_category_bloc.dart';
import '../product_details_widgets/category_details_dialog.dart';

class SubCategoriesListWidget extends StatefulWidget {
  const SubCategoriesListWidget(
      {super.key, required this.onMainCatgoryTap, this.subCategoryHeight = 110, this.subCategoryWidth});
  final Function(int selectedMainCategoryId) onMainCatgoryTap;

  final double? subCategoryWidth;
  final double? subCategoryHeight;

  @override
  State<SubCategoriesListWidget> createState() => _SubCategoriesListWidgetState();
}

class _SubCategoriesListWidgetState extends State<SubCategoriesListWidget> {
  int selectedMainCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    final List<ProductsCategory> mainCategories =
        context.select((MainCategoryBloc bloc) => bloc.mainCategories);

    final List<SubCategory> searchResult = context.select((SubCategoryBloc bloc) => bloc.searchResult);

    return (!context.select((SubCategoryBloc bloc) => bloc.isSearchMode))
        ? ListView.builder(
            itemCount: mainCategories.length,
            itemBuilder: (_, index) => SubCategoriesWidget(
              mainCategoryId: mainCategories[index].categoryId,
              mainCategoryImage: mainCategories[index].imageUrl,
              mainCategoryName: mainCategories[index].categoryNameEN,
              isExpanded: selectedMainCategoryId == mainCategories[index].categoryId,
              onItemTapped: (isExpanded) {
                if (!isExpanded) {
                  setState(() {
                    selectedMainCategoryId = mainCategories[index].categoryId;
                  });

                  context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(selectedMainCategoryId));
                  widget.onMainCatgoryTap(selectedMainCategoryId);
                } else {
                  setState(() {
                    selectedMainCategoryId = 0;
                  });
                }
              },
              subCategoryWidth: widget.subCategoryWidth,
              subCategoryHeight: widget.subCategoryHeight,
            ),
          )
        : ScrollableWidget(
            child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
              builder: (context, state) => Wrap(
                children: searchResult
                    .map(
                      (e) => AppInkWell(
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
                              mainCatId: e.categoryId,
                              subCatId: e.subCategoryId,
                              catArName: e.categoryNameAR,
                              catTrName: e.categoryNameTR,
                              catFrName: e.categoryNameFR,
                              catEnName: e.categoryNameEN,
                              catIsActive: e.isActive,
                              catLogo: e.imageUrl,
                              visibleApplications: e.visibleApplications,
                            ))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NetworkImageRounded(
                                width: widget.subCategoryWidth,
                                height: widget.subCategoryHeight,
                                url: e.imageUrl,
                                radius: BorderRadius.circular(15),
                              ),
                              context.sizedBoxHeightMicro,
                              Text(
                                e.subCategoryName,
                                style: context.textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}

class SubCategoriesWidget extends StatelessWidget {
  const SubCategoriesWidget(
      {super.key,
      required this.mainCategoryId,
      required this.mainCategoryImage,
      required this.isExpanded,
      required this.onItemTapped,
      required this.mainCategoryName,
      this.subCategoryHeight,
      this.subCategoryWidth});

  final int mainCategoryId;
  final String mainCategoryImage;
  final String mainCategoryName;
  final bool isExpanded;
  final Function(bool isOpen) onItemTapped;

  final double? subCategoryHeight;
  final double? subCategoryWidth;

  @override
  Widget build(BuildContext context) {
    final List<SubCategory> subCategories = context.select((SubCategoryBloc bloc) => bloc.subCategories);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => onItemTapped(isExpanded),
          child: Row(
            children: [
              SizedBox(
                  width: 220,
                  height: 70,
                  child: Stack(
                    children: [
                      NetworkImageRounded(
                        url: mainCategoryImage,
                        width: 220,
                        height: 70,
                        radius: BorderRadius.circular(15),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Color.fromARGB(168, 0, 0, 0), Color.fromARGB(122, 0, 0, 0)])),
                        ),
                      ),
                      Center(
                        child: Text(
                          mainCategoryName,
                          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 600),
                        turns: (isExpanded ? .5 : 0),
                        child: Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: context.colorScheme.primaryColor,
                        ),
                      )))
            ],
          ),
        ),
        Visibility(
            visible: isExpanded,
            child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
              builder: (context, state) {
                return (state.isLoading)
                    ? const LoadingWidget()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: context.isPhone ? .9 : 1.3,
                        ),
                        itemCount: subCategories.length,
                        itemBuilder: (context, index) => AppInkWell(
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
                                mainCatId: subCategories[index].categoryId,
                                subCatId: subCategories[index].subCategoryId,
                                catArName: subCategories[index].categoryNameAR,
                                catTrName: subCategories[index].categoryNameTR,
                                catFrName: subCategories[index].categoryNameFR,
                                catEnName: subCategories[index].categoryNameEN,
                                catIsActive: subCategories[index].isActive,
                                visibleApplications: subCategories[index].visibleApplications,
                                catLogo: subCategories[index].imageUrl,
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
                                      width: subCategoryWidth,
                                      height: subCategoryHeight,
                                      url: subCategories[index].imageUrl,
                                      radius: BorderRadius.circular(15),
                                    ),
                                    context.sizedBoxHeightMicro,
                                    Text(
                                      subCategories[index].subCategoryName,
                                      style: context.textTheme.bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                                Visibility(
                                    visible: !subCategories[index].isActive,
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: const Color(0x74c2c2c2),
                                          borderRadius: BorderRadius.circular(8)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
              },
            )),
        context.sizedBoxHeightExtraSmall,
        Divider(
          color: AppColors.lightGray,
          thickness: .4,
        ),
        context.sizedBoxHeightExtraSmall,
      ],
    );
  }
}
