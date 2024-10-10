// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name_in_languages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NameInLanguages _$NameInLanguagesFromJson(Map<String, dynamic> json) =>
    NameInLanguages(
      id: (json['id'] as num?)?.toInt(),
      wordId: (json['wordId'] as num?)?.toInt(),
      languageId: (json['languageId'] as num?)?.toInt(),
      languageName: json['languageName'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$NameInLanguagesToJson(NameInLanguages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'wordId': instance.wordId,
      'languageId': instance.languageId,
      'languageName': instance.languageName,
      'text': instance.text,
    };
