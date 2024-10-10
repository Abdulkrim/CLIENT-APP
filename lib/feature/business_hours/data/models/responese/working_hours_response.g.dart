// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHoursResponse _$WorkingHoursResponseFromJson(
        Map<String, dynamic> json) =>
    WorkingHoursResponse(
      branchShiftId: (json['branchShiftId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      workDay: $enumDecodeNullable(_$WorkDayEnumMap, json['workDay']),
      fromTime: json['fromTime'] as String?,
      toTime: json['toTime'] as String?,
      fromType: $enumDecodeNullable(_$TimeTypeEnumMap, json['fromType']),
      toType: $enumDecodeNullable(_$TimeTypeEnumMap, json['toType']),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$WorkingHoursResponseToJson(
        WorkingHoursResponse instance) =>
    <String, dynamic>{
      'branchShiftId': instance.branchShiftId,
      'id': instance.id,
      'workDay': _$WorkDayEnumMap[instance.workDay],
      'fromTime': instance.fromTime,
      'fromType': _$TimeTypeEnumMap[instance.fromType],
      'toType': _$TimeTypeEnumMap[instance.toType],
      'toTime': instance.toTime,
      'isDeleted': instance.isDeleted,
    };

const _$WorkDayEnumMap = {
  WorkDay.monday: 1,
  WorkDay.tuesday: 2,
  WorkDay.wednesday: 3,
  WorkDay.thursday: 4,
  WorkDay.friday: 5,
  WorkDay.saturday: 6,
  WorkDay.sunday: 7,
};

const _$TimeTypeEnumMap = {
  TimeType.am: 'AM',
  TimeType.pm: 'PM',
};
