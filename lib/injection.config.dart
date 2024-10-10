// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:math' as _i407;

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import 'core/client/dio/dio_client.dart' as _i831;
import 'core/client/user_session.dart' as _i79;
import 'core/localazation/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i61;
import 'core/localazation/service/localization_service/localization_service.dart'
    as _i657;
import 'core/utils/configuration.dart' as _i338;
import 'feature/area_management/data/data_source/area_management_remote_datasource.dart'
    as _i1010;
import 'feature/area_management/data/repository/area_management_repository.dart'
    as _i902;
import 'feature/area_management/presentation/blocs/area_management_cubit.dart'
    as _i890;
import 'feature/auth/data/data_sources/login_local_datasource.dart' as _i862;
import 'feature/auth/data/data_sources/login_remote_datasource.dart' as _i209;
import 'feature/auth/data/repository/login_repository.dart' as _i493;
import 'feature/auth/presentation/blocs/login_bloc.dart' as _i107;
import 'feature/business_hours/data/data_source/branch_shifts_remote_datasource.dart'
    as _i938;
import 'feature/business_hours/data/repository/branch_shift_repository.dart'
    as _i88;
import 'feature/business_hours/presentation/blocs/cubit/branch_shift_cubit.dart'
    as _i958;
import 'feature/cashiers/data/data_source/cashier_remote_datasource.dart'
    as _i141;
import 'feature/cashiers/data/repository/cashier_repository.dart' as _i1015;
import 'feature/cashiers/presentation/blocs/cashier_bloc.dart' as _i509;
import 'feature/customers/data/data_source/customer_remote_datasource.dart'
    as _i1020;
import 'feature/customers/data/repository/customer_repository.dart' as _i217;
import 'feature/customers/presentation/blocs/credit_history/credit_history_cubit.dart'
    as _i299;
import 'feature/customers/presentation/blocs/customers/customer_bloc.dart'
    as _i627;
import 'feature/customers/presentation/blocs/payment/customer_payment_cubit.dart'
    as _i519;
import 'feature/dashboard/data/data_source/dashboard_remote_datasource.dart'
    as _i602;
import 'feature/dashboard/data/repository/dashboard_repository.dart' as _i499;
import 'feature/dashboard/presentation/blocs/dashboard_bloc.dart' as _i159;
import 'feature/device/data/data_source/device_remote_datasource.dart' as _i789;
import 'feature/device/data/repository/device_repository.dart' as _i48;
import 'feature/device/presentation/blocs/device_cubit.dart' as _i242;
import 'feature/expense/data/data_source/expense_remote_datasource.dart'
    as _i545;
import 'feature/expense/data/repository/expense_repository.dart' as _i83;
import 'feature/expense/presentation/blocs/expense_cubit.dart' as _i429;
import 'feature/loyalty/data/data_source/loyalty_point_remote_datasource.dart'
    as _i486;
import 'feature/loyalty/data/repository/loyalty_point_repository.dart' as _i36;
import 'feature/loyalty/presentation/blocs/loyalty_point/loyalty_point_history_cubit.dart'
    as _i1017;
import 'feature/loyalty/presentation/blocs/loyalty_settings/loyalty_settings_cubit.dart'
    as _i229;
import 'feature/main_screen/data/data_source/main_remote_datasource.dart'
    as _i471;
import 'feature/main_screen/data/repository/main_repository.dart' as _i532;
import 'feature/main_screen/presentation/blocs/main_screen_bloc.dart' as _i172;
import 'feature/main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart'
    as _i595;
import 'feature/manage_features/data/data_source/manage_feature_remote_datasource.dart'
    as _i616;
import 'feature/manage_features/data/repository/manage_features_repository.dart'
    as _i708;
import 'feature/manage_features/presentation/blocs/cubit/manage_feautre_cubit.dart'
    as _i1022;
import 'feature/merchant_info/data/data_source/merchant_info_remote_datasource.dart'
    as _i24;
