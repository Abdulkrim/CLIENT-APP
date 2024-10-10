part of 'region_cubit.dart';


sealed class RegionState extends Equatable{

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const RegionState({this.isLoading = false, this.isSuccess = false, this.errorMessage, this.successMessage });

  @override
  List<Object?> get props => [isLoading, isSuccess,successMessage, errorMessage];

}

final class RegionInitial extends RegionState {}

final class GetCountriesState extends RegionState {
  const GetCountriesState({super.isLoading , super.isSuccess , super.errorMessage});
}


final class GetCitiesState extends RegionState {
  const GetCitiesState({super.isLoading , super.isSuccess , super.errorMessage});
}
