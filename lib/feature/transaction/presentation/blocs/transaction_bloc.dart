import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/pagination_state.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/cashiers/data/models/entity/cashier.dart';
import 'package:merchant_dashboard/feature/cashiers/data/repository/cashier_repository.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/repository/category_repository.dart';
import 'package:merchant_dashboard/feature/products/data/repository/product_repository.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/cashier_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/category_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/product_filter.dart';
import 'package:merchant_dashboard/feature/transaction/data/models/entity/transaction.dart';
import 'package:merchant_dashboard/feature/transaction/data/repository/transaction_repository.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/mixins/date_time_utilities.dart';

import '../../data/models/entity/transaction_details.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> with DateTimeUtilities {
  List<CategoryFilter> categories = [];
  late CategoryFilter selectedCategoryFilterItem = const CategoryFilter.firstItem();

  late SubCategoryFilter selectedSubCategoryCategoryFilterItem = const SubCategoryFilter.firstItem();
  late List<SubCategoryFilter> subCategories = [selectedSubCategoryCategoryFilterItem];

  late ProductFilter selectedProductFilterItem = const ProductFilter.firstItem();
  late List<ProductFilter> products = [selectedProductFilterItem];

  List<CashierFilter> cashiers = [];
  late CashierFilter selectedCashierFilterItem = const CashierFilter.firstItem();
  int selectedTransactionId = -1;

  String fromDate = Defaults.startDateRange;
  set _fromDate(String? val) {
    if (val != null) fromDate = val;
  }

  String toDate = Defaults.endDateRange;
  set _toDate(String? val) {
    if (val != null) toDate = val;
  }

  String? startTime ;
  String? endTime ;

  final ITransactionRepository _transactionRepository;
  final IProductRepository _productRepository;
  final ICashierRepository _cashierRepository;
  final ICategoryRepository _categoryRepository;

  final PaginationState<Transaction> transactionsPagination = PaginationState<Transaction>();

  resetProductsDropDown() {}

  TransactionBloc(this._transactionRepository, this._productRepository, this._cashierRepository, this._categoryRepository)
      : super(TransactionInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        add(const GetFiltersDataEvent());
        add(const GetAllTransactionsEvent());
      }
    });

    on<GetFiltersDataEvent>((event, emit) async {
      Either<Failure, List<ProductsCategory>> mainCatResult = await _categoryRepository.getMainCategories();

      mainCatResult.fold((left) {}, (right) {
        categories = [
          selectedCategoryFilterItem,
          ...right.map((e) => CategoryFilter(id: e.categoryId, name: e.categoryNameEN)).toList()
        ];

        emit(const CategoriesFilterDataSuccessState());
      });

      Either<Failure, CashierListInfo> cashierResult = await _cashierRepository.getAllCashiersOnce();
      cashierResult.fold((left) => debugPrint("get cashiers fails $left"), (right) {
        cashiers = [
          selectedCashierFilterItem,
          ...right.cashiers.map((e) => CashierFilter(id: e.id, name: e.name)).toList(),
        ];

        emit(const CashierFiltersDataSuccessState());
      });
    });

    on<GetAllTransactionsEvent>((event, emit) async {
      if (!event.getMore) {
        await transactionsPagination.dispose();
      } else if (transactionsPagination.onFetching) {
        return;
      }

      if (transactionsPagination.hasMore) {
        _fromDate = event.fromDate;
        _toDate = event.toDate;

        startTime = event.startTime;
        endTime = event.endTime;

        // if (isSecondDateBigger(fromDate, toDate)) {
        if (transactionsPagination.currentPage == 1) emit(const GetAllTransactionsLoadingState());

        transactionsPagination.sendRequestForNextPage();

        Either<Failure, TransactionListInfo> transResult = await _transactionRepository.getAllTransaction(
          categoryId: selectedCategoryFilterItem.id,
          productId: selectedProductFilterItem.id,
          cashierId: selectedCashierFilterItem.id,
          subCategoryId: selectedSubCategoryCategoryFilterItem.id,
          fromDate: fromDate,
          toDate: toDate,
          startTime: startTime,
          endTime: endTime,
          currentPage: transactionsPagination.currentPage,
        );

        transResult.fold((left) {
          if (left is ServerError && left.code == '0') return;
          emit(const GetTransactionFailedState());
        }, (right) {
          transactionsPagination.gotNextPageData(right.transactions, right.totalPageCount);

          emit(GetAllTransactionsSuccessState(right.currentPageNumber, transactionsPagination.hasMore));
        });
        /*  } else {
          emit(WrongDateFilterRangeEnteredState(fromDate, toDate));
        }*/
      }
    });

    on<ChangeCategoryFilterItemEvent>((event, emit) async {
      selectedCategoryFilterItem = event.categoryFilter;

      if (selectedCategoryFilterItem.id == 0) {
        selectedSubCategoryCategoryFilterItem = const SubCategoryFilter.firstItem();
        subCategories = [selectedSubCategoryCategoryFilterItem];
      } else {
        selectedSubCategoryCategoryFilterItem = const SubCategoryFilter.firstItem();

        Either<Failure, List<SubCategory>> subCatResult =
            await _categoryRepository.getAllSubCategories(selectedCategoryFilterItem.id);

        subCatResult.fold((left) {}, (right) {
          subCategories = [
            selectedSubCategoryCategoryFilterItem,
            ...right.map((e) => SubCategoryFilter(id: e.subCategoryId, name: e.categoryNameEN, parentId: e.categoryId)).toList()
          ];

          emit(const CategoriesFilterDataSuccessState());
        });
      }

      selectedProductFilterItem = const ProductFilter.firstItem();
      products = [selectedProductFilterItem];

      add(GetAllTransactionsEvent(categoryId: event.categoryFilter.id));
    });

    on<ChangeSubCategoryFilterItemEvent>((event, emit) async {
      selectedSubCategoryCategoryFilterItem = event.subCategoryFilter;
      selectedProductFilterItem = const ProductFilter.firstItem();

      Either<Failure, ({bool isLoyaltyAllowed, List<Product> products})> prodResult =
          await _productRepository.getSubCategoryProducts(
              onlyActiveItems: false,
              sortField: Defaults.sortFiledPrice,
              sortType: OrderOperator.desc.value,
              subCategoryId: selectedSubCategoryCategoryFilterItem.id);

      prodResult.fold((left) {}, (right) {
        products = [
          selectedProductFilterItem,
          ...right.products
              .map((e) => ProductFilter(id: e.productId, name: e.productNameEN, subCategoryId: e.subCategoryId))
              .toList()
        ];

        emit(const CategoriesFilterDataSuccessState());
      });

      add(GetAllTransactionsEvent(subCategoryId: event.subCategoryFilter.id));
    });

    on<ChangeProductFilterItemEvent>((event, emit) {
      selectedProductFilterItem = event.productFilter;
      add(GetAllTransactionsEvent(productId: event.productFilter.id));
    });

    on<ChangeCashierFilterItemEvent>((event, emit) {
      selectedCashierFilterItem = event.cashierFilter;
      add(GetAllTransactionsEvent(cashierId: event.cashierFilter.id));
    });

    on<ClaimTransactionRequestEvent>((event, emit) async {
      emit(const GetAllTransactionsLoadingState());

      Either<Failure, bool> result = await _transactionRepository.claimTransaction(event.transactionId, event.selectedDetailIds);

      result.fold((left) {
        emit(ClaimTransactionStates(error: left.errorMessage));
      }, (right) {
        emit(const ClaimTransactionStates(isSuccess: true));

        add(const GetAllTransactionsEvent());
      });
    });

    on<GetTransactionDetailsEvent>((event, emit) async {
      selectedTransactionId = event.transactionId;
      emit(const GetTransactionDetailsLoadingState());

      Either<Failure, List<TransactionDetails>> result = await _transactionRepository.getTransactionDetails(event.transactionId);

      result.fold((left) => debugPrint("get transactions details $left"), (right) {
        emit(GetTransactionDetailSuccessState(right, event.transactionId));
      });
    });

    on<ResetAllFiltersEvent>((event, emit) {
      selectedCategoryFilterItem = const CategoryFilter.firstItem();
      selectedSubCategoryCategoryFilterItem = const SubCategoryFilter.firstItem();
      selectedProductFilterItem = const ProductFilter.firstItem();
      selectedCashierFilterItem = const CashierFilter.firstItem();

      subCategories = [selectedSubCategoryCategoryFilterItem];
      products = [selectedProductFilterItem];

      add(GetAllTransactionsEvent(
          cashierId: selectedCashierFilterItem.id,
          productId: selectedProductFilterItem.id,
          categoryId: selectedCategoryFilterItem.id));
    });

    on<GetDownloadLink>((event, emit) async {
      emit(const GetDownloadLinkLoadingState());

      Either<Failure, String> result = await _transactionRepository.getDownloadExcelLink(
        categoryId: selectedCategoryFilterItem.id,
        productId: selectedProductFilterItem.id,
        cashierId: selectedCashierFilterItem.id,
        fromDate: fromDate,
        toDate: toDate,
        currentPage: transactionsPagination.currentPage,
      );

      result.fold((left) => emit(GetDownloadLinkStates(errorMsg: left.errorMessage ?? 'Try again')), (right) {
        emit(GetDownloadLinkStates(link: right));
      });
    });
  }
}
