import 'package:equatable/equatable.dart';

class TextNotification extends Equatable {
  final String notificationBaseID;
  final String notificationTypeId;
  final String notificationType;
  final String notificationEventId;
  final String notificationEvent;
  final String text;

  const TextNotification({
    required this.notificationBaseID,
    required this.notificationTypeId,
    required this.notificationEventId,
    required this.notificationType,
    required this.notificationEvent,
    required this.text,
  });

  @override
  List<Object> get props => [
        notificationBaseID,
        notificationTypeId,
        notificationEventId,
        notificationType,
        notificationEvent,
        text,
      ];
}
