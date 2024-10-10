import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class ManageWorkTypeShiftParameter extends MerchantBranchParameter {
  final int workType;
  final List<TimeShiftParameter> shifts;

  ManageWorkTypeShiftParameter({required this.workType, required this.shifts});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "workType": workType,
        "shifts": shifts.map((e) => e.toJson()).toList(),
      };
}

class TimeShiftParameter {
  final int workDay;
  final String fromTime;
  final String fromTimeType;
  final String toTime;
  final String toTimeType;

  TimeShiftParameter(
      {required this.workDay,
      required this.fromTime,
      required this.fromTimeType,
      required this.toTime,
      required this.toTimeType});

  Map<String, dynamic> toJson() => {
        "workDay": workDay,
        "from": fromTime,
        "fromType": fromTimeType,
        "to": toTime,
        "toType": toTimeType,
      };
}
