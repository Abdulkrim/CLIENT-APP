import 'package:equatable/equatable.dart';

class NotificationEvent extends Equatable{
  final String notificationEventId;
  final String notificationEventName;
  final String notificationEventDesc;

  const NotificationEvent(
      {required this.notificationEventId,
      required this.notificationEventName,
      required this.notificationEventDesc});

  const NotificationEvent.firstItem()
      : notificationEventId = '0',
        notificationEventName = 'Select Notification Event',
        notificationEventDesc = '-';

  @override
  List<Object> get props => [notificationEventDesc , notificationEventName , notificationEventId];
}
