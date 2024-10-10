import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/business_hours/data/data_source/branch_shifts_remote_datasource.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/params/create_exception_shift_parameter.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/params/get_branch_shift_parameter.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/params/manage_work_type_shift_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../utils/mixins/date_time_utilities.dart';
import '../models/responese/working_hours_response.dart';

abstract class IBranchShiftRepository {
  Future<Either<Failure, BranchTimeShifts?>> getBranchShifts({required int workingType});

  Future<Either<Failure, bool>> manageWorkTypeShiftTimes({
    required int workType,
    required List<({WorkDay workday, List<WorkingHours> hours})> shifts,
  });

  Future<Either<Failure, bool>> createExceptionShift(
      {required int workType,
      required DateTime fromDate,
      required DateTime toDate,
      required String fromTime,
      required String fromTimeType,
      required String toTimetype,
      required String toTime,
      required bool isClosed,
      required String reason});
}

@LazySingleton(as: IBranchShiftRepository)
class BranchShiftRepository extends IBranchShiftRepository with DateTimeUtilities {
  final IBranchRemoteDataSource _branchRemoteDataSource;

  BranchShiftRepository(this._branchRemoteDataSource);

  @override
  Future<Either<Failure, BranchTimeShifts?>> getBranchShifts({required int workingType}) async {
    try {
      final response =
          await _branchRemoteDataSource.getBranchShifts(GetBranchShiftParameter(workType: workingType));

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> createExceptionShift(
      {required int workType,
      required DateTime fromDate,
      required DateTime toDate,
      required String fromTime,
      required String fromTimeType,
      required String toTimetype,
      required String toTime,
      required bool isClosed,
      required String reason}) async {
    try {
      final response = await _branchRemoteDataSource.createExceptionShift(CreateExceptionShiftParameter(
          workType: workType,
          fromDate:
              convertDateFormat(fromDate.toIso8601String(), requestedFormet: "yyyy-MM-dd", hasTime: false),
          toDate: convertDateFormat(toDate.toIso8601String(), requestedFormet: "yyyy-MM-dd", hasTime: false),
          fromTime: fromTime.evaluateShortTimeFormat ?? '',
          toTime: toTime.evaluateShortTimeFormat ?? '',
          toTimeType: toTimetype,
          fromTimeType: fromTimeType,
          isClosed: isClosed,
          reason: reason));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> manageWorkTypeShiftTimes({
    required int workType,
    required List<({WorkDay workday, List<WorkingHours> hours})> shifts,
  }) async {
    try {
      final timeShiftsList = <TimeShiftParameter>[];

      for (var shift in shifts) {
        timeShiftsList.addAll(shift.hours
            .map((h) => TimeShiftParameter(
                workDay: shift.workday.workDayCode,
                fromTime: h.from?.trim().evaluateShortTimeFormat ?? '',
                fromTimeType: h.fromType?.timeType ?? '',
                toTime: h.to?.trim().evaluateShortTimeFormat ?? '',
                toTimeType: h.toType?.timeType ?? ''))
            .toList());
      }

      final response = await _branchRemoteDataSource
          .manageWorkTypeShiftTimes(ManageWorkTypeShiftParameter(workType: workType, shifts: timeShiftsList));

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
