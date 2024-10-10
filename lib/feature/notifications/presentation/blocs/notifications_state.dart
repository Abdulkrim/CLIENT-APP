part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const NotificationsState({this.isLoading = false, this.isSuccess = false, this.errorMessage, this.successMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, successMessage, errorMessage];
}

final class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

class GetAllNotificationEventsDataSuccessState extends NotificationsState {
  const GetAllNotificationEventsDataSuccessState();

  @override
  List<Object?> get props => [];
}

class GetAllNotificationTypesDataSuccessState extends NotificationsState {
  const GetAllNotificationTypesDataSuccessState();

  @override
  List<Object?> get props => [];
}

class GetNotificationsStates extends NotificationsState {
  const GetNotificationsStates({super.isLoading, super.isSuccess, super.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

class UpdateNotificationSettingsStates extends NotificationsState {
  const UpdateNotificationSettingsStates({super.isLoading, super.isSuccess, super.errorMessage});
}

class GetNotificationSettingsStates extends NotificationsState {
  const GetNotificationSettingsStates({super.isLoading, super.isSuccess, super.errorMessage});
}

class AddNotificationsStates extends NotificationsState {
  const AddNotificationsStates({super.isLoading, super.successMessage, super.errorMessage});

  @override
  List<Object?> get props => [isLoading, successMessage, errorMessage];
}

class DeleteNotificationsStates extends NotificationsState {
  const DeleteNotificationsStates({super.isLoading, super.isSuccess, super.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

class GetNotificationKeyWordsStates extends NotificationsState {
  const GetNotificationKeyWordsStates({super.isLoading, super.isSuccess, super.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
