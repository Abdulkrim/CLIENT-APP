import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/device/data/repository/device_repository.dart';
import 'package:merchant_dashboard/feature/device/data/models/entity/optional_param_keys.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/branch_parameters.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/payment_type.dart';
import 'package:merchant_dashboard/feature/signup/data/models/entity/tax.dart';
import 'package:merchant_dashboard/feature/signup/data/repository/signup_repository.dart';
import 'package:merchant_dashboard/injection.dart';

import '../../../../core/utils/failure.dart';
import '../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../data/models/entity/payment_settings.dart';
import '../../data/repository/settings_repository.dart';

part 'settings_event.dart';

part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository _settingsRepository;
  final IDeviceRepository _deviceRepository;
  final ISignUpRepository _signUpRepository;

  ({String id, bool value}) isAddressRequired = (id: '', value: false);

  ({String id, bool value}) isParam1Enabled = (id: '', value: false);
  ({String id, bool value}) isParam2Enabled = (id: '', value: false);
  ({String id, bool value}) isParam3Enabled = (id: '', value: false);
  ({String id, String value}) param1Value = (id: '', value: '');
  ({String id, String value}) param2Value = (id: '', value: '');
  ({String id, String value}) param3Value = (id: '', value: '');

  List<PaymentType> paymentTypes = const [];

  Tax? branchTaxValue;

  SettingsBloc(this._settingsRepository, this._deviceRepository, this._signUpRepository) : super(SettingsInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        add(const GetAllPaymentTypes());

        add(const GetBranchPaymentSettings());

        add(const GetOptionalParameters());

        add(const GetBranchTaxValue());
      }
    });

    on<GetBranchTaxValue>((event, emit) async {
      final result = await _settingsRepository.getDefaultTaxValue();

      result.fold(
        (left) => emit(GetBranchTaxValueStates(error: left.errorMessage)),
        (right) {
          branchTaxValue = right;
          emit(GetBranchTaxValueStates(tax: right));
        },
      );
    });
    on<GetOptionalParameters>((event, emit) async {
      emit(const GetParamsStates(isLoading: true));

      final result = await _deviceRepository.getOptionalParameters();

      result.fold((left) => debugPrint(left.errorMessage), (right) {
        isAddressRequired = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.isAddressRequired.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.isAddressRequired.value).flagParamValue,
        );
        isParam1Enabled = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.isParam1Enabled.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.isParam1Enabled.value).flagParamValue
        );
        isParam2Enabled = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.isParam2Enabled.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.isParam2Enabled.value).flagParamValue
        );
        isParam3Enabled = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.isParam3Enabled.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.isParam3Enabled.value).flagParamValue
        );

        param1Value = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.param1Value.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.param1Value.value).paramValue
        );
        param2Value = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.param2Value.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.param2Value.value).paramValue
        );
        param3Value = (
          id: right.firstWhere((element) => element.paramName == OptionalParamKeys.param3Value.value).id.toString(),
          value: right.firstWhere((element) => element.paramName == OptionalParamKeys.param3Value.value).paramValue
        );

        emit(const GetParamsStates(isSuccess: true));
      });
    });

    on<UpdateOptionalParameters>((event, emit) async {
      if (event.hasLoading) emit(const UpdateOptionalParamsState(isLoading: true));
      final result = await _deviceRepository.updateOptionalParameters(event.param);

      result.fold((left) => emit(UpdateOptionalParamsState(error: left.errorMessage)), (right) {
        if (event.hasLoading) emit(const UpdateOptionalParamsState(isSuccess: true));
      });
    });

    on<AddPaymentModeEvent>((event, emit) async {
      emit(const AddPaymentModeState(isLoading: true));
      final result = await _settingsRepository.addPaymentMode(event.name, event.canHaveRefrence);

      result.fold((left) => emit(AddPaymentModeState(error: left.errorMessage)), (right) {
        add(const GetAllPaymentTypes());
        emit(const AddPaymentModeState(isSuccess: true));
      });
    });

    on<GetAllPaymentTypes>((event, emit) async {
      emit(const GetPaymentTypesStates(isLoading: true));

      final result = await _settingsRepository.getPaymentTypes();

      result.fold(
        (left) => emit(GetPaymentTypesStates(error: left.errorMessage)),
        (right) {
          paymentTypes = right;
          emit(const GetPaymentTypesStates(isSuccess: true));
        },
      );
    });
    on<GetBranchPaymentSettings>((event, emit) async {
      emit(const GetPaymentSettingsState(isLoading: true));
      final result = await _settingsRepository.getPaymentSettings();

      result.fold((left) {
        emit(GetPaymentSettingsState(error: left.errorMessage));
      }, (right) {
        /*   if (!right.hasData) {
          add(const GetBusinessDefaultParameterValue());
        } else { */
        emit(GetPaymentSettingsState(parameters: right));
        // }
      });
    });

    on<UpdatePaymentSettings>((event, emit) async {
      emit(const UpdatePaymentSettingsState(isLoading: true));
      final result = await _settingsRepository.managePaymentSettings(
          payments: event.payments,
          claimAllowed: event.claimAllowed,
          customerAllowed: event.customerAllowed,
          taxID: event.taxID,
          taxAllowed: event.taxAllowed,
          taxTypeId: event.taxTypeId,
          trn: event.trn);

      result.fold((left) => emit(UpdatePaymentSettingsState(error: left.errorMessage)),
          (right) => emit(const UpdatePaymentSettingsState(isSuccess: true)));
    });

    on<UpdateDiscountValue>((event, emit) async {
      emit(const UpdateDiscountValueStates(isLoading: true));
      final Either<Failure, bool> result = await _settingsRepository.updateDiscountValue(
          discountTypeValue: event.discountType, discountValue: event.discountValue);

      result.fold((left) {
        debugPrint(left.errorMessage);
        emit(UpdateDiscountValueStates(error: left.errorMessage));
      }, (right) {
        emit(const UpdateDiscountValueStates(isSuccess: true));
      });
    });
  }
}