import 'feature/merchant_info/data/repository/merchant_info_repository.dart'
    as _i196;
import 'feature/merchant_info/presentation/blocs/merchant_info_bloc.dart'
    as _i406;
import 'feature/my_account/data/data_source/account_details_remote_datasource.dart'
    as _i919;
import 'feature/my_account/data/repository/account_details_repository.dart'
    as _i575;
import 'feature/my_account/presentation/blocs/my_account_bloc.dart' as _i995;
import 'feature/notifications/data/data_source/notifications_remote_datasource.dart'
    as _i932;
import 'feature/notifications/data/repository/notifications_repository.dart'
    as _i331;
import 'feature/notifications/presentation/blocs/notifications_bloc.dart'
    as _i372;
import 'feature/online_ordering/data/data_source/online_ordering_datasource.dart'
    as _i278;
import 'feature/online_ordering/data/repository/online_ordering_repository.dart'
    as _i387;
import 'feature/online_ordering/presentation/blocs/online_ordering_cubit.dart'
    as _i1038;
import 'feature/orders/data/data_source/orders_remote_datesource.dart' as _i211;
import 'feature/orders/data/repository/orders_repository.dart' as _i122;
import 'feature/orders/presentation/blocs/order_management_bloc.dart' as _i90;
import 'feature/products/data/data_source/category_remote_datasource.dart'
    as _i1000;
import 'feature/products/data/data_source/product_remote_datasource.dart'
    as _i989;
import 'feature/products/data/repository/category_repository.dart' as _i1047;
import 'feature/products/data/repository/product_repository.dart' as _i17;
import 'feature/products/presentation/blocs/main_category/main_category_bloc.dart'
    as _i856;
import 'feature/products/presentation/blocs/products/products_bloc.dart'
    as _i317;
import 'feature/products/presentation/blocs/sub_category/sub_category_bloc.dart'
    as _i6;
import 'feature/region/data/data_source/region_remote_datasource.dart' as _i703;
import 'feature/region/data/repository/region_repository.dart' as _i734;
import 'feature/region/presentation/blocs/region_cubit.dart' as _i1060;
import 'feature/report/data/data_source/reports_remote_datasource.dart'
    as _i1033;
import 'feature/report/data/repository/reports_repository.dart' as _i221;
import 'feature/report/presentation/blocs/cashiers/cashier_reports_cubit.dart'
    as _i259;
import 'feature/report/presentation/blocs/products/product_reports_cubit.dart'
    as _i569;
import 'feature/report/presentation/blocs/sub_categories/sub_category_reports_cubit.dart'
    as _i165;
import 'feature/settings/data/data_store/settings_remote_datasource.dart'
    as _i112;
import 'feature/settings/data/repository/settings_repository.dart' as _i384;
import 'feature/settings/presentation/blocs/settings_bloc.dart' as _i225;
import 'feature/signup/data/data_source/signup_remote_datasource.dart' as _i399;
import 'feature/signup/data/repository/signup_repository.dart' as _i1045;
import 'feature/signup/presentation/blocs/sign_up_bloc.dart' as _i657;
import 'feature/stock/data/data_source/stock_remote_datasouce.dart' as _i395;
import 'feature/stock/data/repository/stock_repository.dart' as _i1046;
import 'feature/stock/presentation/blocs/stock_bloc.dart' as _i950;
import 'feature/subscription/data/data_source/subscription_remote_datasource.dart'
    as _i983;
import 'feature/subscription/data/repository/subscription_repository.dart'
    as _i309;
import 'feature/subscription/presentation/blocs/billing_history/cubit/billing_history_cubit.dart'
    as _i113;
import 'feature/subscription/presentation/blocs/payment/payment_status_cubit.dart'
    as _i168;
import 'feature/subscription/presentation/blocs/select_plan/cubit/select_plan_cubit.dart'
    as _i473;
