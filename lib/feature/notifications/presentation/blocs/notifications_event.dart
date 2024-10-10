part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();


  @override
  List<Object?> get props => [];
}

class GetAllSavedNotifications extends NotificationsEvent {
  const GetAllSavedNotifications();

  @override
  List<Object?> get props => [];
}

class GetNotificationSettings extends NotificationsEvent {
  const GetNotificationSettings();

}

class UpdateNotificationSettings extends NotificationsEvent {
  final bool isSmsAllowed;
  const UpdateNotificationSettings(this.isSmsAllowed);

  @override
  List<Object> get props => [isSmsAllowed];
}

class AddNotificationEvent extends NotificationsEvent {
  final String notificationType;
  final String notificationEvent;
  final String text;

  const AddNotificationEvent({required this.notificationType, required this.notificationEvent, required this.text});

  @override
  List<Object> get props => [notificationType, notificationEvent, text];
}

class EditNotificationEvent extends NotificationsEvent {
  final String notificationId;
  final String notificationType;
  final String notificationEvent;
  final String text;

  const EditNotificationEvent(
      {required this.notificationId, required this.notificationType, required this.notificationEvent, required this.text});

  @override
  List<Object> get props => [notificationId, notificationType, notificationEvent, text];
}

class DeleteNotificationEvent extends NotificationsEvent {
  final String notificationId;

  const DeleteNotificationEvent({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}


class GetNotificationKeyWords extends NotificationsEvent {
  const GetNotificationKeyWords();

}

class GetAllNotificationTypeEvent extends NotificationsEvent {
  const GetAllNotificationTypeEvent();

}

class GetAllNotificationEventsEvent extends NotificationsEvent {
  const GetAllNotificationEventsEvent();

}

