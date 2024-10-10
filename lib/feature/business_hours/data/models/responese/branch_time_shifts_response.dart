import 'package:json_annotation/json_annotation.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';

import 'working_hours_response.dart';

part 'branch_time_shifts_response.g.dart';

@JsonSerializable()
class BranchTimeShiftsResponse {
  String? workTypeName;
  int? id;
  String? branchId;
  WorkType? workType;
  List<WorkingHoursResponse>? workingHours;

  BranchTimeShiftsResponse({this.workTypeName, this.id, this.branchId, this.workType, this.workingHours});

  factory BranchTimeShiftsResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchTimeShiftsResponseFromJson(json);
}

@JsonEnum(valueField: 'workTypeCode')
enum WorkType {
  serviceProvision(1),
  delivery(2),
  pickup(3),
  booking(4),
  nothing(5);

  const WorkType(this.workTypeCode);

  final int workTypeCode;
}

class BranchTimeShiftListResponse {
  List<BranchTimeShiftsResponse> shifts;

  BranchTimeShiftListResponse(this.shifts);

  BranchTimeShiftListResponse.fromJson(List<dynamic>? json)
      : shifts = json?.map((e) => BranchTimeShiftsResponse.fromJson(e)).toList() ?? [];

  BranchTimeShifts toEntity() => shifts.isNotEmpty
      ? BranchTimeShifts(
          workTypeName: shifts.first.workTypeName ?? '',
          id: shifts.first.id ?? 0,
          workType: shifts.first.workType ?? WorkType.nothing,
          workingHours: () {
            final List<({WorkDay workday, List<WorkingHours> hours})> fList = WorkDay.values
                .map<({WorkDay workday, List<WorkingHours> hours})>(
                    (e) => (workday: e, hours: <WorkingHours>[]))
                .toList();

            for (var element in fList) {
              element.hours.addAll(shifts.first.workingHours!
                  .where((whe) => whe.workDay! == element.workday)
                  .map((e) => e.toEntity()));
            }

            return fList;
          }.call(),
        )
      : BranchTimeShifts(
          workingHours: WorkDay.values
              .map<({WorkDay workday, List<WorkingHours> hours})>(
                  (e) => (workday: e, hours: <WorkingHours>[]))
              .toList());
}
