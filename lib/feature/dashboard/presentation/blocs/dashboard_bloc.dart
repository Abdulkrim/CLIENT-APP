import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/base_bloc.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/cashier_report.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/sales_statistics.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/entities/worker_report.dart';
import 'package:merchant_dashboard/feature/dashboard/data/repository/dashboard_repository.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/TopLastOrders.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/data/repository/transaction_repository.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../core/utils/failure.dart';
import '../../../../injection.dart';
import '../../../auth/presentation/blocs/login_bloc.dart';
import '../../../expense/presentation/blocs/expense_cubit.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../orders/data/models/response/top_last/top_last_orders_response.dart';
import '../../data/models/entities/orders_statistics.dart';
import '../../data/models/entities/sales_per_timeline.dart';
import '../../data/models/entities/top_sale_item.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

enum TimeLines { today, week, month, dateRange }

@injectable
class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> with DateTimeUtilities {
  final IDashboardRepository _dashboardRepository;
  final ITransactionRepository _transactionRepository;

  List<SalesPerTimeline> salesPerTime = [];
  String selectedSalesTime = '-';

  TimeLines get selectedTimeLine => switch (selectedSalesTime) {
        'Today' => TimeLines.today,
        'Week' => TimeLines.week,
        'Month' => TimeLines.month,
        _ => TimeLines.dateRange,
      };

  List<TopSaleItem> topSalesItems = [];
  List<TopSaleItem> topSalesSubCategories = [];

  List<TopSaleItem> topOrderItems = [];
  List<TopSaleItem> topOrderSubCategories = [];

  List<Transaction> transactions = [];

  List<TopLastOrdersModel> ordersTransactions = [];

  SalesStatistics? salesStatistics;
  OrdersStatistics? ordersStatistics;

  List<CashierReport> cashiers = [];
  List<WorkerReport> workers = [];

  bool topSalesBasedOnQuantity = true;
  bool topOrdersBasedOnQuantity = true;

