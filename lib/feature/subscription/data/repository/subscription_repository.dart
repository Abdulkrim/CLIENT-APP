import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/billing_history.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/payment_status.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/entity/shared_feature.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/params/check_payment_status_parameter.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/params/selected_plan_calculate_parameter.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/params/subscription_plan_details_parameter.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/constants/defaults.dart';
import '../../../../core/utils/exceptions.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../data_source/subscription_remote_datasource.dart';
import '../models/entity/branch_plan_details.dart';
import '../models/entity/subscription_package_calculate.dart';
import '../models/entity/subscription_package_details.dart';
import '../models/entity/subscription_plan.dart';

abstract class ISubscriptionRepository {
  Future<Either<Failure, List<SubscriptionPlan>>> getAllPlans();

  Future<Either<Failure, List<SharedFeature>>> getSharedFeatures();

  Future<Either<Failure, BranchPlanDetails>> getCurrentBranchPlanDetails();

  Future<Either<Failure, List<SubscriptionPackageDetails>>> getSubscriptionPlanDetails({required int packageId});

  Future<Either<Failure, SubscriptionPackageCalculate>> getSelectedPlanCalculate({
    required int packageId,
    required List<int> addonItems,
    required int duration,
    required int interval,
  });

  Future<Either<Failure, ({String payLink, String referenceId})>> subscribeToPackage({
    required int packageId,
    required List<int> addonItems,
    required int duration,
    required int payType,
    required int interval,
  });

  Future<Either<Failure, BillingHistory>> getBranchBillingHistory({required int currentPage, String? fromDate, String? toDate});

  Future<Either<Failure, PaymentStatus>> checkPaymentStatus({required String paymentId});

  Future<Either<Failure, ({String payLink, String referenceId})>> rePaymentRequest({required String paymentId});
}

@LazySingleton(as: ISubscriptionRepository)
class SubscriptionRepository extends ISubscriptionRepository with DateTimeUtilities {
  final ISubscriptionRemoteDataSource _subscriptionRemoteDataSource;

  SubscriptionRepository(this._subscriptionRemoteDataSource);

  @override
  Future<Either<Failure, List<SubscriptionPlan>>> getAllPlans() async {
    try {
      final response = await _subscriptionRemoteDataSource.getAllPlans();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<SharedFeature>>> getSharedFeatures() async {
    try {
      final response = await _subscriptionRemoteDataSource.getSharedFeatures();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, BranchPlanDetails>> getCurrentBranchPlanDetails() async {
    try {
      final response = await _subscriptionRemoteDataSource.getCurrentBranchPlanDetails();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : ((exception as ServerException).code == '404')
              ? Left(ServerError('Your subscription has expired, please renew your subscription', exception.code))
              : Left(ServerError(exception.errorMessage, exception.code));
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionPackageDetails>>> getSubscriptionPlanDetails({required int packageId}) async {
    try {
      final response =
          await _subscriptionRemoteDataSource.getSubscriptionPlanDetails(SubscriptionPlanDetailsParameter(packageId: packageId));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SubscriptionPackageCalculate>> getSelectedPlanCalculate(
      {required int packageId, required List<int> addonItems, required int duration, required int interval}) async {
    try {
      final response = await _subscriptionRemoteDataSource.getSelectedPlanCalculate(
          SelectedPlanCalculateParameter(packageId: packageId, addonItems: addonItems, duration: duration, interval: interval));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return Left(exception.toFailure());
    }
  }

  @override
  Future<Either<Failure, ({String payLink, String referenceId})>> subscribeToPackage(
      {required int packageId,
      required List<int> addonItems,
      required int duration,
      required int payType,
      required int interval}) async {
    try {
      final response = await _subscriptionRemoteDataSource.subscribeToPackage(SelectedPlanCalculateParameter(
          packageId: packageId, addonItems: addonItems, duration: duration, interval: interval, payType: payType));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, BillingHistory>> getBranchBillingHistory(
      {required int currentPage, String? fromDate, String? toDate}) async {
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
      final response = await _subscriptionRemoteDataSource.getBranchBillingHistory(
          parameter: BaseFilterListParameter(
        filterInfo: filterInfo,
        page: currentPage,
      ));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, PaymentStatus>> checkPaymentStatus({required String paymentId}) async {
    try {
      final response = await _subscriptionRemoteDataSource.checkPaymentStatus(CheckPaymentStatusParameter(payId: paymentId));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, ({String payLink, String referenceId})>> rePaymentRequest({required String paymentId}) async {
    try {
      final response = await _subscriptionRemoteDataSource.rePaymentRequest(paymentId: paymentId);

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
