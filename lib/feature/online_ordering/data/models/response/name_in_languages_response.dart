import 'package:json_annotation/json_annotation.dart';

part 'name_in_languages_response.g.dart';

@JsonSerializable()
class NameInLanguages {
  int? id;
  int? wordId;
  int? languageId;
  String? languageName;
  String? text;

  NameInLanguages({this.id, this.wordId, this.languageId, this.languageName, this.text});

  factory NameInLanguages.fromJson(Map<String, dynamic> json) => _$NameInLanguagesFromJson(json);

}
