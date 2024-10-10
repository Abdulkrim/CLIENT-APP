import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';

part 'working_hours_response.g.dart';

@JsonSerializable()
class WorkingHoursResponse {
  int? branchShiftId;
  int? id;
  WorkDay? workDay;
  String? fromTime;
  TimeType? fromType;
  TimeType? toType;
  String? toTime;
  bool? isDeleted;

  WorkingHoursResponse(
      {this.branchShiftId,
      this.id,
      this.workDay,
      this.fromTime,
      this.toTime,
      this.fromType,
      this.toType,
      this.isDeleted});

  factory WorkingHoursResponse.fromJson(Map<String, dynamic> json) => _$WorkingHoursResponseFromJson(json);

  WorkingHours toEntity() => WorkingHours(
      branchShiftId: branchShiftId ?? 0,
      id: id ?? 0,
      workDay: workDay!,
      from: fromTime ?? '',
      to: toTime ?? '',
      fromType: fromType,
      toType: toType);
}

@JsonEnum(valueField: 'workDayCode')
enum WorkDay {
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  const WorkDay(this.workDayCode);

  final int workDayCode;
}

@JsonEnum(valueField: 'timeType')
enum TimeType {
  am('AM'),
  pm('PM');

  const TimeType(this.timeType);

  final String timeType;
}
