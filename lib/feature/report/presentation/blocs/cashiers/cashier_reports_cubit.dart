import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/report/data/repository/reports_repository.dart';

import '../../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../../core/constants/defaults.dart';
import '../../../../../core/utils/failure.dart';
import '../../../data/models/entity/cashiers_reports.dart';

part 'cashier_reports_state.dart';

@injectable
class CashierReportsCubit extends Cubit<CashierReportsState> {
  final IReportsRepository _reportsRepository;

  CashierReportsCubit(this._reportsRepository) : super(CashierReportsInitial());

  final PaginationState<CashierItemReport> cashiersPagination = PaginationState<CashierItemReport>();

  String fromDate = Defaults.startDateRange;
  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;
  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  void getCashiers({String? rFromDate, String? rToDate, bool getMore = false}) async {
    if (!getMore) {
      await cashiersPagination.dispose();
    } else if (cashiersPagination.onFetching) {
      return;
    }

    if (cashiersPagination.hasMore) {
      _fromDate = rFromDate;
      _toDate = rToDate;

      if (cashiersPagination.currentPage == 1) emit(const GetCashiersLoadingState());

      cashiersPagination.sendRequestForNextPage();

      final transResult = await _reportsRepository.getCashierReport(
        fromDate: fromDate,
        toDate: toDate,
        currentPage: cashiersPagination.currentPage,
      );

      transResult.fold((left) {
        if (left is ServerError && left.code == '0') return;
        emit(const GetCashiersFailedState());
      }, (right) {
        cashiersPagination.gotNextPageData(right.items, right.totalPageCount);

        emit(GetCashiersSuccessState(right.currentPageNumber, cashiersPagination.hasMore));
      });
    }
  }

  void getCashiersReportsDownloadLink() async {
    emit(const GetDownloadLinkLoadingState());

    final result = await _reportsRepository.getCashiersDownloadReport(
      fromDate: fromDate,
      toDate: toDate,
      currentPage: cashiersPagination.currentPage,
    );

    result.fold((left) => emit(GetDownloadLinkState(errorMsg: left.errorMessage)), (right) {
      emit(GetDownloadLinkState(link: right));
    });
  }
}
