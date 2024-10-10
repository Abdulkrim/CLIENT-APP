part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState {}

class UpdateContainerState extends TransactionState {}

class CategoriesFilterDataSuccessState extends TransactionState {
  const CategoriesFilterDataSuccessState();
}

class CashierFiltersDataSuccessState extends TransactionState {
  const CashierFiltersDataSuccessState();
}

class GetAllTransactionsLoadingState extends TransactionState {
  const GetAllTransactionsLoadingState();
}

class ClaimTransactionStates extends TransactionState {
  final String? error;
  final bool isSuccess;
  const ClaimTransactionStates({this.error, this.isSuccess = false});

  @override
  List<Object?> get props => [error, isSuccess];
}

class GetAllTransactionsSuccessState extends TransactionState {
  final int currentPage;
  final bool hasMore;

  const GetAllTransactionsSuccessState(this.currentPage, this.hasMore);

  @override
  List<Object> get props => [currentPage, hasMore];
}

class WrongDateFilterRangeEnteredState extends TransactionState {
  final String fromDate;
  final String toDate;
  const WrongDateFilterRangeEnteredState(this.fromDate, this.toDate);

  @override
  List<Object> get props => [fromDate, toDate];
}

class GetTransactionDetailSuccessState extends TransactionState {
  final int selectedTransactionNo;
  final List<TransactionDetails> transactionDetails;
  const GetTransactionDetailSuccessState(this.transactionDetails, this.selectedTransactionNo);

  @override
  List<Object> get props => [transactionDetails];
}

class GetTransactionDetailsLoadingState extends TransactionState {
  const GetTransactionDetailsLoadingState();
}

class GetTransactionFailedState extends TransactionState {
  const GetTransactionFailedState();
}

class GetDownloadLinkLoadingState extends TransactionState {
  const GetDownloadLinkLoadingState();
}

class GetDownloadLinkStates extends TransactionState {
  final String link;
  final String errorMsg;
  const GetDownloadLinkStates({this.link = '', this.errorMsg = ''});

  @override
  List<Object> get props => [link, errorMsg];
}
