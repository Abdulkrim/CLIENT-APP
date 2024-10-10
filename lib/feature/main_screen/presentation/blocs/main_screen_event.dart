part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();

  @override
  List<Object?> get props => [];
}

class ConfigureDashboardBasedOnUserLevelEvent extends MainScreenEvent {
  const ConfigureDashboardBasedOnUserLevelEvent();
}
class UserLogOutEvent extends MainScreenEvent {
  const UserLogOutEvent();
}

class MerchantInfoRequestEvent extends MainScreenEvent {
  const MerchantInfoRequestEvent();
}

class MerchantSelectedChangedEvent extends MainScreenEvent {
  final MerchantInfo merchantInfo;

  const MerchantSelectedChangedEvent(this.merchantInfo);

  @override
  List<Object> get props => [merchantInfo];
}

class ManualBranchSelectionEvent extends MainScreenEvent {
  final bool? isReset;
  final bool? forceItemSelection;

  const ManualBranchSelectionEvent({this.isReset, this.forceItemSelection});

  @override
  List<Object?> get props => [isReset, forceItemSelection];
}

class GetGeneralBranchInfoEvent extends MainScreenEvent {
  const GetGeneralBranchInfoEvent();
}

class GetMeasureUnits extends MainScreenEvent {
  const GetMeasureUnits();
}

class InitalEventsCall extends MainScreenEvent {
  const InitalEventsCall();
}
