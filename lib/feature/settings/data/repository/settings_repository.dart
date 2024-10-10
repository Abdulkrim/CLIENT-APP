import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/settings/data/models/entity/manage_payment_settings_parameter.dart';
import 'package:merchant_dashboard/feature/signup/data/models/entity/tax.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';
import '../data_store/settings_remote_datasource.dart';
import '../models/entity/payment_settings.dart';
import '../models/entity/payment_type.dart';
import '../models/params/add_payment_mode_parameter.dart';
import '../models/params/update_discount_value_parameters.dart';

abstract class ISettingsRepository {
  Future<Either<Failure, bool>> updateDiscountValue({required int discountTypeValue, required num discountValue});

  Future<Either<Failure, bool>> addPaymentMode(String name, bool canHaveReference);

  Future<Either<Failure, List<PaymentType>>> getPaymentTypes();

  Future<Either<Failure, List<PaymentType>>> getBranchSupportedPaymentTypes();

  Future<Either<Failure, Tax>> getDefaultTaxValue();

  Future<Either<Failure, bool>> managePaymentSettings(
      {required List<int> payments,
      required int claimAllowed,
      required bool customerAllowed,
      required int taxID,
      required bool taxAllowed,
      required int taxTypeId,
      required int trn});

  Future<Either<Failure, PaymentSettings>> getPaymentSettings();
}

@LazySingleton(as: ISettingsRepository)
class SettingsRepository extends ISettingsRepository {
  final ISettingsRemoteDataSource _settingsRemoteDataSource;

  SettingsRepository(this._settingsRemoteDataSource);

  @override
  Future<Either<Failure, List<PaymentType>>> getBranchSupportedPaymentTypes() async {
    try {
      final response = await _settingsRemoteDataSource.getBranchSupportedPaymentTypes(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<PaymentType>>> getPaymentTypes() async {
    try {
      final response = await _settingsRemoteDataSource.getPaymentTypes(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateDiscountValue({required int discountTypeValue, required num discountValue}) async {
    try {
      await _settingsRemoteDataSource
          .updateDiscountValue(UpdateDiscountValueParameters(discountTypeValue: discountTypeValue, discountValue: discountValue));

      return const Right(true);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, Tax>> getDefaultTaxValue() async {
    try {
      final result = await _settingsRemoteDataSource.getDefaultTaxValue(MerchantBranchParameter());

      return Right(result.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> addPaymentMode(String name, bool canHaveReference) async {
    try {
      final result =
          await _settingsRemoteDataSource.addPaymentMode(AddPaymentModeParameter(canHaveRefrence: canHaveReference, name: name));

      return Right(result);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, PaymentSettings>> getPaymentSettings() async {
    try {
      final result = await _settingsRemoteDataSource.getPaymentSettings(MerchantBranchParameter());

      return Right(result.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> managePaymentSettings(
      {required List<int> payments,
      required int claimAllowed,
      required bool customerAllowed,
      required int taxID,
      required bool taxAllowed,
      required int taxTypeId,
      required int trn}) async {
    try {
      final result = await _settingsRemoteDataSource.managePaymentSettings(ManagePaymentSettingsParameter(
          claimAllowed: claimAllowed,
          payment: payments,
          customerAllowed: customerAllowed,
          taxID: taxID,
          taxAllowed: taxAllowed,
          taxTypeId: taxTypeId,
          trn: trn));

      return Right(result);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
