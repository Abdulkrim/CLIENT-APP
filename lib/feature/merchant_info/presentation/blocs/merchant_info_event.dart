part of 'merchant_info_bloc.dart';

abstract class MerchantInfoEvent extends Equatable {
  const MerchantInfoEvent();

  @override
  List<Object?> get props => [];
}

class GetMerchantInformationEvent extends MerchantInfoEvent {
  final bool showLoading;
  const GetMerchantInformationEvent({this.showLoading = true});
}

class UpdateMerchantInfoEvent extends MerchantInfoEvent {
  final String branchAddress;
  final String firstPhoneNumber;
  final String email;
  final String facebook;
  final String instagram;
  final String twitter;

  const UpdateMerchantInfoEvent(
      {required this.branchAddress,
      required this.firstPhoneNumber,
      required this.email,
      required this.facebook,
      required this.instagram,
      required this.twitter});
}

class UpdateMerchantLogoEvent extends MerchantInfoEvent {
  final XFile image;
  final int imgKey;
  const UpdateMerchantLogoEvent({required this.image, required this.imgKey});
}


class DeleteMerchantLogo extends MerchantInfoEvent {
  final String? imageUrl;
  const DeleteMerchantLogo(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}
