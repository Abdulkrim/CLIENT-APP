import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/explore/presentation/widgets/explore_item_widget.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/menu_model.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/widgets/app_dividers.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
// import 'package:pushy_flutter/web/js_fallback.js';

import '../../../../generated/l10n.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../data/models/entity/explore_item.dart';

class ExploreScreen extends StatelessWidget with DownloadUtils {
  const ExploreScreen({super.key});

  final double _itemMaxWidth = 320;

  @override
  Widget build(BuildContext context) {
    List<ExploreItem> firstList = [
      ExploreItem(
          title: S.current.OnlineOrdering1Title,
          description: S.current.OnlineOrdering1Description,
          btnText: S.current.manageOrdering,
          onBtnTap: () => context
              .read<MenuDrawerCubit>()
              .changeBodyContent(menuItem: MenuModel.systemManagementOnlineOrdering.getRelatedMenuItem())),
      ExploreItem(
          title: S.current.ManageItems2,
          description: S.current.ManageItems2Description,
          btnText: S.current.itemList,
          onBtnTap: () =>
              context.read<MenuDrawerCubit>().changeBodyContent(menuItem: MenuModel.productItemListing.getRelatedMenuItem())),
      ExploreItem(
          title: S.current.OrderManagement3,
          description: S.current.OrderManagement3Description,
          btnText: S.current.manageOrders,
          onBtnTap: () =>
              context.read<MenuDrawerCubit>().changeBodyContent(menuItem: MenuModel.orderManagement.getRelatedMenuItem())),
      ExploreItem(
          title: S.current.customizeYourStore4,
          description: S.current.customizeYourStore4Description,
          btnText: S.current.storeInfo,
          onBtnTap: () => context
              .read<MenuDrawerCubit>()
              .changeBodyContent(menuItem: MenuModel.systemManagementStoreInfo.getRelatedMenuItem())),
    ];

    return ScrollableWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          crossAxisAlignment: WrapCrossAlignment.start,
           children: [
            ContainerSetting(
                maxWidth: _itemMaxWidth,
                padding:EdgeInsetsDirectional.only(start: 10,end: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.current.setupGuideDescription,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    context.sizedBoxHeightExtraSmall,
                    RoundedBtnWidget(
                        bgColor: Colors.transparent,
                        boxBorder: Border.all(color: Colors.black),
                        borderRadios: 40,
                        btnPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        btnTextColor: Colors.black,
                        btnText: context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo)?.domainAddress ?? '',
                        btnIcon: SvgPicture.asset(
                          Assets.iconsCopyIcon,
                          width: 15,
                        ),
                        onTap: () =>
                            openLink(url: 'https://${(context.read<MainScreenBloc>().branchGeneralInfo?.domainAddress ?? '')}')),
                    context.sizedBoxHeightExtraSmall,
                    appHorizontalDivider(),
                    context.sizedBoxHeightExtraSmall,
                    ...firstList.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child:
                            ExploreItemWidget(title: e.title, description: e.description, btnText: e.btnText, onBtnTap: e.onBtnTap),
                      ),
                    ),
                  ],
                )),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerSetting(
                  padding:EdgeInsetsDirectional.only(start: 10,end: 10,top: 20),
                  maxWidth: _itemMaxWidth,
                  child: ExploreItemWidget(
                      title: S.current.whatsappAccount,
                      description: S.current.whatsappAccountDescription,
                      btnText: S.current.updateAccount,
                      onBtnTap: () => context
                          .read<MenuDrawerCubit>()
                          .changeBodyContent(menuItem: MenuModel.systemManagementOnlineOrdering.getRelatedMenuItem())),
                ),
               SizedBox(height: 12,),
                ContainerSetting(
                  maxWidth: _itemMaxWidth,
                  child: ExploreItemWidget(
                      title: S.current.smsNotification,
                      description: S.current.smsNotificationDescription,
                      btnText: S.current.setupNotification,
                      onBtnTap: () => context
                          .read<MenuDrawerCubit>()
                          .changeBodyContent(menuItem: MenuModel.systemManagementSettings.getRelatedMenuItem())),
                ),
                SizedBox(height: 12,),
                ContainerSetting(
                  maxWidth: _itemMaxWidth,
                  child: ExploreItemWidget(
                      title: S.current.staffManagement,
                      description: S.current.staffManagementDescription,
                      btnText: S.current.manageStaff,
                      onBtnTap: () => context
                          .read<MenuDrawerCubit>()
                          .changeBodyContent(menuItem: MenuModel.cashierOperators.getRelatedMenuItem())),
                ),
                SizedBox(height: 12,),
                ContainerSetting(
                  maxWidth: _itemMaxWidth,
                  child: ExploreItemWidget(
                      title: S.current.manageExpense,
                      description: S.current.manageExpenseDescription,
                      btnText: S.current.manageExpense,
                      onBtnTap: () =>
                          context.read<MenuDrawerCubit>().changeBodyContent(menuItem: MenuModel.expense.getRelatedMenuItem())),
                ),
                SizedBox(height: 12,),
              ],
            ),
            Column(
              children: [
                ContainerSetting(
                  padding:EdgeInsetsDirectional.only(start: 10,end: 10,top: 20),
                  maxWidth: _itemMaxWidth,
                  child: ExploreItemWidget(
                      title: S.current.customerManagement,
                      description: S.current.customerManagementDescription,
                      btnText: S.current.customerManagement,
                      onBtnTap: () =>
                          context.read<MenuDrawerCubit>().changeBodyContent(menuItem: MenuModel.customers.getRelatedMenuItem())),
                ),
                SizedBox(height: 12,),
                Visibility(
                  visible: context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.isRestaurants ?? false),
                  child: ContainerSetting(
                    maxWidth: _itemMaxWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExploreItemWidget(
                            title: S.current.tableManagement,
                            description: S.current.tableManagementDescription,
                            btnText: S.current.manageTables,
                            onBtnTap: () => context
                                .read<MenuDrawerCubit>()
                                .changeBodyContent(menuItem: MenuModel.systemManagementTableManagement.getRelatedMenuItem())),
                        context.sizedBoxHeightMicro,
                        // context.sizedBoxHeightMicro,
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                ContainerSetting(
                  maxWidth: _itemMaxWidth,
                  child: ExploreItemWidget(
                      title: S.current.settings,
                      description: S.current.settingsDescription,
                      btnText: S.current.goToSettings,
                      onBtnTap: () => context
                          .read<MenuDrawerCubit>()
                          .changeBodyContent(menuItem: MenuModel.systemManagementSettings.getRelatedMenuItem())),
                ),
                SizedBox(height: 12,),
                ContainerSetting(
                  maxWidth: _itemMaxWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.current.downloadAPKs,
                        style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold,color: AppColors.headerColor),
                      ),
                      context.sizedBoxHeightUltraSmall,
                      Text(
                        S.current.downloadAPKsDescription,
                        style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          RoundedBtnWidget(
                            btnMargin: EdgeInsets.zero,
                            onTap: () => openLink(url: 'https://epay.altkamul.ae/content/version/xpay.apk'),
                            btnText: 'Cashier APK',
                            btnPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            bgColor: Colors.transparent,
                            boxBorder: Border.all(color: Colors.black),
                            btnTextColor: Colors.black,

                          ),
                          RoundedBtnWidget(
                            btnMargin: EdgeInsets.zero,
                            onTap: () => openLink(url: 'https://epay.altkamul.ae/content/version/xpay.apk'),
                            btnText: 'Waiter APK',
                            btnPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            bgColor: Colors.transparent,
                            boxBorder: Border.all(color: Colors.black),
                            btnTextColor: Colors.black,
                          ),
                          RoundedBtnWidget(
                            btnMargin: EdgeInsets.zero,
                            hoverColor: Colors.black,
                            onTap: () => openLink(url: 'https://epay.altkamul.ae/content/version/xpay.apk'),
                            btnText: 'KDS APK',
                            btnPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            bgColor: Colors.transparent,
                            boxBorder: Border.all(color: Colors.black),
                            btnTextColor: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
