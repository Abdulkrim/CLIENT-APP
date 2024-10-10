import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/client/parameter/base_filter_parameter.dart';
import 'package:merchant_dashboard/feature/report/data/data_source/reports_remote_datasource.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/products_reports.dart';
import 'package:merchant_dashboard/feature/report/data/models/entity/sub_categories_reports.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../models/entity/cashiers_reports.dart';

abstract class IReportsRepository {
  Future<Either<Failure, CashiersReports>> getCashierReport(
      {String? fromDate, String? toDate, required int currentPage});

  Future<Either<Failure, SubCategoriesReports>> getSubCategoriesReport(
      {String? fromDate, String? toDate, required int currentPage});

  Future<Either<Failure, ProductsReports>> getProductsReport(
      {String? fromDate, String? toDate, required int currentPage});

  Future<Either<Failure, String>> getCashiersDownloadReport(
      {String? fromDate, String? toDate, required int currentPage});

  Future<Either<Failure, String>> getSubCategoriesDownloadReport(
      {String? fromDate, String? toDate, required int currentPage});

  Future<Either<Failure, String>> getProductsDownloadReport(
      {String? fromDate, String? toDate, required int currentPage});
}

@LazySingleton(as: IReportsRepository)
class ReportRepository extends IReportsRepository with DateTimeUtilities {
  final IReportsRemoteDataSource _reportsRemoteDataSource;

  ReportRepository(this._reportsRemoteDataSource);

  @override
  Future<Either<Failure, CashiersReports>> getCashierReport(
      {String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      final response = await _reportsRemoteDataSource
          .getCashierReports(BaseFilterListParameter(filterInfo: filterInfo, page: currentPage));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, ProductsReports>> getProductsReport(
      {String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      final response = await _reportsRemoteDataSource
          .getProductsReports(BaseFilterListParameter(filterInfo: filterInfo, page: currentPage));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SubCategoriesReports>> getSubCategoriesReport(
      {String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      final response = await _reportsRemoteDataSource
          .getSubCategoriesReports(BaseFilterListParameter(filterInfo: filterInfo, page: currentPage));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> getCashiersDownloadReport(
      {String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      final response = await _reportsRemoteDataSource
          .getCashiersDownloadReports(BaseFilterListParameter(filterInfo: filterInfo, page: -1, count: 0));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> getProductsDownloadReport(
      {String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      final response = await _reportsRemoteDataSource
          .getProductsDownloadReports(BaseFilterListParameter(filterInfo: filterInfo, page: -1, count: 0));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> getSubCategoriesDownloadReport(
      {String? fromDate, String? toDate, required int currentPage}) async {
    try {
      List<BaseFilterInfoParameter> filterInfo = [];
      if (fromDate != null && fromDate.isNotEmpty && toDate != null && toDate.isNotEmpty) {
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'FromDate',
            value: getFilterFormatDate(fromDate),
            operator: QueryOperator.greaterThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
        filterInfo.add(BaseFilterInfoParameter(
            propertyName: 'ToDate',
            value: getFilterFormatDate(toDate),
            operator: QueryOperator.lessThanOrEqualTo.value,
            logical: LogicalOperator.and.value));
      }

      final response = await _reportsRemoteDataSource.getSubCategoriesDownloadReports(
          BaseFilterListParameter(filterInfo: filterInfo, page: -1, count: 0));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
