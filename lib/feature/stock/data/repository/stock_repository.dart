import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/stock/data/data_source/stock_remote_datasouce.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/decrease_reason.dart';
import 'package:merchant_dashboard/feature/stock/data/models/entity/stocks.dart';
import 'package:merchant_dashboard/feature/stock/data/models/params/decrease_stock_parameter.dart';
import 'package:merchant_dashboard/feature/stock/data/models/params/increase_stock_parameter.dart';
import 'package:merchant_dashboard/feature/stock/data/models/response/stock_list_response.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/constants/defaults.dart';
import '../models/entity/stock_statistics.dart';
import '../models/params/download_stock_parameter.dart';
import '../models/response/stock_statistics_response.dart';

abstract class IStockRepository {
  Future<Either<Failure, Stocks>> getAllStocks({
    required int currentPage,
    required String searchText,
    required int orderType,
  });

  Future<Either<Failure, bool>> increaseStock({
    required int itemId,
    required num amount,
    required num pricePerUnit,
    required int unitMeasureId,
  });

  Future<Either<Failure, bool>> decreaseStock({
    required int itemId,
    required num amount,
    required int reasonId,
  });

  Future<Either<Failure, StockStatistics>> getStockStatistics();

  Future<Either<Failure, List<DecreaseReasons>>> getStockChangeReasons();

  Future<Either<Failure, String>> getExportExcelLink();
  Future<Either<Failure, bool>> getExportExcelLinkItem({
    required int itemStockId,
    List<dynamic>? filterInfos,
    List<dynamic>? orderInfos,
    List<dynamic>? columns,
    int count,
    int page,
});
}

@LazySingleton(as: IStockRepository)
class StockRepository extends IStockRepository {
  final IStockRemoteDataSource _stockRemoteDataSource;

  StockRepository(this._stockRemoteDataSource);

  @override
  Future<Either<Failure, StockStatistics>> getStockStatistics() async {
    try {
      StockStatisticsResponse response = await _stockRemoteDataSource.getStockStatistics(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, Stocks>> getAllStocks(
      {required int currentPage, required String searchText, required int orderType}) async {
    try {
      final stockListParameter = BaseFilterListParameter(
          filterInfo: [
            BaseFilterInfoParameter(logical: LogicalOperator.or.value, propertyName: 'itemNameEN', value: searchText, operator: QueryOperator.contains.value),
            BaseFilterInfoParameter(logical: LogicalOperator.or.value, propertyName: 'itemNameTR', value: searchText, operator: QueryOperator.contains.value),
            BaseFilterInfoParameter(logical: LogicalOperator.or.value, propertyName: 'itemNameFR', value: searchText, operator: QueryOperator.contains.value),
            BaseFilterInfoParameter(logical: LogicalOperator.or.value, propertyName: 'itemNameAR', value: searchText, operator: QueryOperator.contains.value),
            BaseFilterInfoParameter(logical: LogicalOperator.or.value, propertyName: 'Barcode', value: searchText, operator: QueryOperator.contains.value),

          ],
          orderInfo: [BaseSortInfoParameter(orderType: orderType, property: 'ItemStock.Quantity')],
          page: currentPage);
      StockListResponse response = await _stockRemoteDataSource.getAllStocks(stockListParameter);

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> increaseStock({
    required int itemId,
    required num amount,
    required num pricePerUnit,
    required int unitMeasureId,
  }) async {
    try {
      final response = await _stockRemoteDataSource.increaseStock(
          IncreaseStockParameter(amount: amount, itemId: itemId, pricePerUnit: pricePerUnit, unitOfMeasureId: unitMeasureId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> decreaseStock({
    required int itemId,
    required num amount,
    required int reasonId,
  }) async {
    try {
      final response =
          await _stockRemoteDataSource.decreaseStock(DecreaseStockParameter(amount: amount, itemId: itemId, reasonId: reasonId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<DecreaseReasons>>> getStockChangeReasons() async {
    try {
      final response = await _stockRemoteDataSource.getStockChangeReasons();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> getExportExcelLink() async {
    try {
      final response = await _stockRemoteDataSource.getExportExcelLink();

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> getExportExcelLinkItem({
   required int itemStockId ,
    List<dynamic>? filterInfos,
    List<dynamic>? orderInfos,
    List<dynamic>? columns,
    int count = 0,
    int page = 0,
}) async {
    try {
      final response = await _stockRemoteDataSource.getExportExcelLinkItem(DownloadStockParameter(filterInfos:filterInfos,orderInfos: orderInfos,columns: columns, count:  count, page: page), itemStockId);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
