import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/area_management/presentation/pages/area_management_screen.dart';
import 'package:merchant_dashboard/feature/device/presentation/pages/device_settings_screen.dart';
import 'package:merchant_dashboard/feature/manage_features/data/models/enums/main_features.dart';
import 'package:merchant_dashboard/feature/notifications/presentation/widgets/notifications_list_widget.dart';
import 'package:merchant_dashboard/feature/online_ordering/presentation/pages/online_ordering_screen.dart';
import 'package:merchant_dashboard/feature/products/presentation/pages/main_categories_screen.dart';
import 'package:merchant_dashboard/feature/products/presentation/pages/products_screen.dart';
import 'package:merchant_dashboard/feature/products/presentation/pages/sub_categories_screen.dart';
import 'package:merchant_dashboard/feature/report/presentation/pages/cashiers/cashier_reports_screen.dart';
import 'package:merchant_dashboard/feature/report/presentation/pages/categorized/categorized_reports_screen.dart';
import 'package:merchant_dashboard/feature/tables/presentation/pages/tables_screen.dart';
import 'package:merchant_dashboard/feature/workers/presentation/pages/workers_screen.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';

import '../../../cashiers/presentation/pages/cashiers_screen.dart';
import '../../../customers/presentation/pages/customers_screen.dart';
import '../../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../../expense/presentation/pages/expense_screen.dart';
import '../../../explore/presentation/pages/explore_screen.dart';
import '../../../merchant_info/presentation/pages/merchant_info_screen.dart';
import '../../../orders/presentation/pages/orders_management_screen.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../../../subscription/presentation/pages/subscription_screen.dart';
import '../../../support_privacy/presentation/pages/privacy_support_screen.dart';
import '../../../stock/presentation/pages/stock_screen.dart';
import '../../../transaction/presentation/pages/transaction_screen.dart';

final hasSetupGuidItem = true.obs;

class MenuModel extends Equatable {
  final String text;
  final Widget screen;
  final String pageKey;
  final String? featureKey;
  bool isHasData;

  bool isEqual(String selectedPageKey) =>
      (selectedPageKey == pageKey || selectedPageKey.split('-').contains(pageKey));

  final String assetIcon;
  final List<MenuModel> subList;

    MenuModel(
      {required this.text,
      this.subList = const <MenuModel>[],
      required this.screen,
      required this.pageKey,
      this.featureKey,
          this.isHasData = false,
      required this.assetIcon});

  MenuModel.empty()
      : text = '',
        screen = const SizedBox(),
        featureKey = '',
        pageKey = '',
        assetIcon = '',
        isHasData = false,
        subList = [];


  static const String exploreAndSetup = 'explore-and-setup';

  static const String dashboard = 'dashboard';

  static const String itemListing = 'itemListing';
  static const String productItemListing = '$itemListing-items';
  static const String mainCategoryItemListing = '$itemListing-mainCategory';
  static const String subCategoryItemListing = '$itemListing-subCategory';
  static const String stockItemListing = '$itemListing-stock';

  static const String orderManagement = 'order-management';

  static const String transaction = 'transaction';
  static const String reportTransactions = '$transaction-reports';
  static const String cashiersTransactions = '$transaction-cashiers';
  static const String categorizedTransaction = '$transaction-categorized';

  static const String customers = 'customers';
  static const String expense = 'expense';

  static const String operators = 'operators';
  static const String cashierOperators = '$operators-cashiers';
  static const String workerOperators = '$operators-workers';

  // static const String setupGuide = 'setup-guide';
  static const String support = 'support';

  static const String systemManagement = 'systemManagement';
  static const String systemManagementDeliveryManagement = '$systemManagement-deliveryManagement';
  static const String systemManagementTableManagement = '$systemManagement-tableManagement';
  static const String systemManagementOnlineOrdering = '$systemManagement-onlineOrdering';
  static const String systemManagementPOSSettings = '$systemManagement-posSettings';
  static const String systemManagementSubscription = '$systemManagement-subscription';
  static const String systemManagementSettings = '$systemManagement-settings';
  static const String systemManagementStoreInfo = '$systemManagement-storeInfo';
  static const String systemManagementNotification = '$systemManagement-notification';

