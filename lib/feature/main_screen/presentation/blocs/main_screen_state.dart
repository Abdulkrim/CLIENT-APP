part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object?> get props => [];
}

class MainScreenInitial extends MainScreenState {}

class ConnectionStatusChangedEvent extends MainScreenState {}

/*class UserSubscriptionStatusesState extends MainScreenState {
  final String? msg;
  final bool shouldLogout;

  const UserSubscriptionStatusesState(this.msg, {this.shouldLogout = false});

  @override
  List<Object?> get props => [msg, shouldLogout];
}*/

class LoggedInUserInfoSuccessState extends MainScreenState {
  final MerchantInfo merchantInfo;

  const LoggedInUserInfoSuccessState(this.merchantInfo);

  @override
  List<Object> get props => [merchantInfo];
}

/*class BodyContentChangeState extends MainScreenState {
  final String selectedPageKey;

  const BodyContentChangeState(this.selectedPageKey);

  @override
  List<Object> get props => [selectedPageKey];
}*/

class MerchantInfoSelectionChangedState extends MainScreenState {
  final MerchantInfo merchantInfo;

  const MerchantInfoSelectionChangedState(this.merchantInfo);

  @override
  List<Object> get props => [merchantInfo];
}

class MerchantInfoDataLoadingState extends MainScreenState {
  const MerchantInfoDataLoadingState();
}

class RemoveGuideItemState extends MainScreenState {
  const RemoveGuideItemState();
}

class BranchGeneralInfoState extends MainScreenState {
  final bool isLoading;
  final bool isSuccess;
  const BranchGeneralInfoState({this.isSuccess= false , this.isLoading = false});


  @override
  List<Object> get props => [isLoading , isSuccess];
}

class MerchantInfoDataSuccessState extends MainScreenState {
  final List<MerchantInfo> merchantInfo;

  const MerchantInfoDataSuccessState(this.merchantInfo);

  @override
  List<Object> get props => [merchantInfo];
}

class GetMeasureUnitsSuccess extends MainScreenState {
  final List<MeasureUnit> measureUnits;

  const GetMeasureUnitsSuccess(this.measureUnits);
}
