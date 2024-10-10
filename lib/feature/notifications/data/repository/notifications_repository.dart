import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/notifications/data/data_source/notifications_remote_datasource.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';
import '../models/entity/notification_event.dart';
import '../models/entity/notification_keyword.dart';
import '../models/entity/notification_type.dart';
import '../models/entity/sms_notification.dart';
import '../models/entity/text_notification.dart';
import '../models/params/add_sms_notification_parameter.dart';

abstract class INotificationsRepository {
  Future<Either<Failure, List<NotificationEvent>>> getNotificationEvents();

  Future<Either<Failure, List<NotificationType>>> getNotificationTypes();

  Future<Either<Failure, bool>> addSMSNotification(
      {required String notificationType, required String notificationEvent, required String text});

  Future<Either<Failure, bool>> deleteNotifications(String notificationId);

  Future<Either<Failure, bool>> updateNotificationSettings(bool isSmsAllowed);
  Future<Either<Failure, SMSNotification >> getSMSNotificationSettings();

  Future<Either<Failure, bool>> editNotifications(
      {required String notificationId,
      required String notificationType,
      required String notificationEvent,
      required String text});

  Future<Either<Failure, List<TextNotification>>> getSavedNotifications();

  Future<Either<Failure, List<NotificationKeyWord>>> getNotificationKeyWords();
}

@LazySingleton(as: INotificationsRepository)
class NotificationsRepository extends INotificationsRepository {
  final INotificationsRemoteDataSource _notificationsRemoteDataSource;

  NotificationsRepository(this._notificationsRemoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEvent>>> getNotificationEvents() async {
    try {
      final   response = await _notificationsRemoteDataSource.getNotificationEvents();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<NotificationType>>> getNotificationTypes() async {
    try {
      final   response = await _notificationsRemoteDataSource.getNotificationTypes();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> addSMSNotification(
      {required String notificationType, required String notificationEvent, required String text}) async {
    try {
      final bool response = await _notificationsRemoteDataSource.addSMSNotification(
          SMSNotificationParameter.add(notificationType: notificationType, notificationEvent: notificationEvent, text: text));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotifications(String notificationId) async {
    try {
      final bool response =
          await _notificationsRemoteDataSource.deleteNotifications(SMSNotificationParameter.delete(notificationId: notificationId));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> editNotifications(
      {required String notificationId,
      required String notificationType,
      required String notificationEvent,
      required String text}) async {
    try {
      final bool response = await _notificationsRemoteDataSource.editNotifications(SMSNotificationParameter.edit(
          notificationId: notificationId, notificationType: notificationType, notificationEvent: notificationEvent, text: text));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<TextNotification>>> getSavedNotifications() async {
    try {
      final   response = await _notificationsRemoteDataSource.getSavedNotifications(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<NotificationKeyWord>>> getNotificationKeyWords() async {
    try {
      final response = await _notificationsRemoteDataSource.getNotificationKeyWords();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateNotificationSettings(bool isSmsAllowed) async {
    try {
      final response = await _notificationsRemoteDataSource.updateNotificationSettings(isSmsAllowed);

      return Right(response );
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, SMSNotification>> getSMSNotificationSettings() async {
    try {
      final response = await _notificationsRemoteDataSource.getSMSNotificationSettings( );

      return Right(response.toEntity() );
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
