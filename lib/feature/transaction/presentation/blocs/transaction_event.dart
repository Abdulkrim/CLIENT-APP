part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class GetFiltersDataEvent extends TransactionEvent {
  const GetFiltersDataEvent();
}

class GetAllTransactionsEvent extends TransactionEvent {
  final String? fromDate;
  final String? toDate;
  final String? startTime;
  final String? endTime;
  final String? cashierId;
  final int? categoryId;
  final int? subCategoryId;
  final int? productId;

  final bool getMore;

  const GetAllTransactionsEvent(
      {this.fromDate,
      this.toDate,
      this.startTime,
      this.endTime,
      this.categoryId,
      this.cashierId,
      this.subCategoryId,
      this.productId,
      this.getMore = false});

  @override
  List<Object?> get props => [fromDate, toDate, cashierId, categoryId, productId, subCategoryId];
}

class ChangeCategoryFilterItemEvent extends TransactionEvent {
  final CategoryFilter categoryFilter;

  const ChangeCategoryFilterItemEvent(this.categoryFilter);

  @override
  List<Object> get props => [categoryFilter];
}

class ChangeSubCategoryFilterItemEvent extends TransactionEvent {
  final SubCategoryFilter subCategoryFilter;

  const ChangeSubCategoryFilterItemEvent(this.subCategoryFilter);

  @override
  List<Object> get props => [subCategoryFilter];
}

class ChangeCashierFilterItemEvent extends TransactionEvent {
  final CashierFilter cashierFilter;

  const ChangeCashierFilterItemEvent(this.cashierFilter);

  @override
  List<Object> get props => [cashierFilter];
}

class ChangeProductFilterItemEvent extends TransactionEvent {
  final ProductFilter productFilter;

  const ChangeProductFilterItemEvent(this.productFilter);

  @override
  List<Object> get props => [productFilter];
}

class ClaimTransactionRequestEvent extends TransactionEvent {
  final int transactionId;
  final List<int>? selectedDetailIds;

  const ClaimTransactionRequestEvent(this.transactionId, [this.selectedDetailIds]);

  @override
  List<Object?> get props => [transactionId, selectedDetailIds];
}

class ResetAllFiltersEvent extends TransactionEvent {
  const ResetAllFiltersEvent();
}

class GetDownloadLink extends TransactionEvent {
  const GetDownloadLink();
}

class GetTransactionDetailsEvent extends TransactionEvent {
  final int transactionId;

  const GetTransactionDetailsEvent(
    this.transactionId,
  );

  @override
  List<Object?> get props => [transactionId];
}
