part of 'merchant_info_bloc.dart';

abstract class MerchantInfoState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMsg;

  const MerchantInfoState({this.isLoading = false, this.errorMsg = '', this.isSuccess = false});

  @override
  List<Object> get props => [isLoading, isSuccess, errorMsg];
}

class MerchantInfoInitial extends MerchantInfoState {}

class GetMerchantInformationLoadingState extends MerchantInfoState {
  const GetMerchantInformationLoadingState();
}

class GetMerchantInformationSuccessState extends MerchantInfoState {
  const GetMerchantInformationSuccessState();
}

class DeleteMerchantLogoState extends MerchantInfoState {
  const DeleteMerchantLogoState({super.isLoading, super.errorMsg, super.isSuccess});
}

class UpdateMerchantInfoState extends MerchantInfoState {
  const UpdateMerchantInfoState({super.isLoading, super.errorMsg, super.isSuccess});

}
