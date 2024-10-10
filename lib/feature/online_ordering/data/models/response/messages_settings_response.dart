import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/online_ordering/data/models/entity/message_settings.dart';

import 'name_in_languages_response.dart';

part 'messages_settings_response.g.dart';

@JsonSerializable()
class MessagesSettingsResponse {
  String? branchId;
  int? messageTypeId;
  String? messageTypeName;
  int? wordId;
  List<NameInLanguages>? nameInLanguages;

  MessagesSettingsResponse({this.branchId, this.messageTypeId, this.messageTypeName, this.wordId, this.nameInLanguages});

  factory MessagesSettingsResponse.fromJson(Map<String, dynamic> json) => _$MessagesSettingsResponseFromJson(json);

  List<MessageSettings> toEntity() =>
      nameInLanguages
          ?.map(
            (e) => MessageSettings(message: e.text ?? '', languageName: e.languageName?.toLowerCase() ?? ''),
          )
          .toList() ??
      [];
}
