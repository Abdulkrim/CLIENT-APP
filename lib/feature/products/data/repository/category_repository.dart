import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/constants/defaults.dart';
import 'package:merchant_dashboard/core/utils/exceptions.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/auth/data/data_sources/login_local_datasource.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/add_main_category_parameter.dart';
import 'package:merchant_dashboard/feature/products/data/models/params/add_sub_category_parameter.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../data_source/category_remote_datasource.dart';
import '../models/entity/products.dart';
import '../models/response/product_category_response.dart';
import '../models/response/product_sub_category_response.dart';

abstract class ICategoryRepository {
  Future<Either<Failure, (int id, String image)>> addMainCategory({
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required bool isActive,
    required String categoryArName,
    required List<String> visibleApplications,
    XFile? categoryImage,
  });

  Future<Either<Failure, String>> editMainCategory({
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required String categoryArName,
    required int categoryId,
    required bool isActive,
    required List<String> visibleApplications,
    XFile? categoryImage,
  });

  Future<Either<Failure, String>> editSubCategory({
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required String categoryArName,
    required List<String> visibleApplications,
    required int categoryId,
    required int? mainCategoryId,
    required bool isActive,
    XFile? categoryImage,
  });

  Future<Either<Failure, (int id, String image)>> addSubCategory({
    required int mainCategoryId,
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required String categoryArName,
    required List<String> visibleApplications,
    required bool isActive,
    XFile? categoryImage,
  });

  Future<Either<Failure, List<ProductsCategory>>> serachMainCategories(String searchText);

  Future<Either<Failure, List<ProductsCategory>>> getMainCategories();

  Future<Either<Failure, List<SubCategory>>> getAllSubCategories(int mainCategoryId);

  Future<Either<Failure, List<SubCategory>>> searchSubCategories(String searchText);

  Future<Either<Failure, bool>> deleteMainCategory({required int categoryId});

  Future<Either<Failure, bool>> deleteSubCategory({required int subCategoryId});
}

@LazySingleton(as: ICategoryRepository)
class CategoryRepository extends ICategoryRepository {
  final ICategoryRemoteDataSource _categoryRemoteDataSource;
  final ILoginLocalDataSource _localDataSource;

  CategoryRepository(this._categoryRemoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (int id, String image)>> addMainCategory({
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required String categoryArName,
    required List<String> visibleApplications,
    required bool isActive,
    XFile? categoryImage,
  }) async {
    try {
      final (int id, String image) response = await _categoryRemoteDataSource.addMainCategory(
          AddMainCategoryParameter(
              categoryEngName: categoryEnName,
              categoryArName: categoryArName,
              categoryTrName: categoryTrName,
              categoryFrName: categoryFrName,
              visibleApplications: visibleApplications,
              logo: categoryImage,
              isActive: isActive));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> editMainCategory({
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required String categoryArName,
    required List<String> visibleApplications,
    required bool isActive,
    required int categoryId,
    XFile? categoryImage,
  }) async {
    try {
      final String response = await _categoryRemoteDataSource.editMainCategory(AddMainCategoryParameter(
          categoryEngName: categoryEnName,
          categoryArName: categoryArName,
          categoryTrName: categoryTrName,
          categoryFrName: categoryFrName,
          logo: categoryImage,
          categoryId: categoryId,
          visibleApplications: visibleApplications,
          isActive: isActive));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, String>> editSubCategory({
    required String categoryEnName,
    required String categoryFrName,
    required String categoryTrName,
    required String categoryArName,
    required List<String> visibleApplications,
    required int? mainCategoryId,
    required bool isActive,
    required int categoryId,
    XFile? categoryImage,
  }) async {
    try {
      final String response = await _categoryRemoteDataSource.editSubCategory(AddSubCategoryParameter(
          categoryEngName: categoryEnName,
          categoryArName: categoryArName,
          categoryTrName: categoryTrName,
          categoryFrName: categoryFrName,
          visibleApplications: visibleApplications,
          logo: categoryImage,
          subCategoryId: categoryId,
          mainCategoryId: mainCategoryId,
          isActive: isActive));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, (int id, String image)>> addSubCategory(
      {required int mainCategoryId,
      required String categoryEnName,
      required String categoryFrName,
      required String categoryTrName,
      required String categoryArName,
      required List<String> visibleApplications,
      required bool isActive,
      XFile? categoryImage}) async {
    try {
      final (int id, String image) response = await _categoryRemoteDataSource.addSubCategory(
          AddSubCategoryParameter(
              mainCategoryId: mainCategoryId,
              categoryEngName: categoryEnName,
              categoryArName: categoryArName,
              categoryTrName: categoryTrName,
              categoryFrName: categoryFrName,
              visibleApplications: visibleApplications,
              logo: categoryImage,
              isActive: isActive));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<ProductsCategory>>> serachMainCategories(String searchText) async {
    try {
      final ProductCategoryResponse response =
          await _categoryRemoteDataSource.getAllMainCategories(BaseFilterListParameter(filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'CategoryNameEN',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'CategoryNameFR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'CategoryNameTR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'CategoryNameAR',
            value: searchText),
      ]));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SubCategory>>> searchSubCategories(String searchText) async {
    try {
      final ProductSubCategoryResponse response = await _categoryRemoteDataSource
          .getAllSubCategories(BaseFilterListParameter(count: 0, page: -1, filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'subCategoryNameEN',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'subCategoryNameFR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'subCategoryNameTR',
            value: searchText),
        BaseFilterInfoParameter(
            logical: LogicalOperator.or.value,
            operator: QueryOperator.contains.value,
            propertyName: 'subCategoryNameAR',
            value: searchText),
      ]));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<ProductsCategory>>> getMainCategories() async {
    try {
      final ProductCategoryResponse response =
          await _categoryRemoteDataSource.getAllMainCategories(BaseFilterListParameter(count: 0, page: -1));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SubCategory>>> getAllSubCategories(int mainCategoryId) async {
    try {
      final ProductSubCategoryResponse response =
          await _categoryRemoteDataSource.getAllSubCategories(BaseFilterListParameter(filterInfo: [
        BaseFilterInfoParameter(
            logical: LogicalOperator.and.value,
            operator: QueryOperator.equals.value,
            propertyName: 'categoryId',
            value: mainCategoryId.toString())
      ]));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMainCategory({required int categoryId}) async {
    try {
      final response = await _categoryRemoteDataSource.deleteMainCategory(categoryId: categoryId);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteSubCategory({required int subCategoryId}) async {
    try {
      final response = await _categoryRemoteDataSource.deleteSubCategory(subCategoryId: subCategoryId);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
