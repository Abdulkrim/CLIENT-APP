import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/products/products_bloc.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

import '../../../../widgets/network_image_rounded_widget.dart';
import '../blocs/main_category/main_category_bloc.dart';
import '../blocs/sub_category/sub_category_bloc.dart';

class ProductsMainCategoryWidget extends StatefulWidget {
  const ProductsMainCategoryWidget({Key? key}) : super(key: key);

  @override
  State<ProductsMainCategoryWidget> createState() => _ProductsMainCategoryWidgetState();
}

class _ProductsMainCategoryWidgetState extends State<ProductsMainCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    List<ProductsCategory> mainCategories = context.select((MainCategoryBloc bloc) => bloc.mainCategories);
    ProductsCategory? selectedMainCategory = context.watch<ProductsBloc>().selectedMainCategory;

    return Visibility(
      visible: !context.select((ProductsBloc bloc) => bloc.isSearchMode),
      child: SizedBox(
          height: 100,
          width: Get.width,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            scrollDirection: Axis.horizontal,
            itemCount: mainCategories.length,
            itemBuilder: (context, index) => ProductMainCategoryItemWidget(
              category: mainCategories[index],
              isSelected: selectedMainCategory?.categoryId == mainCategories[index].categoryId,
              onItemTapped: () {
                context.read<ProductsBloc>().add(MainCategoryChangedEvent(mainCategories[index]));
                context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(mainCategories[index].categoryId));
              },
            ),
          )),
    );
  }
}

class ProductMainCategoryItemWidget extends StatelessWidget {
  final ProductsCategory category;
  final bool isSelected;
  final Function() onItemTapped;

  const ProductMainCategoryItemWidget(
      {Key? key, required this.category, required this.isSelected, required this.onItemTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: context.colorScheme.primaryColor),  ),
        child: AppInkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: onItemTapped,
          child: Stack(
            children: [
              NetworkImageRounded(
                url: category.imageUrl,
                width: 200,
                radius: BorderRadius.circular(60),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color.fromARGB(109, 0, 0, 0), Color.fromARGB(62, 0, 0, 0)])),
                ),
              ),
              Center(
                child: Text(
                  category.categoryName,
                  style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
