// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional_param_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionalParamResponse _$OptionalParamResponseFromJson(
        Map<String, dynamic> json) =>
    OptionalParamResponse(
      paramId: (json['paramId'] as num?)?.toInt(),
      paramValue: json['paramValue'] as String?,
      paramName: json['paramName'] as String?,
      paramType: json['paramType'] as String?,
    );

Map<String, dynamic> _$OptionalParamResponseToJson(
        OptionalParamResponse instance) =>
    <String, dynamic>{
      'paramId': instance.paramId,
      'paramValue': instance.paramValue,
      'paramName': instance.paramName,
      'paramType': instance.paramType,
    };
