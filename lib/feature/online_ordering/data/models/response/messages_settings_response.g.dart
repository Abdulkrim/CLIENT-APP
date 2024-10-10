// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesSettingsResponse _$MessagesSettingsResponseFromJson(
        Map<String, dynamic> json) =>
    MessagesSettingsResponse(
      branchId: json['branchId'] as String?,
      messageTypeId: (json['messageTypeId'] as num?)?.toInt(),
      messageTypeName: json['messageTypeName'] as String?,
      wordId: (json['wordId'] as num?)?.toInt(),
      nameInLanguages: (json['nameInLanguages'] as List<dynamic>?)
          ?.map((e) => NameInLanguages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesSettingsResponseToJson(
        MessagesSettingsResponse instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'messageTypeId': instance.messageTypeId,
      'messageTypeName': instance.messageTypeName,
      'wordId': instance.wordId,
      'nameInLanguages': instance.nameInLanguages,
    };
