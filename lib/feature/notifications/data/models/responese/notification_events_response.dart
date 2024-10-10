import '../entity/notification_event.dart';

class NotificationEventsResponse {
  final List<NotificationEventItemResponse> items;


  NotificationEventsResponse(this.items);

  NotificationEventsResponse.fromJson(List<dynamic>? json)
      : items = json?.map((e) => NotificationEventItemResponse.fromJson(e)).toList() ?? [];

  List<NotificationEvent> toEntity() =>
      items.map((e) =>
          NotificationEvent(notificationEventId: e.notificationEventId ?? '',
              notificationEventName: e.notificationEventName ?? '-',
              notificationEventDesc: e.notificationEventDesc ?? '-')).toList();
}

class NotificationEventItemResponse {
  String? notificationEventId;
  String? notificationEventName;
  String? notificationEventDesc;


  NotificationEventItemResponse({this.notificationEventId,
    this.notificationEventName,
    this.notificationEventDesc});

  NotificationEventItemResponse.fromJson(Map<String, dynamic> json) {
    notificationEventId = json['notificationEventId'];
    notificationEventName = json['notificationEventName'];
    notificationEventDesc = json['notificationEventDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationEventId'] = notificationEventId;
    data['notificationEventName'] = notificationEventName;
    data['notificationEventDesc'] = notificationEventDesc;
    return data;
  }
}