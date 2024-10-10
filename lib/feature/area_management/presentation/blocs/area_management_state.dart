part of 'area_management_cubit.dart';

sealed class AreaManagementState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const AreaManagementState({this.isLoading = false, this.isSuccess = false, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}

final class AreaManagementInitial extends AreaManagementState {}

final class GetAreasState extends AreaManagementState {
  const GetAreasState({super.isLoading , super.isSuccess , super.errorMessage});
}
final class GetCityAreasState extends AreaManagementState {
  const GetCityAreasState({super.isLoading , super.isSuccess , super.errorMessage});
}
final class CreateAreaState extends AreaManagementState {
  const CreateAreaState({super.isLoading , super.isSuccess , super.errorMessage});
}

final class EditAreaState extends AreaManagementState {
  const EditAreaState({super.isLoading , super.isSuccess , super.errorMessage});
}

final class DeleteAreaState extends AreaManagementState {
  const DeleteAreaState({super.isLoading , super.isSuccess , super.errorMessage});
}