import 'feature/support_privacy/presentation/blocs/cubit/privacy_cubit.dart'
    as _i486;
import 'feature/tables/data/data_source/table_remote_data_source.dart' as _i305;
import 'feature/tables/data/repository/table_repository.dart' as _i939;
import 'feature/tables/presentation/blocs/cubit/table_cubit.dart' as _i707;
import 'feature/transaction/data/data_source/transaction_remote_datasource.dart'
    as _i105;
import 'feature/transaction/data/repository/transaction_repository.dart'
    as _i1045;
import 'feature/transaction/presentation/blocs/transaction_bloc.dart' as _i116;
import 'feature/workers/data/data_source/worker_remote_datasource.dart'
    as _i453;
import 'feature/workers/data/repository/worker_repository.dart' as _i770;
import 'feature/workers/presentation/blocs/workers_cubit.dart' as _i866;
import 'injectable_module.dart' as _i109;

const String _staging = 'staging';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i792.GetStorage>(() => injectableModule.getStorage);
    gh.lazySingleton<_i79.IUserSession>(() => _i79.UserSession(
          gh<_i792.GetStorage>(),
          gh<_i862.ILoginLocalDataSource>(),
        ));
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i407.Random>(() => injectableModule.random);
    gh.lazySingleton<_i361.CancelToken>(() => injectableModule.compute());
    gh.lazySingleton<_i1000.ICategoryRemoteDataSource>(
        () => _i1000.CategoryRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i471.IMainRemoteDataSource>(
        () => _i471.MainRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i211.IOrdersRemoteDataSource>(
        () => _i211.OrderRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i112.ISettingsRemoteDataSource>(
        () => _i112.SettingsRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i1033.IReportsRemoteDataSource>(
        () => _i1033.ReportsRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i453.IWorkerRemoteDataSource>(
        () => _i453.WorkerRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i24.IMerchantInfoRemoteDataSource>(
        () => _i24.MerchantInfoRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i789.IDeviceRemoteDataSource>(
        () => _i789.DeviceRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i209.ILoginRemoteDataSource>(
        () => _i209.LoginRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i989.IProductRemoteDataSource>(
        () => _i989.ProductRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i105.ITransactionRemoteDataSource>(
        () => _i105.TransactionRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i61.LocalizationPreferencesHelper>(
        () => _i61.LocalizationPreferencesHelper(gh<_i792.GetStorage>()));
    gh.lazySingleton<_i616.IManageFeatureRemoteDataSource>(
        () => _i616.ManageFeatureRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i703.IRegionRemoteDataSource>(
        () => _i703.RegionRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i338.Configuration>(
      () => _i338.StagingConfiguration(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i17.IProductRepository>(
        () => _i17.ProductRepository(gh<_i989.IProductRemoteDataSource>()));
    gh.lazySingleton<_i919.IAccountDetailsRemoteDataSource>(
        () => _i919.AccountDetailsRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i141.ICashierRemoteDataSource>(
        () => _i141.CashierRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i862.ILoginLocalDataSource>(
        () => _i862.LocalDataSource(gh<_i792.GetStorage>()));
    gh.lazySingleton<_i938.IBranchRemoteDataSource>(
        () => _i938.BranchRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i708.IManageFeaturesRepository>(() =>
        _i708.ManageFeaturesRepository(
            gh<_i616.IManageFeatureRemoteDataSource>()));
    gh.lazySingleton<_i1010.IAreaManagementRemoteDataSource>(
        () => _i1010.AreaManagementRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i545.IExpenseRemoteDataSource>(
        () => _i545.ExpenseRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i932.INotificationsRemoteDataSource>(
        () => _i932.NotificationRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i196.IMerchantInfoRepository>(
        () => _i196.MerchantInfoRepository(
              gh<_i24.IMerchantInfoRemoteDataSource>(),
              gh<_i862.ILoginLocalDataSource>(),
            ));
    gh.lazySingleton<_i1020.ICustomerRemoteDataSource>(
        () => _i1020.CustomerRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i983.ISubscriptionRemoteDataSource>(
        () => _i983.SubscriptionRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i338.Configuration>(
      () => _i338.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i278.IOnlineOrderingRemoteDataSource>(
        () => _i278.OnlineOrderingRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i395.IStockRemoteDataSource>(
        () => _i395.StockRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i305.ITableRemoteDataSource>(
        () => _i305.TableRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i317.ProductsBloc>(
        () => _i317.ProductsBloc(gh<_i17.IProductRepository>()));
    gh.lazySingleton<_i602.IDashboardRemoteDataSource>(
        () => _i602.DashboardRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i486.ILoyaltyPointRemoteDataSource>(
        () => _i486.LoyaltyPointRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i399.ISignUpRemoteDataSource>(
        () => _i399.SignUpRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i831.IDioClient>(() => _i831.DioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i902.IAreaManagementRepository>(() =>
        _i902.AreaManagementRepository(
            gh<_i1010.IAreaManagementRemoteDataSource>()));
    gh.lazySingleton<_i734.IRegionRepository>(
        () => _i734.RegionRepository(gh<_i703.IRegionRemoteDataSource>()));
    gh.lazySingleton<_i331.INotificationsRepository>(() =>
        _i331.NotificationsRepository(
            gh<_i932.INotificationsRemoteDataSource>()));
    gh.lazySingleton<_i83.IExpenseRepository>(
        () => _i83.ExpenseRepository(gh<_i545.IExpenseRemoteDataSource>()));
    gh.factory<_i1060.RegionCubit>(
        () => _i1060.RegionCubit(gh<_i734.IRegionRepository>()));
    gh.lazySingleton<_i338.Configuration>(
      () => _i338.ProductionConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i1046.IStockRepository>(
        () => _i1046.StockRepository(gh<_i395.IStockRemoteDataSource>()));
    gh.lazySingleton<_i217.ICustomerRepository>(
        () => _i217.CustomerRepository(gh<_i1020.ICustomerRemoteDataSource>()));
    gh.lazySingleton<_i48.IDeviceRepository>(
        () => _i48.DeviceRepository(gh<_i789.IDeviceRemoteDataSource>()));
    gh.factory<_i657.LocalizationService>(() =>
        _i657.LocalizationService(gh<_i61.LocalizationPreferencesHelper>()));
    gh.factory<_i890.AreaManagementCubit>(
        () => _i890.AreaManagementCubit(gh<_i902.IAreaManagementRepository>()));
    gh.lazySingleton<_i1045.ISignUpRepository>(() => _i1045.SignUpRepository(
          gh<_i399.ISignUpRemoteDataSource>(),
          gh<_i862.ILoginLocalDataSource>(),
        ));
    gh.lazySingleton<_i1047.ICategoryRepository>(
        () => _i1047.CategoryRepository(
              gh<_i1000.ICategoryRemoteDataSource>(),
              gh<_i862.ILoginLocalDataSource>(),
            ));
    gh.lazySingleton<_i309.ISubscriptionRepository>(() =>
        _i309.SubscriptionRepository(
            gh<_i983.ISubscriptionRemoteDataSource>()));
    gh.lazySingleton<_i387.IOnlineOrderingRepository>(() =>
        _i387.OnlineOrderingRepository(
            gh<_i278.IOnlineOrderingRemoteDataSource>()));
    gh.lazySingleton<_i384.ISettingsRepository>(
        () => _i384.SettingsRepository(gh<_i112.ISettingsRemoteDataSource>()));
    gh.lazySingleton<_i122.IOrdersRepository>(
        () => _i122.OrdersRepository(gh<_i211.IOrdersRemoteDataSource>()));
    gh.lazySingleton<_i1045.ITransactionRepository>(() =>
        _i1045.TransactionRepository(gh<_i105.ITransactionRemoteDataSource>()));
    gh.lazySingleton<_i532.IMainRepository>(() => _i532.MainRepository(
          gh<_i471.IMainRemoteDataSource>(),
          gh<_i862.ILoginLocalDataSource>(),
        ));
    gh.factory<_i299.CreditHistoryCubit>(
        () => _i299.CreditHistoryCubit(gh<_i217.ICustomerRepository>()));
    gh.factory<_i950.StockBloc>(() => _i950.StockBloc(
          gh<_i1046.IStockRepository>(),
          gh<_i17.IProductRepository>(),
        ));
    gh.lazySingleton<_i770.IWorkerRepository>(
        () => _i770.WorkerRepository(gh<_i453.IWorkerRemoteDataSource>()));
    gh.factory<_i657.SignUpBloc>(
        () => _i657.SignUpBloc(gh<_i1045.ISignUpRepository>()));
    gh.lazySingleton<_i36.ILoyaltyPointRepository>(() =>
        _i36.LoyaltyPointRepository(gh<_i486.ILoyaltyPointRemoteDataSource>()));
    gh.lazySingleton<_i1015.ICashierRepository>(
        () => _i1015.CashierRepository(gh<_i141.ICashierRemoteDataSource>()));
    gh.factory<_i1017.LoyaltyPointHistoryCubit>(() =>
        _i1017.LoyaltyPointHistoryCubit(gh<_i36.ILoyaltyPointRepository>()));
    gh.lazySingleton<_i493.ILoginRepository>(() => _i493.LoginRepository(
          gh<_i209.ILoginRemoteDataSource>(),
          gh<_i862.ILoginLocalDataSource>(),
        ));
    gh.lazySingleton<_i221.IReportsRepository>(
        () => _i221.ReportRepository(gh<_i1033.IReportsRemoteDataSource>()));
    gh.singleton<_i172.MainScreenBloc>(() => _i172.MainScreenBloc(
          gh<_i532.IMainRepository>(),
          gh<_i862.ILoginLocalDataSource>(),
          gh<_i17.IProductRepository>(),
        ));
    gh.factory<_i168.PaymentStatusCubit>(
        () => _i168.PaymentStatusCubit(gh<_i309.ISubscriptionRepository>()));
    gh.factory<_i473.SelectPlanCubit>(
        () => _i473.SelectPlanCubit(gh<_i309.ISubscriptionRepository>()));
    gh.factory<_i113.BillingHistoryCubit>(
        () => _i113.BillingHistoryCubit(gh<_i309.ISubscriptionRepository>()));
    gh.lazySingleton<_i939.ITableRepository>(
        () => _i939.TableRepository(gh<_i305.ITableRemoteDataSource>()));
    gh.factory<_i509.CashierBloc>(
        () => _i509.CashierBloc(gh<_i1015.ICashierRepository>()));
    gh.lazySingleton<_i88.IBranchShiftRepository>(
        () => _i88.BranchShiftRepository(gh<_i938.IBranchRemoteDataSource>()));
    gh.factory<_i1038.OnlineOrderingCubit>(() =>
        _i1038.OnlineOrderingCubit(gh<_i387.IOnlineOrderingRepository>()));
    gh.lazySingleton<_i575.IAccountDetailsRepository>(
        () => _i575.AccountDetailsRepository(
              gh<_i919.IAccountDetailsRemoteDataSource>(),
              gh<_i862.ILoginLocalDataSource>(),
            ));
    gh.singleton<_i1022.ManageFeautreCubit>(
        () => _i1022.ManageFeautreCubit(gh<_i708.IManageFeaturesRepository>()));
    gh.factory<_i406.MerchantInfoBloc>(
        () => _i406.MerchantInfoBloc(gh<_i196.IMerchantInfoRepository>()));
    gh.factory<_i242.DeviceCubit>(
        () => _i242.DeviceCubit(gh<_i48.IDeviceRepository>()));
    gh.lazySingleton<_i499.IDashboardRepository>(() =>
        _i499.DashboardRepository(gh<_i602.IDashboardRemoteDataSource>()));
    gh.factory<_i372.NotificationsBloc>(
        () => _i372.NotificationsBloc(gh<_i331.INotificationsRepository>()));
    gh.factory<_i6.SubCategoryBloc>(
        () => _i6.SubCategoryBloc(gh<_i1047.ICategoryRepository>()));
    gh.factory<_i856.MainCategoryBloc>(
        () => _i856.MainCategoryBloc(gh<_i1047.ICategoryRepository>()));
    gh.factory<_i569.ProductReportsCubit>(
        () => _i569.ProductReportsCubit(gh<_i221.IReportsRepository>()));
    gh.factory<_i165.SubCategoryReportsCubit>(
        () => _i165.SubCategoryReportsCubit(gh<_i221.IReportsRepository>()));
    gh.factory<_i259.CashierReportsCubit>(
        () => _i259.CashierReportsCubit(gh<_i221.IReportsRepository>()));
    gh.factory<_i627.CustomerBloc>(() => _i627.CustomerBloc(
          gh<_i217.ICustomerRepository>(),
          gh<_i1045.ITransactionRepository>(),
        ));
    gh.singleton<_i595.MenuDrawerCubit>(
        () => _i595.MenuDrawerCubit(gh<_i532.IMainRepository>()));
    gh.factory<_i90.OrderManagementBloc>(() => _i90.OrderManagementBloc(
          gh<_i122.IOrdersRepository>(),
          gh<_i384.ISettingsRepository>(),
          gh<_i1015.ICashierRepository>(),
        ));
    gh.factory<_i866.WorkersCubit>(
        () => _i866.WorkersCubit(gh<_i770.IWorkerRepository>()));
    gh.factory<_i225.SettingsBloc>(() => _i225.SettingsBloc(
          gh<_i384.ISettingsRepository>(),
          gh<_i48.IDeviceRepository>(),
          gh<_i1045.ISignUpRepository>(),
        ));
    gh.factory<_i519.CustomerPaymentCubit>(() => _i519.CustomerPaymentCubit(
          gh<_i217.ICustomerRepository>(),
          gh<_i384.ISettingsRepository>(),
        ));
    gh.singleton<_i107.LoginBloc>(
        () => _i107.LoginBloc(gh<_i493.ILoginRepository>()));
    gh.singleton<_i429.ExpenseCubit>(() => _i429.ExpenseCubit(
          gh<_i83.IExpenseRepository>(),
          gh<_i384.ISettingsRepository>(),
        ));
    gh.factory<_i958.BranchShiftCubit>(
        () => _i958.BranchShiftCubit(gh<_i88.IBranchShiftRepository>()));
    gh.factory<_i707.TableCubit>(
        () => _i707.TableCubit(gh<_i939.ITableRepository>()));
    gh.factory<_i229.LoyaltySettingsCubit>(
        () => _i229.LoyaltySettingsCubit(gh<_i36.ILoyaltyPointRepository>()));
    gh.factory<_i116.TransactionBloc>(() => _i116.TransactionBloc(
          gh<_i1045.ITransactionRepository>(),
          gh<_i17.IProductRepository>(),
          gh<_i1015.ICashierRepository>(),
          gh<_i1047.ICategoryRepository>(),
        ));
    gh.factory<_i159.DashboardBloc>(() => _i159.DashboardBloc(
          gh<_i499.IDashboardRepository>(),
          gh<_i1045.ITransactionRepository>(),
        ));
    gh.factory<_i486.PrivacyCubit>(
        () => _i486.PrivacyCubit(gh<_i575.IAccountDetailsRepository>()));
    gh.factory<_i995.MyAccountBloc>(
        () => _i995.MyAccountBloc(gh<_i575.IAccountDetailsRepository>()));
    return this;
  }
}

class _$InjectableModule extends _i109.InjectableModule {}
