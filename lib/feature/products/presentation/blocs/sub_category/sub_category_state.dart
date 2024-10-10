part of 'sub_category_bloc.dart';

sealed class SubCategoryState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMsg;
  final String msg;

  const SubCategoryState({this.isLoading = false, this.isSuccess = false, this.errorMsg = '', this.msg = ''});
  @override
  List<Object> get props => [isLoading, isSuccess, errorMsg, msg];
}

final class SubCategoryInitial extends SubCategoryState {}

final class ClearSearchResultState extends SubCategoryState {}

final class GetSubCategoriesState extends SubCategoryState {
  const GetSubCategoriesState({super.isLoading, super.isSuccess});
}

final class EditSubCategoriesState extends SubCategoryState {
  final bool isAdded;
  const EditSubCategoriesState({super.isLoading, this.isAdded = false, super.errorMsg, super.msg});


  @override
  List<Object> get props => [isAdded ,isLoading , errorMsg, msg];
}


final class DeleteSubCategoryState extends SubCategoryState {
  const DeleteSubCategoryState({super.isLoading, super.isSuccess, super.errorMsg});
}
