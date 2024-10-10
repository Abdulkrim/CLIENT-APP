import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/product_sort_types.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/product_details_dialog_widget.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/products_list_widget.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/products_main_category_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../widgets/app_status_toggle_widget.dart';
import '../../../../../widgets/search_box_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/products/products_bloc.dart';
import '../../blocs/sub_category/sub_category_bloc.dart';

class ProductsScreenMobile extends StatefulWidget {
  const ProductsScreenMobile({Key? key}) : super(key: key);

  @override
  State<ProductsScreenMobile> createState() => _ProductsScreenMobileState();
}

class _ProductsScreenMobileState extends State<ProductsScreenMobile> {
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();
    node.addListener(() => setState(() {}));
    _resetPage();
  }

  _resetPage() {
    context.read<ProductsBloc>().add(const ClearProductSearchResultEvent());
    context.read<MainCategoryBloc>().add(const GetMainCategoriesEvent());
    context.read<SubCategoryBloc>().subCategories = [];
    context.read<ProductsBloc>().selectedMainCategory = null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        _resetPage();
        context.read<ProductsBloc>().searchController.clear();
        return Future<void>.delayed(const Duration(seconds: 2));
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ProductsMainCategoryWidget(),
                  Text(
                    context.watch<MenuDrawerCubit>().selectedPageContent.text,
                    style: context.textTheme.titleLarge,
                  ),
                  context.sizedBoxHeightMicro,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.read<ProductsBloc>().add(const ChangeProductsShowTypeEvent());
                          },
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: SvgPicture.asset(context.select<ProductsBloc, bool>((value) => value.isListView)
                                ? Assets.iconsListView
                                : Assets.iconsGrid),
                          )),
                      context.sizedBoxWidthExtraSmall,
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            isDismissible: false,
                            // isScrollControlled: true,
                            BlocProvider<ProductsBloc>.value(
                              value: BlocProvider.of<ProductsBloc>(context),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: BlocBuilder<MainScreenBloc, MainScreenState>(
                                  builder: (context, state) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      context.sizedBoxHeightSmall,
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            S.current.filter,
                                            style: context.textTheme.titleSmall,
                                          )),
                                          IconButton(
                                              onPressed: () => Get.back(),
                                              icon: const Icon(
                                                Icons.cancel_rounded,
                                                color: Colors.black,
                                              ))
                                        ],
                                      ),
                                      Row(
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
                                      context.sizedBoxHeightSmall,
                                      Text(
                                        S.current.sortBy,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: context
                                              .read<ProductsBloc>()
                                              .sortTypes
                                              .map((ProductSortTypes e) => RadioListTile<ProductSortTypes>(
                                                    title: Text(e.displayedText),
                                                    value: e,
                                                    groupValue: context.select<ProductsBloc, ProductSortTypes>(
                                                        (value) => value.selectedSortType),
                                                    onChanged: (p0) {
                                                      Get.back();
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
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(Assets.iconsSort),
                      ),
                      context.sizedBoxWidthExtraSmall,
                      Expanded(
                        child: SearchBoxWidget(
                          hint: S.current.searchByNameOrBarcode,
                          focusNode: node,
                          searchTextController: context.read<ProductsBloc>().searchController,
                          showBarcodeScanner: true,
                          onSearchTapped: (String? text) {
                            if (text != null && text.isNotEmpty) {
                              context.read<ProductsBloc>().add(SearchProductsEvent(searchText: text));
                            } else {
                              context.read<ProductsBloc>().add(const ClearProductSearchResultEvent());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  context.sizedBoxHeightSmall,
                  Expanded(
                      child: ProductsListWidget(
                    onItemTap: ({required isLoyaltyAllowed, required product, required selectedSubId}) {},
                  )),
                ],
              ),
            ),
            Visibility(
              visible: (context.select((MainCategoryBloc bloc) => bloc.mainCategories.isNotEmpty) && !(node.hasFocus)),
              child: RoundedBtnWidget(
                onTap: () {

                /*  Get.dialog(MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<MainCategoryBloc>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<SubCategoryBloc>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<ProductsBloc>(context),
                      ),
                    ],
                    child: ProductDetailsDialogWidget(
                      selectedSubId: context.read<ProductsBloc>().selectedSubCategoryId ?? -1,
                    ),
                  ));*/
                },
                btnText: S.current.addProduct,
                btnIcon: SvgPicture.asset(Assets.iconsAddProduct, color: Colors.white),
                width: 300,
                height: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
