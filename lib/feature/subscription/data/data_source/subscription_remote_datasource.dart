import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/params/check_payment_status_parameter.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/response/billing_history/billing_history_list_response.dart';
import 'package:merchant_dashboard/feature/subscription/data/models/response/shared_features/shared_features_response.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/client/parameter/base_filter_parameter.dart';
import '../../../../core/utils/exceptions.dart';
import '../models/params/selected_plan_calculate_parameter.dart';
import '../models/params/subscription_plan_details_parameter.dart';
import '../models/response/branch_plan_details/branch_plan_details_response.dart';
import '../models/response/checkout_response/payment_status_response.dart';
import '../models/response/plans/plans_response.dart';
import '../models/response/subscription_package_calculation/subscription_package_calculate_response.dart';
import '../models/response/subscription_package_details/subscription_package_details_response.dart';

abstract class ISubscriptionRemoteDataSource {
  Future<PlansResponse> getAllPlans();

  Future<SharedFeaturesResponse> getSharedFeatures();

  Future<BranchPlanDetailsResponse> getCurrentBranchPlanDetails();

  Future<BillingHistoryListResponse> getBranchBillingHistory({required BaseFilterListParameter parameter});

  Future<SubscriptionPackageDetailsResponse> getSubscriptionPlanDetails(SubscriptionPlanDetailsParameter parameter);

  Future<SubscriptionPackageCalculateResponse> getSelectedPlanCalculate(SelectedPlanCalculateParameter parameter);

  Future<({String payLink, String referenceId})> subscribeToPackage(SelectedPlanCalculateParameter parameter);

  Future<PaymentStatusInfoResponse> checkPaymentStatus(CheckPaymentStatusParameter parameter);

  Future<({String payLink, String referenceId})> rePaymentRequest({required String paymentId});
}

@LazySingleton(as: ISubscriptionRemoteDataSource)
class SubscriptionRemoteDataSource extends ISubscriptionRemoteDataSource {
  final Dio _dioClient;

  SubscriptionRemoteDataSource(this._dioClient);

  @override
  Future<PlansResponse> getAllPlans() async {
    try {
      final Response response =
          await _dioClient.get("Subscription/Plans", queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        return PlansResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SharedFeaturesResponse> getSharedFeatures() async {
    try {
      final Response response =
          await _dioClient.get("Subscription/CommonFeatures", queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        return SharedFeaturesResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<BranchPlanDetailsResponse> getCurrentBranchPlanDetails() async {
    try {
      final Response response =
          await _dioClient.get("BranchSubscription/CurrentPlan", queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        return BranchPlanDetailsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<SubscriptionPackageDetailsResponse> getSubscriptionPlanDetails(SubscriptionPlanDetailsParameter parameter) async {
    try {
      final Response response = await _dioClient.get("Subscription/Package", queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        return SubscriptionPackageDetailsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  CancelToken cancelToken = CancelToken();

  @override
  Future<SubscriptionPackageCalculateResponse> getSelectedPlanCalculate(SelectedPlanCalculateParameter parameter) async {
    try {
      cancelToken.cancel();
      cancelToken = CancelToken();
      final Response response = await _dioClient.post("BranchSubscription/CalculateSubscriptionPreview",
          data: parameter.toJson(), cancelToken: cancelToken);

      if (response.statusCode == 200) {
        return SubscriptionPackageCalculateResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.type == DioExceptionType.cancel) {
        throw const RequestCancelled();
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<({String payLink, String referenceId})> subscribeToPackage(SelectedPlanCalculateParameter parameter) async {
    try {
      final Response response = await _dioClient.post("BranchSubscription/Subscribe", data: parameter.toJson());

      if (response.data case {"paymentLink": String payLink, "referenceId": String referenceId}) {
        return (payLink: payLink, referenceId: referenceId);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<BillingHistoryListResponse> getBranchBillingHistory({required BaseFilterListParameter parameter}) async {
    try {
      final Response response = await _dioClient.post("BranchSubscription/PaymentHistory",
          data: parameter.filterToJson(), queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        return BillingHistoryListResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<PaymentStatusInfoResponse> checkPaymentStatus(CheckPaymentStatusParameter parameter) async {
    try {
      final Response response = await _dioClient.get("BranchSubscription/PaymentStatus", queryParameters: parameter.toJson());

      if (response.statusCode == 200) {
        return PaymentStatusInfoResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<({String payLink, String referenceId})> rePaymentRequest({required String paymentId}) async {
    try {
      final Response response = await _dioClient.post("BranchSubscription/Pay", data: {'paymentId': paymentId});

      if (response.data case {"paymentLink": String payLink, "referenceId": String referenceId}) {
        return (payLink: payLink, referenceId: referenceId);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
