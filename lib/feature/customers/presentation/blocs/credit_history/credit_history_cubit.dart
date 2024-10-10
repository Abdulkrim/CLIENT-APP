import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/customers/data/repository/customer_repository.dart';

import '../../../../../core/constants/defaults.dart';
import '../../../data/models/entity/customer_credit_history.dart';

part 'credit_history_state.dart';

@injectable
class CreditHistoryCubit extends Cubit<CreditHistoryState> {
  final ICustomerRepository _customerRepository;

  CreditHistoryCubit(this._customerRepository) : super(CreditHistoryInitial());

  String fromDate = Defaults.startDateRange;

  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;

  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  List<CustomerCreditHistory> customerCreditHistories = [];

  void getCreditHistoriesOfCustomer({required String customerId, String? rFromDate, String? rToDate}) async {
    _fromDate = rFromDate;
    _toDate = rToDate;

    emit(const GetCustomerCreditHistories(isLoading: true));

    final result =
        await _customerRepository.getCustomerCreditHistories(customerId: customerId, fromDate: fromDate, toDate: toDate);

    result.fold((left) => emit(GetCustomerCreditHistories(errorMessage: left.errorMessage)), (right) {
      customerCreditHistories = right;
      emit(const GetCustomerCreditHistories(isSuccess: true));
    });
  }
}
