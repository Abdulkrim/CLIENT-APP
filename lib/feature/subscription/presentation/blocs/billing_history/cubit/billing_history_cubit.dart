import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/billing_history.dart';
import 'package:merchant_dashboard/feature/subscription/data/repository/subscription_repository.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../../../core/constants/defaults.dart';
import '../../../../../../injection.dart';
import '../../../../../main_screen/presentation/blocs/main_screen_bloc.dart';

part 'billing_history_state.dart';

@injectable
class BillingHistoryCubit extends Cubit<BillingHistoryState> with DownloadUtils {
  final ISubscriptionRepository _subscriptionRepository;

  String fromDate = Defaults.startDateRange;

  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;

  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  BillingHistoryCubit(this._subscriptionRepository) : super(BillingHistoryInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        getBillingHistories();
      }
    });
  }

  final PaginationState<BillingHistoryItem> billingPagination = PaginationState<BillingHistoryItem>();

  void getBillingHistories({
    bool getMore = false,
    String? sFromDate,
    String? sToDate,
  }) async {
    if (!getMore) {
      await billingPagination.dispose();
    } else if (billingPagination.onFetching) {
      return;
    }

    if (billingPagination.hasMore) {
      _fromDate = sFromDate;
      _toDate = sToDate;

      // if (isSecondDateBigger(fromDate, toDate)) {}

      // if (billingPagination.currentPage == 1) emit(const GetBillingHistoryState(isLoading: true));

      billingPagination.sendRequestForNextPage();

      final result = _subscriptionRepository.getBranchBillingHistory(
        currentPage: billingPagination.currentPage,
        /*     fromDate: fromDate,
        toDate: toDate, */
      );

      result.fold((left) => emit(GetBillingHistoryState(errorMessage: left.errorMessage)), (right) {
        billingPagination.gotNextPageData(right.billings, right.totalPageCount);

        emit(GetBillingHistoryState(currentPage: right.currentPageNumber));
      });
    }
  }

  void rePaymentRequest(String paymentId) async {
    emit(const RePaymentRequestState(isLoading: true));
    final result = await _subscriptionRepository.rePaymentRequest(paymentId: paymentId);

    result.fold((left) => emit(RePaymentRequestState(errorMessage: left.errorMessage)), (right) {
      openLink(url: right.payLink, openInNewTab: false);
    });
  }
}
