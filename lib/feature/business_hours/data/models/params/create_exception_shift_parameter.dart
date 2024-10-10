import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class CreateExceptionShiftParameter extends MerchantBranchParameter {
  final int workType;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String fromTimeType;
  final String toTimeType;
  final String toTime;
  final bool isClosed;
  final String reason;

  CreateExceptionShiftParameter(
      {required this.workType,
      required this.fromDate,
      required this.toDate,
      required this.fromTime,
      required this.toTime,
      required this.isClosed,
      required this.fromTimeType,
      required this.toTimeType,
      required this.reason});

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        "workType": workType,
        "fromDate": fromDate,
        "toDate": toDate,
        "from": fromTime,
        "to": toTime,
        "fromType": fromTimeType,
        "toType": toTimeType,
        "isAllDayClosed": isClosed,
        "reason": reason
      };
}
