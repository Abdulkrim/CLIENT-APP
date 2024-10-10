part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  const StockState({this.isLoading = false, this.isSuccess = false, this.error});

  @override
  List<Object?> get props => [];
}

class StockInitial extends StockState {}

class AllStocksLoadingState extends StockState {
  const AllStocksLoadingState();
}

class GetAllProductsState extends StockState {
  const GetAllProductsState({super.isLoading, super.error, super.isSuccess});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class GetStockStatisticsState extends StockState {
  const GetStockStatisticsState({super.isLoading, super.error, super.isSuccess});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class DecreaseStockState extends StockState {
  const DecreaseStockState({super.isLoading, super.error, super.isSuccess});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class IncreaseStockState extends StockState {
  const IncreaseStockState({super.isLoading, super.error, super.isSuccess});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class GetAllStocksSuccess extends StockState {
  final int currentPageNumber;
  final bool hasMore;
  const GetAllStocksSuccess(this.currentPageNumber, this.hasMore);

  @override
  List<Object> get props => [currentPageNumber, hasMore];
}

class GetSpecificProductStates extends StockState {
  final Product? product;
  const GetSpecificProductStates({super.isLoading = false, super.error, this.product});

  @override
  List<Object?> get props => [isLoading, error, product];
}

class GetStockExcelReportLink extends StockState {
  const GetStockExcelReportLink({super.isLoading, super.error, super.isSuccess});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}

class GetStockItemExcelReportLink extends StockState {
  const GetStockItemExcelReportLink({super.isLoading, super.error, super.isSuccess});

  @override
  List<Object?> get props => [isLoading, isSuccess, error];
}
