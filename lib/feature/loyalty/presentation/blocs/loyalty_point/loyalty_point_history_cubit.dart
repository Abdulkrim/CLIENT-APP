import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../../core/constants/defaults.dart';
import '../../../data/models/entity/loyalty_point.dart';
import '../../../data/repository/loyalty_point_repository.dart';

part 'loyalty_point_history_state.dart';

@injectable
class LoyaltyPointHistoryCubit extends Cubit<LoyaltyPointHistoryState> {
  final ILoyaltyPointRepository _loyaltyPointRepository;

  LoyaltyPointHistoryCubit(this._loyaltyPointRepository) : super(LoyaltyPointHistoryInitial());

  String fromDate = Defaults.startDateRange;
  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;
  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  final PaginationState<LoyaltyPointItem> pointsPagination = PaginationState<LoyaltyPointItem>();

  void getLoyaltyPointHistory({
    required String customerId,
    bool getMore = false,
    String? rFromDate,
    String? rToDate,
  }) async {
    if (!getMore) {
      await pointsPagination.dispose();
    } else if (pointsPagination.onFetching) {
      return;
    }
    if (pointsPagination.hasMore) {
      _fromDate = rFromDate;
      _toDate = rToDate;
    }

    if (pointsPagination.currentPage == 1) emit(const GetLoyaltyPointHistoryState(isLoading: true));
    pointsPagination.sendRequestForNextPage();

    final result = await _loyaltyPointRepository.getLoyaltyPointHistory(
        customerId: customerId, //'F43EB4AC-4D28-4BA3-B863-4E9721D05793',
        fromDate: fromDate,
        toDate: toDate,
        page: pointsPagination.currentPage);

    result.fold((left) => emit(GetLoyaltyPointHistoryState(errorMessage: left.errorMessage)), (right) {
      pointsPagination.gotNextPageData(right.points, right.totalPage);

      emit(const GetLoyaltyPointHistoryState(isSuccess: true));
    });
  }
}
