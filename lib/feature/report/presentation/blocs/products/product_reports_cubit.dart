import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../../core/constants/defaults.dart';
import '../../../../../core/utils/failure.dart';
import '../../../data/models/entity/products_reports.dart';
import '../../../data/repository/reports_repository.dart';

part 'product_reports_state.dart';

@injectable
class ProductReportsCubit extends Cubit<ProductReportsState> {
  final IReportsRepository _reportsRepository;

  ProductReportsCubit(this._reportsRepository) : super(ProductReportsInitial());

  final PaginationState<ProductItemReport> productsPagination = PaginationState<ProductItemReport>();

  String fromDate = Defaults.startDateRange;
  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;
  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  void getProducts({String? rFromDate, String? rToDate, bool getMore = false}) async {
    if (!getMore) {
      await productsPagination.dispose();
    } else if (productsPagination.onFetching) {
      return;
    }

    if (productsPagination.hasMore) {
      _fromDate = rFromDate;
      _toDate = rToDate;

      if (productsPagination.currentPage == 1) emit(const GetProductsLoadingState());

      productsPagination.sendRequestForNextPage();

      final prodsResult = await _reportsRepository.getProductsReport(
        fromDate: fromDate,
        toDate: toDate,
        currentPage: productsPagination.currentPage,
      );

      prodsResult.fold((left) {
        if (left is ServerError && left.code == '0') return;
        emit(const GetProductsFailedState());
      }, (right) {
        productsPagination.gotNextPageData(right.items, right.totalPageCount);

        emit(GetProductsSuccessState(right.currentPageNumber, productsPagination.hasMore));
      });
    }
  }

  void getProductsReportsDownloadLink() async {
    emit(const GetDownloadLinkLoadingState());

    final result = await _reportsRepository.getProductsDownloadReport(
      fromDate: fromDate,
      toDate: toDate,
      currentPage: productsPagination.currentPage,
    );

    result.fold((left) => emit(GetDownloadLinkState(errorMsg: left.errorMessage)), (right) {
      emit(GetDownloadLinkState(link: right));
    });
  }
}
