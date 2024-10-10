import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/business_hours/data/models/entity/branch_time_shifts.dart';
import 'package:merchant_dashboard/feature/business_hours/data/repository/branch_shift_repository.dart';
import 'package:merchant_dashboard/feature/expense/data/models/responese/expense_amounts_response.dart';

import '../../../data/models/responese/working_hours_response.dart';

part 'branch_shift_state.dart';

@injectable
class BranchShiftCubit extends Cubit<BranchShiftState> {
  final IBranchShiftRepository _branchShiftRepository;

  BranchShiftCubit(this._branchShiftRepository) : super(BranchShiftInitial());

  BranchTimeShifts? branchShifts;

  void getBranchShifts(int workType) async {
    emit(const GetBranchShiftState(isLoading: true));
    final result = await _branchShiftRepository.getBranchShifts(workingType: workType);

    result.fold((left) => emit(GetBranchShiftState(errorMsg: left.errorMessage)), (right) {
      branchShifts = right;
      emit(const GetBranchShiftState(isSuccess: true));
    });
  }

  void manageWorkTypeShiftTimes(
      {required int workType, required List<({WorkDay workday, List<WorkingHours> hours})> shifts}) async {
    emit(const ManageBranchShiftState(isLoading: true));
    final result = await _branchShiftRepository.manageWorkTypeShiftTimes(workType: workType, shifts: shifts);

    result.fold((left) => emit(ManageBranchShiftState(errorMsg: left.errorMessage)), (right) {
      emit(const ManageBranchShiftState(isSuccess: true));
    });
  }

  void createExceptionShift(
      {required int workType,
      required DateTime fromDate,
      required DateTime toDate,
      required String fromTime,
      required String fromTimeType,
      required String toTimetype,
      required String toTime,
      required bool isClosed,
      required String reason}) async {
    emit(const AddExceptionState(isLoading: true));
    final result = await _branchShiftRepository.createExceptionShift(
        workType: workType,
        fromDate: fromDate,
        toDate: toDate,
        fromTime: fromTime,
        toTime: toTime,
        toTimetype: toTimetype,
        fromTimeType: fromTimeType,
        isClosed: isClosed,
        reason: reason);

    result.fold((left) => emit(AddExceptionState(errorMsg: left.errorMessage)), (right) {
      emit(const AddExceptionState(isSuccess: true));
    });
  }
}
