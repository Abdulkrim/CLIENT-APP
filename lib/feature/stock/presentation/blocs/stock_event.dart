part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

class GetAllStockRequestEvent extends StockEvent {
  final bool getMore;
  final StockSortTypes? selectedStockSortType;
  final String searchText;
  final bool isRefreshing;

  const GetAllStockRequestEvent(
      {this.selectedStockSortType,
      this.getMore = false,
      this.searchText = '',
      this.isRefreshing = false});

  @override
  List<Object?> get props => [selectedStockSortType];
}

class GetSpecificProduct extends StockEvent {
  final String searchText;

  const GetSpecificProduct(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

class GetMeasureUnits extends StockEvent {
  const GetMeasureUnits();
}

class GetStockStatistics extends StockEvent {
  const GetStockStatistics();
}

class GetExportExcelLink extends StockEvent {
  const GetExportExcelLink();
}

class GetExportExcelLinkItem extends StockEvent {
  final int itemStockId;
  final List<dynamic>? filterInfos;
  final List<dynamic>? orderInfos;
  final List<dynamic>? columns;
  final int count;
  final int page;
  const GetExportExcelLinkItem({
    required this.itemStockId,
    this.filterInfos,
    this.orderInfos,
    this.columns,
    this.count = 0,
    this.page = 0,
  });
}

class GetAllProducts extends StockEvent {
  const GetAllProducts();
}

class GetDecreaseReasons extends StockEvent {
  const GetDecreaseReasons();
}

class IncreaseStockEvent extends StockEvent {
  final int itemId;
  final num amount;
  final num pricePerUnit;
  final int unitMeasureId;

  const IncreaseStockEvent({
    required this.itemId,
    required this.amount,
    required this.pricePerUnit,
    required this.unitMeasureId,
  });

  @override
  List<Object?> get props => [itemId, amount, pricePerUnit, unitMeasureId];
}

class DecreaseStockEvent extends StockEvent {
  final int itemId;
  final num amount;
  final int reasonId;

  const DecreaseStockEvent({
    required this.itemId,
    required this.amount,
    required this.reasonId,
  });

  @override
  List<Object?> get props => [itemId, amount, reasonId];
}