  DashboardBloc(this._dashboardRepository, this._transactionRepository) : super(DashboardInitial()) {
    refreshDashboard() {
      salesPerTime = [];
      topSalesItems = [];
      topSalesSubCategories = [];
      topOrderItems = [];
      topOrderSubCategories = [];
      transactions = [];
      ordersTransactions = [];
      salesStatistics = null;
      ordersStatistics = null;
      cashiers = [];

      add(const GetTodayDataEvent());
    }

    getIt<LoginBloc>().stream.listen((event) {
      if (event is LoginRequestState && event.isSuccess) {
        getIt<MainScreenBloc>().add(const InitalEventsCall());
      }
    });

    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        refreshDashboard();
      }
    });

    on<GetTodayDataEvent>((event, emit) {
      add(const GetSalesPerToday());
      add(const GetSalesStatisticsPerToday());
      add(const GetReportsPerToday());
      add(GetTopSalesPerToday(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopOrderSalesPerToday(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopSubCategoriesPerToday(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopOrderSubCategoriesPerToday(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(const GetTransactionsPerToday());
      add(const GetOrdersPerToday());
      add(const GetOrdersStatisticsPerToday());
      add(const GetWorkersPerToday());

      getIt<ExpenseCubit>().getExpenses(requestedFromDate: todayDate, requestedToDate: todayDate);
    });
    on<GetWeekDataEvent>((event, emit) {
      add(const GetSalesPerWeek());
      add(const GetSalesStatisticsPerWeek());
      add(const GetReportsPerWeek());
      add(GetTopSalesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopOrderSalesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopSubCategoriesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopOrderSubCategoriesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(const GetTransactionsPerWeek());
      add(const GetOrdersPerWeek());
      add(const GetOrdersStatisticsPerWeek());
      add(const GetWorkersPerWeek());

      getIt<ExpenseCubit>().getExpenses(requestedFromDate: weekAgoDate, requestedToDate: todayDate);
    });
    on<GetMonthDataEvent>((event, emit) {
      add(const GetSalesPerMonth());
      add(const GetSalesStatisticsPerMonth());
      add(GetTopSalesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopOrderSalesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(const GetReportsPerMonth());
      add(GetTopSubCategoriesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(GetTopOrderSubCategoriesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity ?? true));
      add(const GetTransactionsPerMonth());
      add(const GetOrdersPerMonth());
      add(const GetOrdersStatisticsPerMonth());
      add(const GetWorkersPerMonth());

      getIt<ExpenseCubit>().getExpenses(requestedFromDate: monthAgoDate, requestedToDate: todayDate);
    });
    on<GetRangeDataEvent>((event, emit) {
      add(GetSalesPerDateRange(event.startDate, event.endDate));
      add(GetSalesStatisticsPerDateRange(event.startDate, event.endDate));
      add(GetTopSalesPerDateRange(event.startDate, event.endDate, event.isBasedOnQuantity ?? true));
      add(GetTopOrderSalesPerDateRange(event.startDate, event.endDate, event.isBasedOnQuantity ?? true));
      add(GetReportsPerDate(event.startDate, event.endDate));
      add(GetTopSubCategoriesPerDate(event.startDate, event.endDate, event.isBasedOnQuantity ?? true));
      add(GetTopOrderSubCategoriesPerDate(event.startDate, event.endDate, event.isBasedOnQuantity ?? true));
      add(GetTransactionsPerDate(event.startDate, event.endDate));
      add(GetOrdersPerDate(event.startDate, event.endDate));
      add(GetOrdersStatisticsPerDate(event.startDate, event.endDate));
      add(GetWorkersPerDate(event.startDate, event.endDate));

      getIt<ExpenseCubit>().getExpenses(requestedFromDate: event.startDate, requestedToDate: event.endDate);
    });

    on<ChangeTopSalesProductBaseEvent>((event, emit) {
      topSalesBasedOnQuantity = event.isBasedOnQuantity;
      switch (selectedTimeLine) {
        case TimeLines.today:
          {
            add(GetTopSalesPerToday(isBasedOnQuantity: event.isBasedOnQuantity));
            add(GetTopSubCategoriesPerToday(isBasedOnQuantity: event.isBasedOnQuantity));
          }
        case TimeLines.week:
          {
            add(GetTopSalesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity));
            add(GetTopSubCategoriesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity));
          }
        case TimeLines.month:
          {
            add(GetTopSalesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity));
            add(GetTopSubCategoriesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity));
          }
        case TimeLines.dateRange:
          {
            final dates = selectedSalesTime.split(' to ');
            add(GetTopSalesPerDateRange(dates[0], dates[1], event.isBasedOnQuantity));
            add(GetTopOrderSubCategoriesPerDate(dates[0], dates[1], event.isBasedOnQuantity));
          }
      }
    });

    on<ChangeTopOrderProductsBaseEvent>((event, emit) {
      topOrdersBasedOnQuantity = event.isBasedOnQuantity;
      switch (selectedTimeLine) {
        case TimeLines.today:
          {
            add(GetTopOrderSalesPerToday(isBasedOnQuantity: event.isBasedOnQuantity));
            add(GetTopOrderSubCategoriesPerToday(isBasedOnQuantity: event.isBasedOnQuantity));
          }
        case TimeLines.week:
          {
            add(GetTopOrderSalesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity));
            add(GetTopOrderSubCategoriesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity));
          }
        case TimeLines.month:
          {
            add(GetTopOrderSalesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity));
            add(GetTopOrderSubCategoriesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity));
          }
        case TimeLines.dateRange:
          {
            final dates = selectedSalesTime.split(' to ');
            add(GetTopOrderSalesPerDateRange(dates[0], dates[1], event.isBasedOnQuantity));
            add(GetTopSubCategoriesPerDate(dates[0], dates[1], event.isBasedOnQuantity));
          }
      }
    });

    on<GetWorkersPerToday>((event, emit) async {
      selectedSalesTime = 'Today';
      emit(const GetWorkersStates(isLoading: true));
      final Either<Failure, List<WorkerReport>> salesPerToday = await _dashboardRepository.getWorkerSalesPerToday();

      salesPerToday.fold((left) {
        workers = [];
        emit(GetWorkersStates(errorMessage: left.errorMessage));
      }, (right) {
        workers = right;
        emit(const GetWorkersStates(successDate: 'Today'));
      });
    });
    on<GetWorkersPerWeek>((event, emit) async {
      selectedSalesTime = 'Week';
      emit(const GetWorkersStates(isLoading: true));
      final Either<Failure, List<WorkerReport>> salesPerToday = await _dashboardRepository.getWorkerSalesPerWeek();

      salesPerToday.fold((left) {
        workers = [];
        emit(GetWorkersStates(errorMessage: left.errorMessage));
      }, (right) {
        workers = right;
        emit(const GetWorkersStates(successDate: 'Week'));
      });
    });
    on<GetWorkersPerMonth>((event, emit) async {
      selectedSalesTime = 'Month';
      emit(const GetWorkersStates(isLoading: true));
      final Either<Failure, List<WorkerReport>> salesPerToday = await _dashboardRepository.getWorkerSalesPerMonth();

      salesPerToday.fold((left) {
        workers = [];
        emit(GetWorkersStates(errorMessage: left.errorMessage));
      }, (right) {
        workers = right;
        emit(const GetWorkersStates(successDate: 'Month'));
      });
    });
    on<GetWorkersPerDate>((event, emit) async {
      selectedSalesTime = '${event.startDate} to ${event.endDate}';
      emit(const GetWorkersStates(isLoading: true));
      final Either<Failure, List<WorkerReport>> salesPerToday =
          await _dashboardRepository.getWorkerSalesPerDateRange(event.startDate, event.endDate);

      salesPerToday.fold((left) {
        workers = [];
        emit(GetWorkersStates(errorMessage: left.errorMessage));
      }, (right) {
        workers = right;
        emit(GetWorkersStates(successDate: '${event.startDate} to ${event.endDate}'));
      });
    });

    on<GetSalesPerToday>((event, emit) async {
      selectedSalesTime = 'Today';
      emit(const GetSalesLoadingState());
      final Either<Failure, List<SalesPerTimeline>> salesPerToday = await _dashboardRepository.getSalesPerToday();

      salesPerToday.fold((left) {
        salesPerTime = [];
        emit(GetSalesFailedState(left.errorMessage));
      }, (right) {
        salesPerTime = right;
        emit(GetSalesSuccessState(right, 'Today'));
      });
    });
    on<GetSalesPerWeek>((event, emit) async {
      selectedSalesTime = 'Week';
      emit(const GetSalesLoadingState());
      final Either<Failure, List<SalesPerTimeline>> salesPerWeek = await _dashboardRepository.getSalesPerWeek();

      salesPerWeek.fold((left) {
        salesPerTime = [];
        emit(GetSalesFailedState(left.errorMessage));
      }, (right) {
        salesPerTime = right;
        emit(GetSalesSuccessState(right, 'Week'));
      });
    });
    on<GetSalesPerMonth>((event, emit) async {
      selectedSalesTime = 'Month';
      emit(const GetSalesLoadingState());
      final Either<Failure, List<SalesPerTimeline>> salesPerWeek = await _dashboardRepository.getSalesPerMonth();

      salesPerWeek.fold((left) {
        salesPerTime = [];
        emit(GetSalesFailedState(left.errorMessage));
      }, (right) {
        salesPerTime = right;
        emit(GetSalesSuccessState(right, 'Month'));
      });
    });
    on<GetSalesPerDateRange>((event, emit) async {
      selectedSalesTime = '${event.startDate} to ${event.endDate}';
      emit(const GetSalesLoadingState());
      final Either<Failure, List<SalesPerTimeline>> salesPerWeek =
          await _dashboardRepository.getSalesPerDate(event.startDate, event.endDate);

      salesPerWeek.fold((left) {
        salesPerTime = [];
        emit(GetSalesFailedState(left.errorMessage));
      }, (right) {
        salesPerTime = right;
        emit(GetSalesSuccessState(right, '${event.startDate} to ${event.endDate}'));
      });
    });

    on<GetSalesStatisticsPerToday>((event, emit) async {
      emit(const GetSalesStatisticsLoadingState());
      final Either<Failure, SalesStatistics> statisticsResponse = await _dashboardRepository.getSalesStatisticsPerToday();

      statisticsResponse.fold((left) {
        salesStatistics = null;
        emit(GetSalesStatisticsFailedState(left.errorMessage));
      }, (right) {
        salesStatistics = right;

        emit(GetSalesStatisticsSuccessState(right.paymentStats, right.totalPrice.toString()));
      });
    });
    on<GetSalesStatisticsPerWeek>((event, emit) async {
      emit(const GetSalesStatisticsLoadingState());
      final Either<Failure, SalesStatistics> statisticsResponse = await _dashboardRepository.getSalesStatisticsPerWeek();

      statisticsResponse.fold((left) {
        salesStatistics = null;
        emit(GetSalesStatisticsFailedState(left.errorMessage));
      }, (right) {
        salesStatistics = right;
        emit(GetSalesStatisticsSuccessState(right.paymentStats, right.totalPrice.toString()));
      });
    });
    on<GetSalesStatisticsPerMonth>((event, emit) async {
      emit(const GetSalesStatisticsLoadingState());
      final Either<Failure, SalesStatistics> statisticsResponse = await _dashboardRepository.getSalesStatisticsPerMonth();

      statisticsResponse.fold((left) {
        salesStatistics = null;
        emit(GetSalesStatisticsFailedState(left.errorMessage));
      }, (right) {
        salesStatistics = right;
        emit(GetSalesStatisticsSuccessState(right.paymentStats, right.totalPrice.toString()));
      });
    });
    on<GetSalesStatisticsPerDateRange>((event, emit) async {
      emit(const GetSalesStatisticsLoadingState());
      final Either<Failure, SalesStatistics> statisticsResponse =
          await _dashboardRepository.getSalesStatisticsPerDate(event.startDate, event.endDate);

      statisticsResponse.fold((left) {
        salesStatistics = null;
        emit(GetSalesStatisticsFailedState(left.errorMessage));
      }, (right) {
        salesStatistics = right;
        emit(GetSalesStatisticsSuccessState(right.paymentStats, right.totalPrice.toString()));
      });
    });

    on<GetTopSalesPerToday>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopSalesPerToday(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topSalesItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopOrderSalesPerToday>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopOrderSalesPerToday(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topOrderItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopSalesPerWeek>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopSalesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topSalesItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopOrderSalesPerWeek>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopOrderSalesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topOrderItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopSalesPerMonth>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopSalesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topSalesItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopOrderSalesPerMonth>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopOrderSalesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topOrderItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopSalesPerDateRange>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse = await _dashboardRepository.getTopSalesPerDate(
          startDate: event.startDate, endDate: event.endDate, isBasedOnQuantity: event.isBasedOnQuantity);
      topSalesResponse.fold((left) {
        topSalesItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topSalesItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetTopOrderSalesPerDateRange>((event, emit) async {
      emit(const GetTopSalesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse = await _dashboardRepository.getTopOrderSalesPerDateRange(
          startDate: event.startDate, endDate: event.endDate, isBasedOnQuantity: event.isBasedOnQuantity);
      topSalesResponse.fold((left) {
        topOrderItems = [];
        emit(GetTopSalesFailedState(left.errorMessage));
      }, (right) {
        topOrderItems = right;
        emit(GetTopSalesSuccessState(right));
      });
    });

    on<GetReportsPerToday>((event, emit) async {
      emit(const GetReportsLoadingState());
      final Either<Failure, List<CashierReport>> reportsResponse = await _dashboardRepository.getReportsPerToday();

      reportsResponse.fold((left) {
        cashiers = [];
        emit(GetReportsFailedState(left.errorMessage));
      }, (right) {
        cashiers = right;
        emit(GetReportsSuccessState(right));
      });
    });
    on<GetReportsPerWeek>((event, emit) async {
      emit(const GetReportsLoadingState());
      final Either<Failure, List<CashierReport>> reportsResponse = await _dashboardRepository.getReportsPerWeek();

      reportsResponse.fold((left) {
        cashiers = [];
        emit(GetReportsFailedState(left.errorMessage));
      }, (right) {
        cashiers = right;
        emit(GetReportsSuccessState(right));
      });
    });
    on<GetReportsPerMonth>((event, emit) async {
      emit(const GetReportsLoadingState());
      final Either<Failure, List<CashierReport>> reportsResponse = await _dashboardRepository.getReportsPerMonth();

      reportsResponse.fold((left) {
        cashiers = [];
        emit(GetReportsFailedState(left.errorMessage));
      }, (right) {
        cashiers = right;
        emit(GetReportsSuccessState(right));
      });
    });
    on<GetReportsPerDate>((event, emit) async {
      emit(const GetReportsLoadingState());
      final Either<Failure, List<CashierReport>> reportsResponse =
          await _dashboardRepository.getReportsPerDate(event.startDate, event.endDate);

      reportsResponse.fold((left) {
        cashiers = [];
        emit(GetReportsFailedState(left.errorMessage));
      }, (right) {
        cashiers = right;
        emit(GetReportsSuccessState(right));
      });
    });

    on<GetTopSubCategoriesPerToday>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopSubCategoriesPerToday(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topSalesSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopOrderSubCategoriesPerToday>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopOrderSubCategoriesPerToday(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topOrderSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopSubCategoriesPerWeek>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopSubCategoriesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topSalesSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopOrderSubCategoriesPerWeek>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopOrderSubCategoriesPerWeek(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topOrderSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopSubCategoriesPerMonth>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopSubCategoriesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topSalesSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopOrderSubCategoriesPerMonth>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse =
          await _dashboardRepository.getTopOrderSubCategoriesPerMonth(isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topOrderSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopSubCategoriesPerDate>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse = await _dashboardRepository.getTopSubCategoriesPerDate(
          startDate: event.startDate, endDate: event.endDate, isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topSalesSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topSalesSubCategories = right;

        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTopOrderSubCategoriesPerDate>((event, emit) async {
      emit(const GetTopSubCategoriesLoadingState());
      final Either<Failure, List<TopSaleItem>> topSalesResponse = await _dashboardRepository.getTopOrderSubCategoriesPerDate(
          startDate: event.startDate, endDate: event.endDate, isBasedOnQuantity: event.isBasedOnQuantity);

      topSalesResponse.fold((left) {
        topOrderSubCategories = [];
        emit(GetTopSubCategoriesFailedState(left.errorMessage));
      }, (right) {
        topOrderSubCategories = right;
        emit(GetTopSubCategoriesSuccessState(right));
      });
    });

    on<GetTransactionsPerToday>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, TransactionListInfo> topSalesResponse =
          await _transactionRepository.getAllTransaction(fromDate: todayDate, toDate: todayDate, currentPage: 1, itemCount: 5);

      topSalesResponse.fold((left) {
        transactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        transactions = right.transactions;
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetOrdersPerToday>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, List<TopLastOrdersResponse>> topSalesResponse =
          await _dashboardRepository.getTransactionOrdersPerToday();

      topSalesResponse.fold((left) {
        ordersTransactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        ordersTransactions = right.map((e) => TopLastOrdersModel.fromJson(e.toJson())).toList();
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetTransactionsPerWeek>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, TransactionListInfo> topSalesResponse =
          await _transactionRepository.getAllTransaction(fromDate: weekAgoDate, toDate: todayDate, currentPage: 1, itemCount: 5);

      topSalesResponse.fold((left) {
        transactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        transactions = right.transactions;
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetOrdersPerWeek>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, List<TopLastOrdersResponse>> topSalesResponse =
          await _dashboardRepository.getTransactionOrdersPerWeek();

      topSalesResponse.fold((left) {
        ordersTransactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        ordersTransactions = right.map((e) => TopLastOrdersModel.fromJson(e.toJson())).toList();
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetOrdersPerMonth>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, List<TopLastOrdersResponse>> topSalesResponse =
          await _dashboardRepository.getTransactionOrdersPerMonth();

      topSalesResponse.fold((left) {
        ordersTransactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        ordersTransactions = right.map((e) => TopLastOrdersModel.fromJson(e.toJson())).toList();
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetTransactionsPerMonth>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, TransactionListInfo> topSalesResponse =
          await _transactionRepository.getAllTransaction(fromDate: monthAgoDate, toDate: todayDate, currentPage: 1, itemCount: 5);

      topSalesResponse.fold((left) {
        transactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        transactions = right.transactions;
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetTransactionsPerDate>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, TransactionListInfo> topSalesResponse = await _transactionRepository.getAllTransaction(
          fromDate: event.startDate, toDate: event.endDate, currentPage: 1, itemCount: 5);

      topSalesResponse.fold((left) {
        transactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        transactions = right.transactions;
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetOrdersPerDate>((event, emit) async {
      emit(const GetTransactionsLoadingState());
      final Either<Failure, List<TopLastOrdersResponse>> topSalesResponse =
          await _dashboardRepository.getTransactionOrdersPerDate(event.startDate, event.endDate);

      topSalesResponse.fold((left) {
        ordersTransactions = [];
        emit(GetTransactionsFailedState(left.errorMessage));
      }, (right) {
        ordersTransactions = right.map((e) => TopLastOrdersModel.fromJson(e.toJson())).toList();
        emit(GetTransactionsSuccessState(transactions));
      });
    });

    on<GetOrdersStatisticsPerToday>((event, emit) async {
      emit(const GetOrdersStatisticsLoadingState());
      final Either<Failure, OrdersStatistics> topSalesResponse = await _dashboardRepository.getOrderStatisticsPerToday();

      topSalesResponse.fold((left) {
        ordersStatistics = null;
        emit(GetOrdersStatisticsFailedState(left.errorMessage));
      }, (right) {
        ordersStatistics = right;
        emit(GetOrdersStatisticsSuccessState((ordersStatistics?.sumPrices ?? 0).toString()));
      });
    });
    on<GetOrdersStatisticsPerWeek>((event, emit) async {
      emit(const GetOrdersStatisticsLoadingState());
      final Either<Failure, OrdersStatistics> topSalesResponse = await _dashboardRepository.getOrderStatisticsPerWeek();

      topSalesResponse.fold((left) {
        ordersStatistics = null;
        emit(GetOrdersStatisticsFailedState(left.errorMessage));
      }, (right) {
        ordersStatistics = right;
        emit(GetOrdersStatisticsSuccessState((ordersStatistics?.sumPrices ?? 0).toString()));
      });
    });
    on<GetOrdersStatisticsPerMonth>((event, emit) async {
      emit(const GetOrdersStatisticsLoadingState());
      final Either<Failure, OrdersStatistics> topSalesResponse = await _dashboardRepository.getOrderStatisticsPerMonth();

      topSalesResponse.fold((left) {
        ordersStatistics = null;
        emit(GetOrdersStatisticsFailedState(left.errorMessage));
      }, (right) {
        ordersStatistics = right;
        emit(GetOrdersStatisticsSuccessState((ordersStatistics?.sumPrices ?? 0).toString()));
      });
    });
    on<GetOrdersStatisticsPerDate>((event, emit) async {
      emit(const GetOrdersStatisticsLoadingState());
      final Either<Failure, OrdersStatistics> topSalesResponse =
          await _dashboardRepository.getOrderStatisticsPerDate(event.startDate, event.endDate);

      topSalesResponse.fold((left) {
        ordersStatistics = null;
        emit(GetOrdersStatisticsFailedState(left.errorMessage));
      }, (right) {
        ordersStatistics = right;
        emit(GetOrdersStatisticsSuccessState((ordersStatistics?.sumPrices ?? 0).toString()));
      });
    });
  }
}
