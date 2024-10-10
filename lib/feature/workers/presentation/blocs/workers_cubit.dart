import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../core/constants/defaults.dart';
import '../../../cashiers/data/models/entity/cashier_sort_type.dart';
import '../../data/models/entity/worker_list_info.dart';
import '../../data/repository/worker_repository.dart';

part 'workers_state.dart';

@injectable
class WorkersCubit extends Cubit<WorkersState> with DateTimeUtilities {
  final IWorkerRepository _workerRepository;

  WorkersCubit(this._workerRepository) : super(WorkersInitial());

  List<CashierSortTypes> sortType = [
    CashierSortTypes('Sales : High to Low', Defaults.sortFiledSales, Defaults.sortTypeDESC),
    CashierSortTypes('Sales : Low to High', Defaults.sortFiledSales, Defaults.sortTypeASC),
  ];

  late CashierSortTypes _selectedSortType = sortType.first;

  CashierSortTypes get selectedSortType => _selectedSortType;

  set selectedSortType(CashierSortTypes? value) {
    if (value != null) _selectedSortType = value;
  }

  String fromDate = Defaults.startDateRange;

  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;

  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  final PaginationState<WorkerItem> workerPagination = PaginationState<WorkerItem>();
  final PaginationState<WorkerItem> workerSalesPagination = PaginationState<WorkerItem>();

  void getAllWorkerSales({bool getMore = false, String? requestedFromDate, String? requestedtoDate}) async {
    if (!getMore) {
      workerSalesPagination.dispose();
    } else if (workerSalesPagination.onFetching) {
      return;
    }

    if (workerSalesPagination.hasMore) {
      _fromDate = requestedFromDate;
      _toDate = requestedtoDate;

      // if (isSecondDateBigger(fromDate, toDate)) {
        if (workerSalesPagination.currentPage == 1) emit(GetSalesWorkerLoadingState());

        workerSalesPagination.sendRequestForNextPage();

        final result = await _workerRepository.getAllWorkerSales(
          currentPage: workerSalesPagination.currentPage,
          orderType: selectedSortType.sortType,
          orderField: selectedSortType.sortField,
          fromDate: fromDate,
          toDate: toDate,
        );

        result.fold((left) => debugPrint("sales error ${left.errorMessage}"), (right) {
          workerSalesPagination.gotNextPageData(right.workers, right.totalPage);
          emit(SalesWorkersListState(hasMore: workerSalesPagination.hasMore));
        });
      // } else {
      //   emit(WorkerUpdateStates(errorMessage: 'fromDate, toDate'));
      // }
    }
  }

  void getAllWorkers({bool getMore = false}) async {
    if (!getMore) {
      workerPagination.dispose();
    } else if (workerPagination.onFetching) {
      return;
    }

    if (workerPagination.hasMore) {
      if (workerPagination.currentPage == 1) emit(WorkersListLoading());

      workerPagination.sendRequestForNextPage();

      final result = await _workerRepository.getAllWorkers(workerPagination.currentPage);

      result.fold((left) => debugPrint("cashiers error ${left.errorMessage}"), (right) {
        workerPagination.gotNextPageData(right.workers, right.totalPage);

        emit(WorkerListStates(hasMore: workerPagination.hasMore));
      });
    }
  }

  void changeSortType(CashierSortTypes sort) {
    _selectedSortType = sort;

    getAllWorkerSales();
  }

  void updateWorkerInfo({required bool isActive, required String workerId, required String workerName}) async {
    emit(const WorkerUpdateStates(isLoading: true));
    final result = await _workerRepository.editWorker(workerId: workerId, fullName: workerName, isActive: isActive);

    result.fold((left) => emit(WorkerUpdateStates(errorMessage: left.errorMessage)), (right) {
      workerPagination.listItems.firstWhere((element) => element.id == workerId).isActive = isActive;

      emit(const WorkerUpdateStates(successMessage: 'Worker Updated Successfully!'));
    });
  }

  void addWorker({required String workerName}) async {
    emit(const WorkerUpdateStates(isLoading: true));
    final result = await _workerRepository.addWorker(fullName: workerName);

    result.fold((left) => emit(WorkerUpdateStates(errorMessage: left.errorMessage)), (right) {
      emit(const WorkerUpdateStates(successMessage: 'Worker Added Successfully!'));
      getAllWorkers();
    });
  }
}
