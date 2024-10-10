import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/products/products_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/sub_category/sub_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/desktop/product_search_screen.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_grid_card.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_list_card.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

import '../../../../generated/assets.dart';
import '../../../../theme/theme_data.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/network_image_rounded_widget.dart';

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({super.key, required this.onItemTap});

  final Function({required Product product, required int selectedSubId, required bool isLoyaltyAllowed}) onItemTap;

  @override
  State<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  int selectedSubCategory = 0;

  ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    final List<SubCategory> subCategories = context.select((SubCategoryBloc bloc) => bloc.subCategories);
    final List<Product> products = context.select((ProductsBloc bloc) => bloc.products);
    final bool isLoyaltyAllowed = context.select((ProductsBloc bloc) => bloc.isLoyaltyAllowed);

    return (!context.select((ProductsBloc bloc) => bloc.isSearchMode))
        ? ListView.builder(
            itemCount: subCategories.length,
            itemBuilder: (_, index) => ProductsWidget(
              isLoyaltyAllowed: isLoyaltyAllowed,
              subCategoryId: subCategories[index].subCategoryId,
              subCategoryImage: subCategories[index].imageUrl,
              subCategoryName: subCategories[index].subCategoryName,
              isExpanded: selectedSubCategory == subCategories[index].subCategoryId,
              products: products,
              onProductTap: (product) => widget.onItemTap(
                product: product,
                selectedSubId: subCategories[index].subCategoryId,
                isLoyaltyAllowed: isLoyaltyAllowed,
              ),
              onItemTapped: (isExpanded) {
                if (!isExpanded) {
                  setState(() {
                    selectedSubCategory = subCategories[index].subCategoryId;
                  });

                  context.read<ProductsBloc>().add(GetProductsEvent(subCategoryId: subCategories[index].subCategoryId));
                } else {
                  setState(() {
                    selectedSubCategory = 0;
                  });
                }
              },
            ),
          )
        : ProductSearchScreen(
            onProductTap: (product) => widget.onItemTap(
              product: product,
              selectedSubId: product.subCategoryId,
              isLoyaltyAllowed: isLoyaltyAllowed,
            ),
          );
  }
}

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
    required this.subCategoryId,
    required this.subCategoryImage,
    required this.subCategoryName,
    required this.isExpanded,
    required this.products,
    required this.onItemTapped,
    required this.isLoyaltyAllowed,
    required this.onProductTap,
  });

  final bool isLoyaltyAllowed;
  final int subCategoryId;
  final String subCategoryName;
  final String subCategoryImage;
  final bool isExpanded;
  final Function(bool isOpen) onItemTapped;
  final Function(Product product) onProductTap;

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
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
                        url: subCategoryImage,
                        width: 220,
                        height: 70,
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
                          subCategoryName,
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
                        child: SvgPicture.asset(
                          Assets.iconsDropDownArrow,
                          width: 15,
                          color: context.colorScheme.primaryColor,
                        ),
                      ))),
            ],
          ),
        ),
        if (isExpanded)
          Wrap(
            children: products
                .map((e) => !context.watch<ProductsBloc>().isListView
                    ? ProductGridCardWidget(
                        product: e,
                        onItemTap: () => onProductTap(e),
                      )
                    : ProductListCardWidget(
                        product: e,
                        onItemTap: () => onProductTap(e),
                      ))
                .toList(),
          ),
        BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) => Visibility(visible: state.isLoading && isExpanded, child: const LoadingWidget())),
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
