import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/pagination_state.dart';

import '../../../../../core/constants/defaults.dart';
import '../../../../../core/utils/failure.dart';
import '../../../data/models/entity/sub_categories_reports.dart';
import '../../../data/repository/reports_repository.dart';

part 'sub_category_reports_state.dart';

@injectable
class SubCategoryReportsCubit extends Cubit<SubCategoryReportsState> {
  final IReportsRepository _reportsRepository;

  SubCategoryReportsCubit(this._reportsRepository) : super(SubCategoryReportsInitial());

  final PaginationState<SubCategoryItemReport> subCategoriesPagination =
      PaginationState<SubCategoryItemReport>();

  String fromDate = Defaults.startDateRange;
  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;
  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  void getSubCategories({String? rFromDate, String? rToDate, bool getMore = false}) async {
    if (!getMore) {
      await subCategoriesPagination.dispose();
    } else if (subCategoriesPagination.onFetching) {
      return;
    }

    if (subCategoriesPagination.hasMore) {
      _fromDate = rFromDate;
      _toDate = rToDate;

      if (subCategoriesPagination.currentPage == 1) emit(const GetSubCategoriesLoadingState());

      subCategoriesPagination.sendRequestForNextPage();

      final transResult = await _reportsRepository.getSubCategoriesReport(
        fromDate: fromDate,
        toDate: toDate,
        currentPage: subCategoriesPagination.currentPage,
      );

      transResult.fold((left) {
        if (left is ServerError && left.code == '0') return;
        emit(const GetSubCategoriesFailedState());
      }, (right) {
        subCategoriesPagination.gotNextPageData(right.items, right.totalPageCount);

        emit(GetSubCategoriesSuccessState(right.currentPageNumber, subCategoriesPagination.hasMore));
      });
    }
  }

  void getSubCategoriesReportsDownloadLink() async {
    emit(const GetDownloadLinkLoadingState());

    final result = await _reportsRepository.getSubCategoriesDownloadReport(
      fromDate: fromDate,
      toDate: toDate,
      currentPage: subCategoriesPagination.currentPage,
    );

    result.fold((left) => emit(GetDownloadLinkState(errorMsg: left.errorMessage)), (right) {
      emit(GetDownloadLinkState(link: right));
    });
  }
}
