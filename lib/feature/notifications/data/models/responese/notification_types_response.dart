import '../entity/notification_type.dart';

class NotificationTypesResponse {
  final List<NotificationTypeItemResponse> items;

  NotificationTypesResponse(this.items);

  NotificationTypesResponse.fromJson(List<dynamic>? json) : items = json?.map((e) => NotificationTypeItemResponse.fromJson(e)).toList() ?? [];

  List<NotificationType> toEntity() =>
      items.map((e) => NotificationType(notificationTypeId: e.notificationTypeId ?? '', notificationTypeName: e.notificationTypeName ?? '-')).toList();
}

class NotificationTypeItemResponse {
  String? notificationTypeId;
  String? notificationTypeName;

  NotificationTypeItemResponse({this.notificationTypeId, this.notificationTypeName});

  NotificationTypeItemResponse.fromJson(Map<String, dynamic> json) {
    notificationTypeId = json['notificationTypeId'];
    notificationTypeName = json['notificationTypeName'];
  }
}
