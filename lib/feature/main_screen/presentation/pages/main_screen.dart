import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/area_management/presentation/blocs/area_management_cubit.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/credit_history/credit_history_cubit.dart';
import 'package:merchant_dashboard/feature/customers/presentation/blocs/customers/customer_bloc.dart' as customerBloc;
import 'package:merchant_dashboard/feature/dashboard/presentation/blocs/dashboard_bloc.dart';
import 'package:merchant_dashboard/feature/device/presentation/blocs/device_cubit.dart';
import 'package:merchant_dashboard/feature/loyalty/presentation/blocs/loyalty_point/loyalty_point_history_cubit.dart';
import 'package:merchant_dashboard/feature/loyalty/presentation/blocs/loyalty_settings/loyalty_settings_cubit.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/desktop/desktop_main.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/mobile/mobile_main.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/feature/notifications/presentation/blocs/notifications_bloc.dart';
import 'package:merchant_dashboard/feature/online_ordering/presentation/blocs/online_ordering_cubit.dart';
import 'package:merchant_dashboard/feature/region/presentation/blocs/region_cubit.dart';
import 'package:merchant_dashboard/feature/report/presentation/blocs/products/product_reports_cubit.dart';
import 'package:merchant_dashboard/feature/report/presentation/blocs/sub_categories/sub_category_reports_cubit.dart';
import 'package:merchant_dashboard/feature/signup/presentation/pages/signup_setup_guide_screen.dart';
import 'package:merchant_dashboard/feature/stock/presentation/blocs/stock_bloc.dart';
import 'package:merchant_dashboard/feature/subscription/presentation/blocs/billing_history/cubit/billing_history_cubit.dart';
import 'package:merchant_dashboard/feature/support_privacy/presentation/blocs/cubit/privacy_cubit.dart';
import 'package:merchant_dashboard/utils/screenUtils/responsive.dart';

import '../../../../injection.dart';
import '../../../business_hours/presentation/blocs/cubit/branch_shift_cubit.dart';
import '../../../cashiers/presentation/blocs/cashier_bloc.dart';
import '../../../manage_features/presentation/blocs/cubit/manage_feautre_cubit.dart';
import '../../../my_account/presentation/blocs/my_account_bloc.dart';
import '../../../orders/presentation/blocs/order_management_bloc.dart';
import '../../../products/presentation/blocs/main_category/main_category_bloc.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../products/presentation/blocs/sub_category/sub_category_bloc.dart';
import '../../../report/presentation/blocs/cashiers/cashier_reports_cubit.dart';
import '../../../settings/presentation/blocs/settings_bloc.dart';
import '../../../signup/presentation/blocs/sign_up_bloc.dart';
import '../../../subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart';
import '../../../tables/presentation/blocs/cubit/table_cubit.dart';
import '../../../transaction/presentation/blocs/transaction_bloc.dart';
import '../../../workers/presentation/blocs/workers_cubit.dart';

final showSetupGuide = false.obs;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) => getIt<SignUpBloc>(),
        ),
        BlocProvider<DashboardBloc>(create: (BuildContext context) => getIt<DashboardBloc>()..add(const GetTodayDataEvent())),
        BlocProvider<DeviceCubit>(
          create: (BuildContext context) => getIt<DeviceCubit>()..checkBranchHasDevice(),
        ),
        BlocProvider<ManageFeautreCubit>(
          create: (BuildContext context) => getIt<ManageFeautreCubit>(),
        ),
        BlocProvider<MainCategoryBloc>(
          create: (BuildContext context) => getIt<MainCategoryBloc>()..add(const GetMainCategoriesEvent()),
        ),
        BlocProvider<SubCategoryBloc>(
          create: (BuildContext context) => getIt<SubCategoryBloc>(),
        ),
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => getIt<ProductsBloc>()
            ..add(const GetOfferTypes())
            ..add(const GetItemTypes()),
        ),
        BlocProvider<OrderManagementBloc>(
          create: (BuildContext context) => getIt<OrderManagementBloc>()..add(const GetAllOrdersData()),
        ),
        BlocProvider<StockBloc>(
          create: (BuildContext context) => getIt<StockBloc>()
            ..add(const GetAllStockRequestEvent())
            ..add(const GetDecreaseReasons())
            ..add(const GetAllProducts())
            ..add(const GetStockStatistics()),
        ),
        BlocProvider<TransactionBloc>(
          create: (BuildContext context) => getIt<TransactionBloc>()
            ..add(const GetFiltersDataEvent())
            ..add(const GetAllTransactionsEvent()),
        ),
        BlocProvider<customerBloc.CustomerBloc>(
            create: (BuildContext context) =>
                getIt<customerBloc.CustomerBloc>()..add(const customerBloc.GetAllCustomersEvent.refresh())),
        BlocProvider<CashierBloc>(
          create: (BuildContext context) => getIt<CashierBloc>()
            ..add(const GetAllCashiersEvent.refresh())
            ..add(const GetAllCashiersSalesEvent())
            ..add(const GetCashierRolesRequestEvent()),
        ),
        BlocProvider<WorkersCubit>(
          create: (BuildContext context) => getIt<WorkersCubit>()
            ..getAllWorkers()
            ..getAllWorkerSales(),
        ),
        BlocProvider<CashierReportsCubit>(
          create: (BuildContext context) => getIt<CashierReportsCubit>()..getCashiers(),
        ),
        BlocProvider<SubCategoryReportsCubit>(
          create: (BuildContext context) => getIt<SubCategoryReportsCubit>()..getSubCategories(),
        ),
        BlocProvider<ProductReportsCubit>(
          create: (BuildContext context) => getIt<ProductReportsCubit>()..getProducts(),
        ),
        BlocProvider<MerchantInfoBloc>(
          create: (BuildContext context) => getIt<MerchantInfoBloc>()..add(const GetMerchantInformationEvent()),
        ),
        BlocProvider<MyAccountBloc>(
          create: (BuildContext context) => getIt<MyAccountBloc>()..add(const GetAccountDetailsEvent()),
        ),
        BlocProvider<TableCubit>(
          create: (context) => getIt<TableCubit>()..getAllTables(),
        ),
        BlocProvider(
          create: (context) => getIt<PrivacyCubit>(),
        ),
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => getIt<SettingsBloc>(),
        ),
        BlocProvider<SelectPlanCubit>(create: (context) => getIt<SelectPlanCubit>()),
        BlocProvider(
          create: (context) => getIt<BillingHistoryCubit>()..getBillingHistories(),
        ),
        BlocProvider(
          create: (context) => getIt<BranchShiftCubit>(),
        ),
        BlocProvider<RegionCubit>(
          create: (context) => getIt<RegionCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CreditHistoryCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LoyaltyPointHistoryCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LoyaltySettingsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<OnlineOrderingCubit>()..getOnlineOrderingSettings(),
        ),
        BlocProvider(
          create: (context) => getIt<AreaManagementCubit>()..getBranchAreas(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationsBloc>()
            ..add(const GetAllNotificationTypeEvent())
            ..add(const GetNotificationKeyWords())
            ..add(const GetAllNotificationEventsEvent()),
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            const ResponsiveLayout(
                desktopLayout: DesktopMainWidget(),
                webLayout: DesktopMainWidget(),
                mobileLayout: MobileMainWidget(),
                tabletLayout: MobileMainWidget()),
            Obx(() => Visibility(visible: showSetupGuide.value, child: const SignupSetupGuideScreen())),
          ],
        ),
      ),
    );
  }
}
