// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_time_shifts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchTimeShiftsResponse _$BranchTimeShiftsResponseFromJson(
        Map<String, dynamic> json) =>
    BranchTimeShiftsResponse(
      workTypeName: json['workTypeName'] as String?,
      id: (json['id'] as num?)?.toInt(),
      branchId: json['branchId'] as String?,
      workType: $enumDecodeNullable(_$WorkTypeEnumMap, json['workType']),
      workingHours: (json['workingHours'] as List<dynamic>?)
          ?.map((e) => WorkingHoursResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchTimeShiftsResponseToJson(
        BranchTimeShiftsResponse instance) =>
    <String, dynamic>{
      'workTypeName': instance.workTypeName,
      'id': instance.id,
      'branchId': instance.branchId,
      'workType': _$WorkTypeEnumMap[instance.workType],
      'workingHours': instance.workingHours,
    };

const _$WorkTypeEnumMap = {
  WorkType.serviceProvision: 1,
  WorkType.delivery: 2,
  WorkType.pickup: 3,
  WorkType.booking: 4,
  WorkType.nothing: 5,
};
