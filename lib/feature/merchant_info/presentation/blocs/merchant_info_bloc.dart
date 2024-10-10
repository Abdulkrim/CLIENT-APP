import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/utils/failure.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/repository/merchant_info_repository.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../injection.dart';

part 'merchant_info_event.dart';

part 'merchant_info_state.dart';

@injectable
class MerchantInfoBloc extends Bloc<MerchantInfoEvent, MerchantInfoState> {
  MerchantInformation? merchantInformation;
  final IMerchantInfoRepository _merchantRepository;

  MerchantInfoBloc(this._merchantRepository) : super(MerchantInfoInitial()) {
    getIt<MainScreenBloc>().stream.listen((event) {
      if (event is MerchantInfoSelectionChangedState && event.merchantInfo.hasData) {
        add(const GetMerchantInformationEvent());
      }
    });

    on<GetMerchantInformationEvent>((event, emit) async {
      if (event.showLoading) emit(const GetMerchantInformationLoadingState());
      Either<Failure, MerchantInformation> result = await _merchantRepository.getMerchantInformation();

      result.fold((left) {}, (right) {
        merchantInformation = right;
        emit(const GetMerchantInformationSuccessState());
      });
    });

    on<DeleteMerchantLogo>((event, emit) async {
      if (event.imageUrl == null) return;
      emit(const DeleteMerchantLogoState(isLoading: true));
      final Either<Failure, bool> result = await _merchantRepository.deleteLogo(event.imageUrl!);

      result.fold((left) => emit(DeleteMerchantLogoState(errorMsg: left.errorMessage)), (right) {
        add(const GetMerchantInformationEvent(showLoading: true));
        emit(const DeleteMerchantLogoState(isSuccess: true));
      });
    });

    on<UpdateMerchantInfoEvent>((event, emit) async {
      emit(const UpdateMerchantInfoState(isLoading: true));

      Either<Failure, bool> result = await _merchantRepository.updateMerchantInformation(
        address: event.branchAddress,
        facebook: event.facebook,
        instagram: event.instagram,
        twitter: event.twitter,
        firstPhoneNumber: event.firstPhoneNumber,
        email: event.email,
      );

      result.fold((left) {
        emit(UpdateMerchantInfoState(errorMsg: left.errorMessage.toString()));
      }, (right) {
        add(const GetMerchantInformationEvent(showLoading: false));
        emit(const UpdateMerchantInfoState(isSuccess: true));
      });
    });

    on<UpdateMerchantLogoEvent>((event, emit) async {
      emit(const UpdateMerchantInfoState(isLoading: true));

      Either<Failure, bool> result = await _merchantRepository.updateMerchantLogo(
          logoTypeId: event.imgKey,
          filename: event.image.name,
          fileMime: event.image.platformMimeType ?? '',
          byte: await event.image.readAsBytes());

      result.fold((left) {
        emit(UpdateMerchantInfoState(errorMsg: left.errorMessage.toString()));
      }, (right) {
        add(const GetMerchantInformationEvent(showLoading: false));
        emit(const UpdateMerchantInfoState(isSuccess: true));
      });
    });
  }
}
