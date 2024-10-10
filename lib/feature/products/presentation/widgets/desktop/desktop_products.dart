import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/product_sort_types.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/product_details_dialog_widget.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/products_list_widget.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/products_main_category_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/app_status_toggle_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';

import '../../../../../widgets/search_box_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../data/models/entity/products.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/products/products_bloc.dart';
import '../../blocs/sub_category/sub_category_bloc.dart';

class DesktopProducts extends StatefulWidget {
  const DesktopProducts({Key? key}) : super(key: key);

  @override
  State<DesktopProducts> createState() => _DesktopProductsState();
}

class _DesktopProductsState extends State<DesktopProducts> {
  @override
  void initState() {
    super.initState();
    _resetPage();
  }

  _resetPage() {
    context.read<ProductsBloc>().add(const ClearProductSearchResultEvent());
    context.read<MainCategoryBloc>().add(const GetMainCategoriesEvent());
    context.read<SubCategoryBloc>().subCategories = [];
    context.read<ProductsBloc>().selectedMainCategory = null;
  }

  final _pageViewController = PageController();
  Product? product;
  int? selectedSubId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageViewController,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.watch<MenuDrawerCubit>().selectedPageContent.text,
                      style: context.textTheme.titleLarge,
                    ),
                    context.sizedBoxWidthMicro,
                    IconButton(
                        onPressed: () => _resetPage(),
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.black,
                        )),
                  ],
                ),
                context.sizedBoxHeightMicro,
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Visibility(
                      visible: !context.select((ProductsBloc bloc) => bloc.isSearchMode) &&
                          context.select((MainCategoryBloc bloc) => bloc.mainCategories.isNotEmpty),
                      child: RoundedBtnWidget(
                        onTap: () {
                          _pageViewController.jumpToPage(1);
                        },
                        btnText: S.current.addProduct,
                        btnIcon: SvgPicture.asset(Assets.iconsAddProduct, color: Colors.white, height: 20),
                        wrapWidth: true,
                        height: 40,
                      ),
                    ),
                    context.sizedBoxWidthExtraSmall,
                    SizedBox(
                      width: 300,
                      child: Row(
                        children: [
                          Text(
                            S.current.allItems,
                            style: context.textTheme.titleSmall,
                          ),
                          AppSwitchToggle(
                            disableThumbColor: context.colorScheme.primaryColorDark,
                            disableTrackColor: context.colorScheme.primaryColorLight,
                            currentStatus: context.select((ProductsBloc bloc) => bloc.onlyActiveItems),
                            onStatusChanged: (status) => context.read<ProductsBloc>().isSearchMode
                                ? context.read<ProductsBloc>().add(SearchProductsEvent(
                                    searchText: context.read<ProductsBloc>().searchController.text.trim(),
                                    onlyActiveItems: status))
                                : context.read<ProductsBloc>().add(GetProductsEvent(onlyActiveItems: status)),
                            scale: .7,
                          ),
                          Text(
                            S.current.onlyActiveItems,
                            style: context.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    context.sizedBoxWidthExtraSmall,
                    SizedBox(
                      width: 350,
                      child: SearchBoxWidget(
                        searchTextController: context.read<ProductsBloc>().searchController,
                        hint: S.current.searchByNameOrBarcode,
                        onSearchTapped: (String? text) {
                          if (text != null && text.isNotEmpty) {
                            context.read<ProductsBloc>().add(SearchProductsEvent(searchText: text));
                          } else {
                            context.read<ProductsBloc>().add(const ClearProductSearchResultEvent());
                          }
                        },
                      ),
                    ),
                    context.sizedBoxWidthExtraSmall,
                    AppInkWell(
                        onTap: () {
                          context.read<ProductsBloc>().add(const ChangeProductsShowTypeEvent());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.watch<ProductsBloc>().isListView ? S.current.list : S.current.gird,
                              style: context.textTheme.labelLarge,
                            ),
                            context.sizedBoxWidthMicro,
                            Container(
                              height: 40,
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xffeeeeee),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: SvgPicture.asset(
                                context.select<ProductsBloc, bool>(
                                  (value) => value.isListView,
                                )
                                    ? Assets.iconsListView
                                    : Assets.iconsGrid,
                                height: 20,
                              ),
                            ),
                          ],
                        )),
                    context.sizedBoxWidthExtraSmall,
                    RoundedDropDownList(
                        maxWidth: 210,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        selectedValue:
                            context.select<ProductsBloc, ProductSortTypes>((value) => value.selectedSortType),
                        onChange: (p0) {
                          if (context.read<ProductsBloc>().isSearchMode) {
                            context.read<ProductsBloc>().add(SearchProductsEvent(
                                searchText: context.read<ProductsBloc>().searchController.text.trim(),
                                sortType: p0));
                          } else {
                            context
                                .read<ProductsBloc>()
                                .add(GetProductsEvent(sortType: p0, subCategoryId: null));
                          }
                        },
                        items: context
                            .read<ProductsBloc>()
                            .sortTypes
                            .map<DropdownMenuItem<ProductSortTypes>>(
                                (ProductSortTypes value) => DropdownMenuItem<ProductSortTypes>(
                                      value: value,
                                      child: Text(
                                        value.displayedText,
                                        style: context.textTheme.titleSmall,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ))
                            .toList())
                  ],
                ),
                const ProductsMainCategoryWidget(),
                Expanded(child: ProductsListWidget(
                  onItemTap: ({required isLoyaltyAllowed, required product, required selectedSubId}) {
                    this.selectedSubId = selectedSubId;

                    setState(() => this.product = product);
                    _pageViewController.jumpToPage(1);
                  },
                ))
              ],
            ),
          ),
          ProductDetailsDialogWidget(
            key: ValueKey(product),
              product: product,
              selectedSubId: selectedSubId ?? -1,
              onBackTap: () {
                selectedSubId = null;
                product = null;
                setState(() {});
                _pageViewController.jumpToPage(0);
              })
        ],
      ),
    );
  }
}
