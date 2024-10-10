import 'package:merchant_dashboard/feature/business_hours/data/models/responese/branch_time_shifts_response.dart';

import '../responese/working_hours_response.dart';

class BranchTimeShifts {
  final String? workTypeName;
  final int? id;
  final WorkType? workType;
  final List<({WorkDay workday, List<WorkingHours> hours})> workingHours;

  BranchTimeShifts({
    this.workTypeName,
    this.id,
    this.workType,
    required this.workingHours,
  });
}

class WorkingHours {
  int? branchShiftId;
  int? id;
  WorkDay? workDay;
  String? from;
  String? to;
  TimeType? fromType;
  TimeType? toType;

  WorkingHours({
    this.branchShiftId,
    this.id,
    this.workDay,
    this.from,
    this.fromType,
    this.to,
    this.toType,
  });

  WorkingHours.empty();
}
