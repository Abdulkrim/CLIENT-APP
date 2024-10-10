import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../../widgets/search_box_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../../data/models/entity/products.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/sub_category/sub_category_bloc.dart';
import '../main_category/main_category_item_widget.dart';
import '../product_details_widgets/category_details_dialog.dart';

class MobileMainCategories extends StatefulWidget {
  const MobileMainCategories({super.key});

  @override
  State<MobileMainCategories> createState() => _MobileMainCategoriesState();
}

class _MobileMainCategoriesState extends State<MobileMainCategories> {
  @override
  Widget build(BuildContext context) {
    final List<ProductsCategory> mainCategories =
        context.select((MainCategoryBloc bloc) => bloc.mainCategories);

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
                    onTap: () => Get.dialog(MultiBlocProvider(providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<MainCategoryBloc>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<SubCategoryBloc>(context),
                      ),
                    ], child: const CategoryDetailsDialog())),
                    btnText: S.current.addCategory,
                    btnIcon: SvgPicture.asset(Assets.iconsAddStock, color: Colors.white, height: 20),
                    wrapWidth: true,
                    height: 35,
                  ),
                ],
              ),
              context.sizedBoxHeightExtraSmall,
              SearchBoxWidget(
                searchTextController: context.read<MainCategoryBloc>().searchController,
                hint: S.current.searchByCategoryName,
                onSearchTapped: (String? text) {
                  if (text != null && text.isNotEmpty) {
                    context.read<MainCategoryBloc>().add(SearchMainCategoriesEvent(text));
                  } else {
                    context.read<MainCategoryBloc>().add(const GetMainCategoriesEvent());
                  }
                },
              ),
              context.sizedBoxHeightSmall,
              Expanded(
                  child: Stack(
                children: [
                  ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: mainCategories.length,
                    itemBuilder: (context, index) =>
                        MainCategoryItemWidget(mainCategory: mainCategories[index]),
                  ),
                  Center(
                    child: BlocBuilder<MainCategoryBloc, MainCategoryState>(
                      builder: (context, state) {
                        return Visibility(
                          visible: state.isLoading,
                          child: const LoadingWidget(),
                        );
                      },
                    ),
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    ));
  }
}
