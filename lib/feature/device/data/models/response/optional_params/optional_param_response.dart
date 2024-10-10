import 'package:json_annotation/json_annotation.dart';

import '../../params/optional_parameters.dart';

part 'optional_param_response.g.dart';

@JsonSerializable()
class OptionalParamResponse {
  int? paramId;
  String? paramValue;
  String? paramName;
  String? paramType;

  OptionalParamResponse({this.paramId, this.paramValue, this.paramName, this.paramType});

  factory OptionalParamResponse.fromJson(Map<String, dynamic> json) => _$OptionalParamResponseFromJson(json);
}

class OptionalParametersResponse {
  List<OptionalParamResponse> params;

  OptionalParametersResponse(this.params);

  OptionalParametersResponse.fromJson(List<dynamic>? json) : params = json?.map((e) => OptionalParamResponse.fromJson(e)).toList() ?? [];

  List<OptionalParameters> toEntity() => params
      .map((e) => OptionalParameters(id: e.paramId ?? 0, paramValue: e.paramValue ?? '', paramName: e.paramName ?? '', paramType: e.paramType ?? ''))
      .toList();
}
