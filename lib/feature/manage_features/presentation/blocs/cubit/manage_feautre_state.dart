part of 'manage_feautre_cubit.dart';

sealed class ManageFeautreState extends Equatable {
  final bool isLoading;
  final bool isSuccessed;
  final String errorMessage;

  const ManageFeautreState({this.isLoading = false, this.errorMessage = '', this.isSuccessed = false});

  @override
  List<Object> get props => [isLoading, errorMessage, isSuccessed];
}

final class ManageFeautreInitial extends ManageFeautreState {}

final class GetUserPlanFeaturesState extends ManageFeautreState {
  const GetUserPlanFeaturesState({super.isLoading, super.isSuccessed, super.errorMessage});
}
