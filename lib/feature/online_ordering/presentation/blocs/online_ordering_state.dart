part of 'online_ordering_cubit.dart';

sealed class OnlineOrderingState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const OnlineOrderingState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isSuccess, isLoading, errorMessage];
}

final class OnlineOrderingInitial extends OnlineOrderingState {}

final class GetOnlineOrderingSettingsState extends OnlineOrderingState {
  final OnlineOrderingSettings? settings;

  const GetOnlineOrderingSettingsState({super.isLoading, super.errorMessage, this.settings});
}

// final class UpdateOnlineOrderingSettingsState extends OnlineOrderingState {
//   const UpdateOnlineOrderingSettingsState({super.isLoading, super.errorMessage, super.isSuccess});
// }

// final class UpdateMessagesSettingsState extends OnlineOrderingState {
//   const UpdateMessagesSettingsState({super.isLoading, super.errorMessage, super.isSuccess});
// }

final class GetMessagesSettingsState extends OnlineOrderingState {
  final List<MessageSettings>? messages;

  const GetMessagesSettingsState({super.isLoading, super.errorMessage, this.messages});
}
final class LoadingUpdateInfoState extends OnlineOrderingState {
  const LoadingUpdateInfoState({super.isLoading, super.errorMessage, super.isSuccess});
}