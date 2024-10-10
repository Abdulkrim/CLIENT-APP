import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/pagination_state.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/cashiers/data/repository/cashier_repository.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/order_status.dart';
import 'package:merchant_dashboard/feature/orders/data/models/entity/orders.dart';
import 'package:merchant_dashboard/feature/orders/data/repository/orders_repository.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../../cashiers/data/models/entity/cashier.dart';
import '../../../settings/data/repository/settings_repository.dart';
import '../../data/models/entity/order_statistics.dart';
import '../../data/models/entity/order_status_filter.dart';

part 'order_management_event.dart';

part 'order_management_state.dart';

@injectable
class OrderManagementBloc extends Bloc<OrderManagementEvent, OrderManagementState> {
  final IOrdersRepository _orderRepository;
  final ISettingsRepository _settingsRepository;
  final ICashierRepository _cashierRepository;

  List<OrderStatusFilter> orderStatusesFilter = [];
  // OrderStatus? selectedOrderStatusIdFilter;

  List<Cashier> cashiers = [];

  String ordersCount = '-';
  String salesCount = '-';
  String productsCount = '-';
  String customersCount = '-';

  bool isCancelledFilterSelected = false;
  bool isCompletedFilterSelected = false;

  List<PaymentType> paymentTypes = [];

  final PaginationState<OrderItem> ordersPagination = PaginationState<OrderItem>();

  OrderManagementBloc(this._orderRepository, this._settingsRepository, this._cashierRepository)
      : super(OrderManagementInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        add(const GetAllOrdersData());
      }
    });

    on<GetAllOrdersData>((event, emit) {
      add(const GetBranchParametersEvent());
      add(const GetOrderStatusesEvent());
      add(const GetCashiersEvent());
      add(const GetAllOrderRequestEvent());
      add(const Get30OrderInfoRequestEvent());
    });

    on<GetBranchParametersEvent>((event, emit) async {
      _settingsRepository.getBranchSupportedPaymentTypes().then((value) => paymentTypes = value.right);
    });

    on<GetCashiersEvent>((event, emit) async {
      Either<Failure, CashierListInfo> result =
          await _cashierRepository.getAllCashiersOnce(onlyActiveItems: true);
      result.fold((left) => debugPrint(" $left"), (right) {
        cashiers = right.cashiers;
      });
    });
    on<GetOrderStatusesEvent>((event, emit) async {
      Either<Failure, List<OrderStatus>> result = await _orderRepository.getAllOrderStatuses();
      result.fold((left) => debugPrint(" $left"), (right) {
        orderStatusesFilter = right.toFilterMode();
      });
    });

    on<Get30OrderInfoRequestEvent>((event, emit) async {
      Either<Failure, OrderStatistics> result = await _orderRepository.getLast30OrderData();
      result.fold((left) {
        debugPrint("CustomersCount error $left");
        customersCount = '-';
        ordersCount = '-';
        salesCount = '-';
        productsCount = '-';
        emit(const Last30DaysInfoDataFailedState());
      }, (right) {
        customersCount = right.customerCount.toString();
        ordersCount = right.ordersCount.toString();
        salesCount = right.customerSumPrices.toString();
        productsCount = right.productsCount.toString();

        emit(const Last30DaysInfoDataSuccessState());
      });
    });

    on<GetAllOrderRequestEvent>((event, emit) async {
      if (!event.getMore) {
        ordersPagination.dispose();
      } else if (ordersPagination.onFetching) {
        return;
      }

      if (ordersPagination.hasMore) {
        if (ordersPagination.currentPage == 1) emit(const AllOrdersDataLoadingState());

        ordersPagination.sendRequestForNextPage();

        Either<Failure, OrderListInfo> result = await _orderRepository.getAllOrders(
            currentPage: ordersPagination.currentPage, orderStatusIdRequest: event.selectedStatusIdFilter);

        result.fold((left) {
          emit(GetOrdersFailedState(left.errorMessage));
          debugPrint(left.errorMessage);
        }, (right) {
          ordersPagination.gotNextPageData(right.orderItem, right.totalPageCount);

          emit(AllOrdersDataSuccessState(right.currentPageNumber, ordersPagination.hasMore));
        });
      }
    });

    on<GetOrderDetailsEvent>((event, emit) async {
      emit(const GetOrderDetailsLoadingState());
      Either<Failure, OrderItem> result = await _orderRepository.getOrderDetails(event.orderId);
      result.fold((left) {
        emit(GetOrderDetailsFailedState(left.errorMessage));
        debugPrint(left.errorMessage);
      }, (right) {
        emit(GetOrderDetailsSuccessState(right));
      });
    });

    on<ChangeOrderStatusEvent>((event, emit) async {
      emit(const ChangeOrderStatusLoadingState());

      int? selectedPaymentType = event.selectedPaymentType;
      String? selectedCashierId = event.selectedCashierId;

      if ((event.selectedPaymentType == null || event.selectedCashierId == null) &&
          event.requestedStatusIsCompleted) {
        emit(ShowPaymentTypeDialog(
            paymentModes: paymentTypes,
            orderItem: event.orderItem,
            requestedStatusId: event.requestedStatusId,
            requestedStatusIsCompleted: event.requestedStatusIsCompleted));
        return;
      }

      Either<Failure, bool> result = await _orderRepository.changeOrderStatus(
          orderId: event.orderItem.originalId,
          statusCode: event.requestedStatusId,
          totalAmount: event.orderItem.totalFinalPrice - (event.deliveryDiscount ?? 0 ),
          deliveryDiscount: event.deliveryDiscount,
          paymentType: selectedPaymentType,
          cashierId: selectedCashierId,
          referenceId: event.referenceID);
      result.fold((left) {
        emit(ChangeOrderStatusFailedState(left.errorMessage));
        debugPrint(left.errorMessage);
      }, (right) {
        add(const GetAllOrderRequestEvent());
      });
    });
  }
}
