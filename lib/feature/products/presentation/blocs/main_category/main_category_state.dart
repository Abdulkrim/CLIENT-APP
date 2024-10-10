part of 'main_category_bloc.dart';

sealed class MainCategoryState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMsg;
  final String msg;

  const MainCategoryState(
      {this.isLoading = false, this.isSuccess = false, this.errorMsg = '', this.msg = ''});
  @override
  List<Object> get props => [isLoading, isSuccess, errorMsg, msg];
}

final class MainCategoryInitial extends MainCategoryState {}

final class GetMainCategoriesState extends MainCategoryState {
  const GetMainCategoriesState({super.isLoading, super.isSuccess});
  @override
  List<Object> get props => [isLoading, isSuccess];
}

final class DeleteMainCategoryState extends MainCategoryState {
  const DeleteMainCategoryState({super.isLoading, super.isSuccess, super.errorMsg});
}

final class EditMainCategoriesState extends MainCategoryState {
  final bool  isAdded ;
  const EditMainCategoriesState({super.isLoading, this.isAdded = false, super.errorMsg, super.msg});

  @override
  List<Object> get props => [isAdded , isLoading , errorMsg , msg];
}
