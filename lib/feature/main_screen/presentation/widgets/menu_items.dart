import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/menu_model.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import 'package:merchant_dashboard/feature/manage_features/presentation/pages/manage_feature.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';

import '../../../../core/constants/defaults.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';

class MenuItemsWidget extends StatefulWidget {
  const MenuItemsWidget({Key? key}) : super(key: key);

  @override
  State<MenuItemsWidget> createState() => _MenuItemsWidgetState();
}

class _MenuItemsWidgetState extends State<MenuItemsWidget> {
  double itemHeight = UIDefaults.drawerItemsHeight;

  @override
  Widget build(BuildContext context) {
    String selectedPageKey = context.select((MenuDrawerCubit bloc) => bloc.selectedPageContent).pageKey;

    return BlocBuilder<MenuDrawerCubit, MenuDrawerState>(
      buildWhen: (previous, current) => current is RemovedMenuItemState || current is ChangeLanguageState,
      builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: context
              .read<MenuDrawerCubit>()
              .menuItems
              .map((page) => page.pageKey == MenuModel.exploreAndSetup
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: context.colorScheme.primaryColor)),
                      child: ListTile(
                        onTap: () => context.read<MenuDrawerCubit>().changeBodyContent(menuItem: page),
                        leading: Image.asset(
                          Assets.iconsIcon,
                          width: 20,
                        ),
                        title: Text(
                          page.text,
                          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                        trailing: Lottie.asset(Assets.animsExploreAnim, width: 30),
                      ),
                    )
                  : ManageFeature(
                      widgetKey: page.featureKey,
                      child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: _drawerItem(page, () {
                              context.read<MenuDrawerCubit>().checkIfPreviousScreenHasUnSavedData(menuItem: page);
                              // context.read<MenuDrawerCubit>().changeBodyContent(menuItem: page);

                            }, page.isEqual(selectedPageKey)),
                            tilePadding: const EdgeInsets.only(right: 20),
                            minTileHeight: 45,
                            initiallyExpanded:
                                page.subList.contains(context.read<MenuDrawerCubit>().selectedPageContent),
                            leading: Container(
                              width: 6,
                              height: 20,
                              decoration: BoxDecoration(
                                color: page.isEqual(selectedPageKey)
                                    ? context.colorScheme.primaryColor
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                              ),
                            ),
                            trailing: page.subList.isEmpty ? const SizedBox() : null,
                            childrenPadding: const EdgeInsets.only(left: 36),
                            children: page.subList
                                .map((e) => Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 10,
                                          child: Stack(
                                            children: [
                                              const Align(
                                                alignment: Alignment.center,
                                                child: VerticalDivider(
                                                  width: 2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Center(
                                                  child: Icon(
                                                Icons.circle,
                                                size: 9,
                                                color: e.isEqual(selectedPageKey)
                                                    ? context.colorScheme.primaryColor
                                                    : Colors.black,
                                              )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: _drawerItem(e, () {
                                            context.read<MenuDrawerCubit>().changeBodyContent(menuItem: e);
                                          }, e.isEqual(selectedPageKey)),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          )),
                    ))
              .toList()),
    );
  }

  Widget _drawerItem(MenuModel page, Function() onItemTapped, bool isSelectedPageKey) => AppInkWell(
        onTap: onItemTapped,
        child: Row(
          children: [
            SvgPicture.asset(
              page.assetIcon,
              height: 15,
              color: isSelectedPageKey ? context.colorScheme.primaryColor : AppColors.black,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                page.text,
                style: context.textTheme.titleSmall?.copyWith(
                  color: isSelectedPageKey ? context.colorScheme.primaryColor : AppColors.black,
                ),
              ),
            ),
          ],
        ),
      );
}

class PageItemBadgeWidget extends StatelessWidget {
  final int badge;

  const PageItemBadgeWidget({Key? key, required this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 27,
      decoration:
          const BoxDecoration(color: Color(0xffd80042), borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Center(
        child: Text(badge.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
