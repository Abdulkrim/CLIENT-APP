import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/pagination_state.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/repository/product_repository.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/decrease_reason.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stock_sort_type.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stock_statistics.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/feature/stock/data/repository/stock_repository.dart';

import '../../../../injection.dart';
import '../../../products/data/models/entity/measure_unit.dart';

part 'stock_event.dart';

part 'stock_state.dart';

@injectable
class StockBloc extends Bloc<StockEvent, StockState> {
  final IStockRepository _stockRepository;
  final IProductRepository _productRepository;

  List<StockSortTypes> sortType = [
    StockSortTypes(
        'Quantity : High to Low', Defaults.sortFiledQuantity.toLowerCase(), OrderOperator.desc.value),
    StockSortTypes(
        'Quantity : Low to High', Defaults.sortFiledQuantity.toLowerCase(), OrderOperator.asc.value),
  ];
  String searchText = '';

  late StockSortTypes _selectedSortType = sortType.first;
  StockSortTypes get selectedSortType => _selectedSortType;
  set selectedSortType(StockSortTypes? value) {
    if (value != null) _selectedSortType = value;
  }

  StockStatistics? stockStatistics;

  List<DecreaseReasons> decreaseReasons = [];
  List<Product> products = [];

  String exportStockExcelLink = '';
  bool exportStockItemExcelLink = false;

  List<MeasureUnit> measureUnits = getIt<MainScreenBloc>().measureUnits;
  final PaginationState<StockInfo> stocksPagination = PaginationState<StockInfo>();

  StockBloc(this._stockRepository, this._productRepository) : super(StockInitial()) {
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        add(const GetAllStockRequestEvent());
        add(const GetStockStatistics());
      }
      if (state is GetMeasureUnitsSuccess) {
        measureUnits = state.measureUnits;
      }
    });
    on<GetExportExcelLink>((event, emit) async {
      emit(const GetStockExcelReportLink(isLoading: true));
      final result = await _stockRepository.getExportExcelLink();

      result.fold((left) => emit(GetStockExcelReportLink(error: left.errorMessage)), (right) {
        exportStockExcelLink = right;
        emit(const GetStockExcelReportLink(isSuccess: true));
      });
    });

    on<GetExportExcelLinkItem>((event, emit) async {
      emit(const GetStockItemExcelReportLink(isLoading: true));
      final result = await _stockRepository.getExportExcelLinkItem(itemStockId:event.itemStockId,filterInfos: event.filterInfos,orderInfos: event.orderInfos,columns: event.columns,page: event.page,count: event.count );

      result.fold((left) => emit(GetStockItemExcelReportLink(error: left.errorMessage)), (right) {
        exportStockItemExcelLink = right;
        emit(const GetStockItemExcelReportLink(isSuccess: true));
      });
    });

    on<GetStockStatistics>((event, emit) async {
      emit(const GetStockStatisticsState(isLoading: true));
      Either<Failure, StockStatistics> result = await _stockRepository.getStockStatistics();

      result.fold((left) {
        emit(GetStockStatisticsState(error: left.errorMessage));
      }, (right) {
        stockStatistics = right;
        emit(const GetStockStatisticsState(isSuccess: true));
      });
    });

    on<GetSpecificProduct>((event, emit) async {
      emit(const GetSpecificProductStates(isLoading: true));
      final productResult = await _productRepository.getSpecificProduct(event.searchText);

      productResult.fold((left) {
        emit(const GetSpecificProductStates(error: 'No results found'));
      }, (right) {
        emit(GetSpecificProductStates(product: right));
      });
    });

    on<GetAllStockRequestEvent>((event, emit) async {
      if (!event.isRefreshing) searchText = event.searchText.trim();
      if (!event.getMore) {
        stocksPagination.dispose();
      } else if (stocksPagination.onFetching) {
        return;
      }

      if (stocksPagination.hasMore) {
        selectedSortType = event.selectedStockSortType;
        if (stocksPagination.currentPage == 1) emit(const AllStocksLoadingState());

        stocksPagination.sendRequestForNextPage();

        Either<Failure, Stocks> result = await _stockRepository.getAllStocks(
          currentPage: stocksPagination.currentPage,
          searchText: searchText,
          orderType: selectedSortType.sortType,
        );

        result.fold((left) => debugPrint("all sotcks error ${left.errorMessage}"), (right) {
          stocksPagination.gotNextPageData(right.stocks, right.totalPageCount);

          emit(GetAllStocksSuccess(right.currentPageNumber, stocksPagination.hasMore));
        });
      }
    });

    on<IncreaseStockEvent>((event, emit) async {
      emit(const IncreaseStockState(isLoading: true));
      Either<Failure, bool> result = await _stockRepository.increaseStock(
          itemId: event.itemId,
          amount: event.amount,
          pricePerUnit: event.pricePerUnit,
          unitMeasureId: event.unitMeasureId);

      result.fold((left) {
        debugPrint("edit stock failed ${left.errorMessage}");

        emit(IncreaseStockState(error: left.errorMessage));
      }, (right) {
        emit(const IncreaseStockState(isSuccess: true));
        add(const GetAllStockRequestEvent());
        add(const GetStockStatistics());
      });
    });

    on<DecreaseStockEvent>((event, emit) async {
      emit(const DecreaseStockState(isLoading: true));
      Either<Failure, bool> result = await _stockRepository.decreaseStock(
          itemId: event.itemId, amount: event.amount, reasonId: event.reasonId);

      result.fold((left) {
        debugPrint("edit stock failed ${left.errorMessage}");

        emit(DecreaseStockState(error: left.errorMessage));
      }, (right) {
        emit(const DecreaseStockState(isSuccess: true));
        add(const GetAllStockRequestEvent());
        add(const GetStockStatistics());
      });
    });

    on<GetAllProducts>((event, emit) async {
      emit(const GetAllProductsState(isLoading: true));

      final result = await _productRepository.searchProducts(
          sortField: Defaults.sortFiledPrice,
          sortType: OrderOperator.desc.value,
          searchText: '',
          onlyActiveItems: false);

      result.fold((left) => emit(GetAllProductsState(error: left.errorMessage)), (right) {
        for (var mainCategory in right) {
          for (var subCat in (mainCategory.subCategories ?? [])) {
            products.addAll(subCat.products);
          }
        }
        emit(const GetAllProductsState(isSuccess: true));
      });
    });

    on<GetDecreaseReasons>((event, emit) async {
      final result = await _stockRepository.getStockChangeReasons();

      result.fold((left) {}, (right) {
        decreaseReasons = right;
      });
    });
  }

  manageLastSearch() {
    if (searchText.isNotEmpty) {
      searchText = '';
      add(const GetAllStockRequestEvent());
    }
  }
}
