import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';
import '../models/params/add_sms_notification_parameter.dart';
import '../models/responese/notification_events_response.dart';
import '../models/responese/notification_keywords_response.dart';
import '../models/responese/notification_types_response.dart';
import '../models/responese/notifications_response.dart';
import '../models/responese/sms_notification_response.dart';

abstract interface class INotificationsRemoteDataSource {
  Future<NotificationEventsResponse> getNotificationEvents();

  Future<NotificationTypesResponse> getNotificationTypes();

  Future<bool> addSMSNotification(SMSNotificationParameter parameter);

  Future<bool> deleteNotifications(SMSNotificationParameter parameter);

  Future<bool> editNotifications(SMSNotificationParameter parameter);

  Future<NotificationsResponse> getSavedNotifications(MerchantBranchParameter parameter);

  Future<NotificationKeyWordsResponse> getNotificationKeyWords();

  Future<bool> updateNotificationSettings( bool isSmsAllowed);

  Future<NotificationSettingsResponse> getSMSNotificationSettings( );
}

@LazySingleton(as: INotificationsRemoteDataSource)
class NotificationRemoteDataSource extends INotificationsRemoteDataSource {
  final Dio _dioClient;

  NotificationRemoteDataSource(this._dioClient);

  @override
  Future<NotificationEventsResponse> getNotificationEvents() async {
    try {
      final response = await _dioClient.get("Notification/GetNotificationEvents");

      if (response.statusCode == 200) {
        final NotificationEventsResponse convertedResponse = NotificationEventsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<NotificationTypesResponse> getNotificationTypes() async {
    try {
      final Response response = await _dioClient.get("Notification/GetNotificationTypes");

      if (response.statusCode == 200) {
        final NotificationTypesResponse convertedResponse = NotificationTypesResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<NotificationsResponse> getSavedNotifications(MerchantBranchParameter parameter) async {
    try {
      final Response response =
          await _dioClient.get("Notification/GetBranchNotificationsText", queryParameters: parameter.branchToJson());

      if (response.statusCode == 200) {
        final NotificationsResponse convertedResponse = NotificationsResponse.fromJson(response.data);
        return convertedResponse;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> addSMSNotification(SMSNotificationParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Notification/AddBranchNotificationText",
          queryParameters: parameter.branchToJson(), data: parameter.toAddJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> deleteNotifications(SMSNotificationParameter parameter) async {
    try {
      final Response response =
          await _dioClient.post("Notification/DeleteBranchNotificationText", queryParameters: parameter.notificationIdJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> editNotifications(SMSNotificationParameter parameter) async {
    try {
      final Response response = await _dioClient.post("Notification/EditBranchNotificationText",
          queryParameters: parameter.notificationIdJson(), data: parameter.toAddJson());

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      if (error.response?.data case {'errors': List<dynamic> errors}) {
        throw RequestException(errors.firstOrNull);
      }
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<NotificationKeyWordsResponse> getNotificationKeyWords() async {
    try {
      final Response response = await _dioClient.get("Notification/Keywords");

      if (response.statusCode == 200) {
        return NotificationKeyWordsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<bool> updateNotificationSettings(bool isSmsAllowed) async {
    try {
      final Response response = await _dioClient.patch("BranchSettings/EditSmsSettings", data: {
        ...?MerchantBranchParameter().branchToJson(),
        'isSmsAllowed': isSmsAllowed
      });

      if (response.statusCode == 200) {
        return true;
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }

  @override
  Future<NotificationSettingsResponse> getSMSNotificationSettings() async {
    try {
      final Response response = await _dioClient.get("BranchSettings/SmsSettings", queryParameters: MerchantBranchParameter().branchToJson());

      if (response.statusCode == 200) {
        return NotificationSettingsResponse.fromJson(response.data);
      }
      throw RequestException(response.statusMessage ?? "Invalid Data");
    } on DioException catch (error) {
      throw ServerException(error.getDioErrorWrapper().serverMessage, (error.response?.statusCode ?? 0).toString());
    }
  }
}
