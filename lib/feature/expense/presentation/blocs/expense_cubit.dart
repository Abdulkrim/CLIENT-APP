import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_amount.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expense_type.dart';
import 'package:merchant_dashboard/feature/expense/data/models/entity/expenses_info.dart';
import 'package:merchant_dashboard/feature/expense/data/repository/expense_repository.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/settings/data/repository/settings_repository.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../../../core/bloc_base_state/pagination_state.dart';
import '../../../../core/constants/defaults.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../../../settings/data/models/entity/payment_type.dart';

part 'expense_state.dart';

@singleton
class ExpenseCubit extends Cubit<ExpenseState> with DateTimeUtilities {
  final IExpenseRepository _expenseRepository;
  final ISettingsRepository _settingsRepository;

  ExpenseCubit(this._expenseRepository, this._settingsRepository) : super(ExpenseInitial()) {
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        getPaymentTypes();
        getExpenseAmount();
        getExpenses();
      }
    });
  }

  ExpenseType selectedExpenseTypeFilter = const ExpenseType(0, 'Select Expense Type');
  late List<ExpenseType> expenseTypes = [selectedExpenseTypeFilter];
  PaymentType selectedPaymentTypeFilter = PaymentType(id: 0, name: 'Select Payment Type', isDefault: false);
  late List<PaymentType> paymentModes = [selectedPaymentTypeFilter];

  final PaginationState<ExpenseItem> expensesPagination = PaginationState<ExpenseItem>();
  num expenseTotalAmount = 0;

  String fromDate = Defaults.startDateRange;

  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;

  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  String? searchText;

  List<ExpenseAmount> expensesAmount = [];

  void getExpenseAmount() async {
    final result = await _expenseRepository.getExpenseAmounts();

    result.fold((left) {}, (right) => expensesAmount = right);
  }

  void getExpenses(
      {bool getMore = false, String? requestedFromDate, String? requestedToDate, String? requestedSearchText}) async {
    if (!getMore) {
      await expensesPagination.dispose();
    } else if (expensesPagination.onFetching) {
      return;
    }

    if (requestedSearchText != null) searchText = requestedSearchText;

    if (expensesPagination.hasMore) {
      _fromDate = requestedFromDate;
      _toDate = requestedToDate;

      // if (isSecondDateBigger(fromDate, toDate)) {
      if (expensesPagination.currentPage == 1) emit(const GetExpensesState(isLoading: true));

      expensesPagination.sendRequestForNextPage();

      final expensesResult = await _expenseRepository.getExpenses(
          fromDate: fromDate,
          toDate: toDate,
          currentPage: expensesPagination.currentPage,
          paymentModeId: selectedPaymentTypeFilter.id,
          expenseTypeId: selectedExpenseTypeFilter.id,
          searchText: searchText);

      expensesResult.fold((left) {
        emit(GetExpensesState(errorMessage: left.errorMessage));
      }, (right) {
        expenseTotalAmount = right.totalAmount;
        expensesPagination.gotNextPageData(right.items, right.totalPageCount);
        emit(GetExpensesState(hasMore: expensesPagination.hasMore));
      });
      /*     } else {
        emit(GetExpensesState(
            errorMessage: 'Your selected first date $fromDate is bigger than selected second date $toDate'));
      } */
    }
  }

  void deleteExpense(int expenseId) async {
    emit(const AddExpenseState(isLoading: true));
    final result = await _expenseRepository.deleteExpense(expenseId);

    result.fold((left) => emit(AddExpenseState(errorMessage: left.errorMessage)), (right) {
      emit(const AddExpenseState(successMessage: 'Expense Deleted Successfully!'));
      getExpenses();
    });
  }

  void resetFilter() {
    searchText = '';
    selectedExpenseTypeFilter = const ExpenseType(0, 'Select Expense Type');
    selectedPaymentTypeFilter = PaymentType(id: 0, name: 'Select Payment Type', isDefault: false);
    fromDate = Defaults.startDateRange;
    toDate = Defaults.endDateRange;
    getExpenses();
  }

  void changeExpenseType(ExpenseType selectedExpenseType) {
    selectedExpenseTypeFilter = selectedExpenseType;

    getExpenses();
  }

  void changePaymentType(PaymentType selectedPaymentType) {
    selectedPaymentTypeFilter = selectedPaymentType;

    getExpenses();
  }

  void addExpenseType(String name) async {
    emit(const AddExpenseTypesState(isLoading: true));
    final result = await _expenseRepository.addExpenseType(name);

    result.fold((left) => emit(AddExpenseTypesState(errorMessage: left.errorMessage)), (right) {
      expenseTypes.add(ExpenseType(right, name));
      emit(const AddExpenseTypesState(successMessage: 'Expense Added Successfully!'));
    });
  }

  void getExpenseTypes() async {
    emit(const GetExpenseTypesState(isLoading: true));
    final result = await _expenseRepository.getExpenseTypes();

    result.fold((left) => emit(GetExpenseTypesState(errorMessage: left.errorMessage)), (right) {
      // selectedExpenseTypeFilter =  const ExpenseType(0, 'Select Expense Type');
      expenseTypes = [...expenseTypes, ...right].toSet().toList();

      emit(const GetExpenseTypesState(successMessage: 'Get Expense Type'));
    });
  }

  void getPaymentTypes() async {
    emit(const GetPaymentTypesState(isLoading: true));
    final result = await _settingsRepository.getBranchSupportedPaymentTypes();

    result.fold((left) => emit(GetPaymentTypesState(errorMessage: left.errorMessage)), (right) {
      paymentModes = [selectedPaymentTypeFilter, ...right];

      emit(const GetPaymentTypesState(successMessage: 'Get Payments Type Success'));
    });
  }

  void addExpense(
      {required int expenseTypeId,
      required int paymentModeId,
      required String amount,
      required String note,
      required String date,
      required XFile? file}) async {
    emit(const AddExpenseState(isLoading: true));

    final result = await _expenseRepository.addExpense(
        date: date, expenseTypeId: expenseTypeId, paymentModeId: paymentModeId, amount: amount, note: note, file: file);

    result.fold((left) => emit(AddExpenseState(errorMessage: left.errorMessage)), (right) {
      emit(const AddExpenseState(successMessage: 'Expense Added Successfully!'));
      getExpenses();
    });
  }

  void editExpense(
      {required int expenseId,
      required int expenseTypeId,
      required int paymentModeId,
      required String amount,
      required String note,
      required String date,
      required XFile? file}) async {
    emit(const AddExpenseState(isLoading: true));

    final result = await _expenseRepository.editExpense(
        expenseId: expenseId,
        date: date,
        expenseTypeId: expenseTypeId,
        paymentModeId: paymentModeId,
        amount: amount,
        note: note,
        file: file);

    result.fold((left) => emit(AddExpenseState(errorMessage: left.errorMessage)), (right) {
      emit(const AddExpenseState(successMessage: 'Expense Edited Successfully!'));
      getExpenses();
    });
  }
}
