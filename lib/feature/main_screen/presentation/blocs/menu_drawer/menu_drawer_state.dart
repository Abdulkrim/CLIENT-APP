part of 'menu_drawer_cubit.dart';

sealed class MenuDrawerState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const MenuDrawerState({this.isSuccess = false, this.isLoading = false});

  @override
  List<Object?> get props => [isLoading, isSuccess];
}

final class MenuDrawerInitial extends MenuDrawerState {}

final class RemovedMenuItemState extends MenuDrawerState {
  const RemovedMenuItemState({super.isLoading, super.isSuccess});
}
final class ChangeLanguageState extends MenuDrawerState {

  final String newLang;
  const ChangeLanguageState(this. newLang);

  @override
  List<Object> get props => [newLang];
}

final class BodyContentChangeState extends MenuDrawerState {
  final String currentPageKey;

  const BodyContentChangeState(this.currentPageKey);

  @override
  List<Object> get props => [currentPageKey];
}

final class UserSubscriptionStatusesState extends MenuDrawerState {
  final String? msg;
  final bool shouldLogout;

  const UserSubscriptionStatusesState(this.msg, {this.shouldLogout = false});

  @override
  List<Object?> get props => [msg, shouldLogout];
}
