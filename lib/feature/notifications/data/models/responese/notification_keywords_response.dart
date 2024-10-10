
import '../entity/notification_keyword.dart';

class NotificationKeyWordsResponse {
  List<NotificationKeyWordItemResponse> data;

  NotificationKeyWordsResponse.fromJson(List<dynamic>? json)
      : data = json?.map((e) => NotificationKeyWordItemResponse.fromJson(e)).toList() ?? [];

  List<NotificationKeyWord> toEntity() =>
      data.map((e) => NotificationKeyWord(id: e.id ?? 0, keyword: e.keyword ?? '', title: e.title ?? '')).toList() ?? [];
}

class NotificationKeyWordItemResponse {
  int? id;
  String? keyword;
  String? title;

  NotificationKeyWordItemResponse({this.id, this.keyword, this.title});

  NotificationKeyWordItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
    title = json['title'];
  }
}
