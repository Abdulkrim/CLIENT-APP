import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../data/models/entity/products.dart';
import '../../blocs/products/products_bloc.dart';
import '../products_list_widget.dart';
import '../products_main_category_widget.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key , required this.onProductTap});

  final Function(Product product) onProductTap;
  @override
  State<ProductSearchScreen> createState() => _DesktopProductSearchState();
}

class _DesktopProductSearchState extends State<ProductSearchScreen> {
  int selectedMainCategoryPos = 0;
  int selectedSubCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    final List<ProductsCategory> searchResult = context.select((ProductsBloc bloc) => bloc.searchResult);

    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is SearchProductsState && state.isSuccess) {
          selectedMainCategoryPos = 0;
          selectedSubCategoryId = 0;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 100,
              width: Get.width,
              child: ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: searchResult.length,
                itemBuilder: (context, index) => ProductMainCategoryItemWidget(
                  category: searchResult[index],
                  isSelected: false,
                  onItemTapped: () {
                    setState(() {
                      selectedMainCategoryPos = index;
                    });
                  },
                ),
              ),
            ),
            Expanded(
                child: (searchResult.isNotEmpty && searchResult[selectedMainCategoryPos].subCategories != null)
                    ? ListView.builder(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: searchResult[selectedMainCategoryPos].subCategories?.length,
                        itemBuilder: (_, index) => ProductsWidget(
                          isLoyaltyAllowed: context.read<ProductsBloc>().isLoyaltyAllowed,
                          subCategoryId: searchResult[selectedMainCategoryPos].subCategories![index].subCategoryId,
                          subCategoryImage: searchResult[selectedMainCategoryPos].subCategories![index].imageUrl,
                          subCategoryName: searchResult[selectedMainCategoryPos].subCategories![index].categoryNameEN,
                          isExpanded:
                              selectedSubCategoryId == searchResult[selectedMainCategoryPos].subCategories![index].subCategoryId,
                          products: searchResult[selectedMainCategoryPos].subCategories![index].products,
                          onItemTapped: (isExpanded) {
                            if (!isExpanded) {
                              setState(() {
                                selectedSubCategoryId = searchResult[selectedMainCategoryPos].subCategories![index].subCategoryId;
                              });
                            } else {
                              setState(() {
                                selectedSubCategoryId = 0;
                              });
                            }
                          },
                          onProductTap: (Product product) => widget.onProductTap(product),
                        ),
                      )
                    : const SizedBox())
          ],
        );
      },
    );
  }
}