  static List<MenuModel> get allMenuList => [
        MenuModel(
          text: S.current.exploreAndSetup,
          pageKey: exploreAndSetup,
          assetIcon: Assets.iconsDashboard,
          screen: const ExploreScreen(),
        ),
        MenuModel(
          text: S.current.dashboard,
          pageKey: dashboard,
          assetIcon: Assets.iconsDashboard,
          screen: const DashboardScreen(),
        ),
        MenuModel(
          text: S.current.productListing,
          pageKey: itemListing,
          assetIcon: Assets.iconsProductListing,
          screen: const ProductsScreen(),
          subList: [
            MenuModel(
              text: S.current.category,
              screen: const MainCategoriesScreen(),
              pageKey: mainCategoryItemListing,
              assetIcon: Assets.iconsMainCategory,
            ),
            MenuModel(
              text: S.current.subcategory,
              screen: const SubCategoriesScreen(),
              pageKey: subCategoryItemListing,
              assetIcon: Assets.iconsSubCategory,
            ),
            MenuModel(
              text: S.current.itemListing,
              screen: const ProductsScreen(),
              pageKey: productItemListing,
              assetIcon: Assets.iconsItemListing,
            ),
            MenuModel(
              text: S.current.stock,
              pageKey: stockItemListing,
              featureKey: Stock.gKey.key,
              assetIcon: Assets.iconsStock,
              screen: const StockScreen(),
            ),
          ],
        ),
        MenuModel(
          text: S.current.orderManagement,
          pageKey: orderManagement,
          assetIcon: Assets.iconsOrderMenuIcon,
          screen: const OrdersManagementScreen(),
        ),
        MenuModel(
          text: S.current.operator,
          pageKey: operators,
          assetIcon: Assets.iconsManageUsersIcon,
          subList: [
            MenuModel(
              text: S.current.workers,
              screen: const WorkersScreen(),
              pageKey: workerOperators,
              assetIcon: Assets.iconsUsersMenu,
            ),
            MenuModel(
              text: S.current.operator,
              screen: const CashiersScreen(),
              pageKey: cashierOperators,
              assetIcon: Assets.iconsCashierMachine,
            ),
          ],
          screen: const CashiersScreen(),
        ),
        MenuModel(
          text: S.current.customers,
          pageKey: customers,
          assetIcon: Assets.iconsCustomersIcon,
          screen: const CustomersScreen(),
        ),
        MenuModel(
          text: S.current.expense,
          pageKey: expense,
          featureKey: Expense.gKey.key,
          assetIcon: Assets.iconsMyAccount,
          screen: const ExpenseScreen(),
        ),
        MenuModel(
            text: S.current.reports,
            pageKey: transaction,
            assetIcon: Assets.iconsIcTransacts,
            screen: const TransactionScreen(),
            subList: [
              MenuModel(
                text: S.current.transactions,
                pageKey: reportTransactions,
                assetIcon: Assets.iconsIcTransacts,
                screen: const TransactionScreen(),
              ),
              MenuModel(
                pageKey: cashiersTransactions,
                text: S.current.reportsByCashiers,
                screen: const CashiserReportsScreen(),
                assetIcon: Assets.iconsCashierMachine,
              ),
              MenuModel(
                pageKey: categorizedTransaction,
                text: S.current.categorized,
                screen: const CategorizedReportsScreen(),
                assetIcon: Assets.iconsSubCategory,
              ),
            ]),
        MenuModel(
            text: S.current.systemManagement,
            pageKey: systemManagement,
            assetIcon: Assets.iconsSettingsIcon,
            screen: const SettingsScreen(),
            subList: [
              MenuModel(
                text: S.current.deliveryManagement,
                pageKey: systemManagementDeliveryManagement,
                assetIcon: Assets.iconsDeliveryManagement,
                screen: const AreaManagementScreen(),
              ),
              MenuModel(
                text: S.current.tablesManagement,
                pageKey: systemManagementTableManagement,
                assetIcon: Assets.iconsTablesIcon,
                screen: const TablesScreen(),
              ),
              MenuModel(
                pageKey: systemManagementOnlineOrdering,
                text: S.current.onlineOrdering,
                screen: const OnlineOrderingScreen(),
                assetIcon: Assets.iconsOrderManagement,
              ),
              MenuModel(
                text: S.current.posDevices,
                pageKey: systemManagementPOSSettings,
                assetIcon: Assets.iconsCashierMachine,
                screen: const DeviceSettingsScreen(),
              ),
              if (kIsWeb)
                MenuModel(
                  text: S.current.subscription,
                  pageKey: systemManagementSubscription,
                  assetIcon: Assets.iconsMyAccount,
                  screen: const SubscriptionScreen(),
                ),

              // MenuModel(
              //   text: S.current.smsNotification,
              //   pageKey: systemManagementNotification,
              //   assetIcon: Assets.iconsNotify,
              //   screen: const NotificationsListWidget(),
              // ),
              MenuModel(
                text: S.current.settings,
                pageKey: systemManagementSettings,
                assetIcon: Assets.iconsSettingsIcon,
                screen: const SettingsScreen(),
              ),
              MenuModel(
                text: S.current.storeInfo,
                pageKey: systemManagementStoreInfo,
                assetIcon: Assets.iconsMerchantInfo,
                screen: const MerchantInfoScreen(),
              ),
            ]),
        MenuModel(
          text: kIsWeb ? S.current.support : S.current.supportAndPrivacy,
          pageKey: support,
          assetIcon: Assets.iconsInfoIcon,
          screen: PrivacySupportScreen(),
        ),
      ];

  @override
  List<Object?> get props => [
        text,
        screen,
        pageKey,
        featureKey,
        assetIcon,
        subList,
      ];
}

extension MenuModelUtils on String {
  MenuModel? getRelatedMenuItem() {
    var menuModel = MenuModel.allMenuList.firstWhereOrNull((element) => element.pageKey == this);

    if (menuModel == null) {
      for (var main in MenuModel.allMenuList) {
        final temp = main.subList.firstWhereOrNull((element) => element.pageKey == this);
        if (temp != null) {
          menuModel = temp;
          break;
        }
      }
    }

    return menuModel;
  }
}
