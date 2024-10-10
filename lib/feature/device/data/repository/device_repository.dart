import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/device/data/data_source/device_remote_datasource.dart';
import 'package:merchant_dashboard/feature/device/data/models/entity/device.dart';
import 'package:merchant_dashboard/feature/device/data/models/params/update_pos_settings_parameter.dart';
import 'package:merchant_dashboard/feature/device/data/models/response/devices_response.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/params/update_merchant_logo_parameter.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/utils/exceptions.dart';
import '../../../../core/utils/failure.dart';
import '../../../dashboard/data/models/params/merchant_branch_parameter.dart';
import '../../../merchant_info/presentation/pages/merchant_info_screen.dart';
import '../models/entity/pos_settings.dart';
import '../models/params/optional_parameters.dart';
import '../../../settings/data/models/params/update_optional_parameters.dart';

abstract class IDeviceRepository {
  Future<Either<Failure, List<Device>>> getDevices();

  Future<Either<Failure, bool>> checkHasPos();

  Future<Either<Failure, List<OptionalParameters>>> getOptionalParameters();

  Future<Either<Failure, bool>> updateOptionalParameters(List<({String id, String value})> param);

  Future<Either<Failure, POSSettings>> getPOSSetting();

  Future<Either<Failure, bool>> updatePOSSettings(
      {required bool printAllowed,
      required String footerMessage,
      required bool rePrint,
      required int queueAllowed,
      required XFile? footerLogo,
      required XFile? printingLogo,
      required int discountAllowed,
      required int posTrxFromPOS,
      required int posOrderFromPOS,
      required int merchantCopy});
}

@LazySingleton(as: IDeviceRepository)
class DeviceRepository extends IDeviceRepository {
  final IDeviceRemoteDataSource _deviceRemoteDataSource;

  DeviceRepository(this._deviceRemoteDataSource);

  @override
  Future<Either<Failure, List<Device>>> getDevices() async {
    try {
      final DevicesResponse response = await _deviceRemoteDataSource.getDevices();

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> checkHasPos() async {
    try {
      final response = await _deviceRemoteDataSource.checkHasPos();

      return Right(response);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, List<OptionalParameters>>> getOptionalParameters() async {
    try {
      final response = await _deviceRemoteDataSource.getOptionalParameters(MerchantBranchParameter());

      return Right(response.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updateOptionalParameters(List<({String id, String value})> param) async {
    try {
      Map<String, String> map = {for (var element in param) element.id: element.value};

      await _deviceRemoteDataSource.updateOptionalParameters(UpdateOptionalParameters(keyValues: map));

      return const Right(true);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePOSSettings(
      {required bool printAllowed,
      required String footerMessage,
      required bool rePrint,
      required int queueAllowed,
      required XFile? footerLogo,
      required XFile? printingLogo,
      required int posTrxFromPOS,
      required int posOrderFromPOS,
      required int discountAllowed,
      required int merchantCopy}) async {
    try {
      await _deviceRemoteDataSource.updatePOSSettings(UpdatePOSSettingsParameter(
          discountAllowed: discountAllowed,
          footerLogo: footerLogo != null
              ? UpdateMerchantLogoParameter(
                  byte: await footerLogo.readAsBytes(),
                  fileMime: footerLogo.platformMimeType ?? '',
                  filename: footerLogo.name,
                  logoTypeId: LogoTypes.footerLogo.typeId)
              : null,
          printingLogo: printingLogo != null
              ? UpdateMerchantLogoParameter(
                  byte: await printingLogo.readAsBytes(),
                  fileMime: printingLogo.platformMimeType ?? '',
                  filename: printingLogo.name,
                  logoTypeId: LogoTypes.printingLogo.typeId)
              : null,
          queueAllowed: queueAllowed,
          printAllowed: printAllowed,
          footerMessage: footerMessage,
          posTrxFromPOS: posTrxFromPOS,
          posOrderFromPOS: posOrderFromPOS,
          rePrint: rePrint,
          merchantCopy: merchantCopy));

      return const Right(true);
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }

  @override
  Future<Either<Failure, POSSettings>> getPOSSetting() async {
    try {
      final result = await _deviceRemoteDataSource.getPOSSetting(MerchantBranchParameter());

      return Right(result.toEntity());
    } on BaseException catch (exception) {
      return (exception is RequestException)
          ? Left(RequestError(exception.errorMessage))
          : Left(ServerError(exception.errorMessage, (exception as ServerException).code));
    }
  }
}
