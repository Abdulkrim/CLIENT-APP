part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMsg;
  final String msg;

  const ProductsState({this.isLoading = false, this.isSuccess = false, this.errorMsg = '', this.msg = ''});
  @override
  List<Object> get props => [isLoading, isSuccess, errorMsg, msg];
}

class ProductsInitial extends ProductsState {}

class UpdateIsListViewState extends ProductsState {
  final bool isListView;

  const UpdateIsListViewState(this.isListView);

  @override
  List<Object> get props => [isListView];
}

class EditProductStates extends ProductsState {
  const EditProductStates({super.isLoading, super.msg, super.errorMsg});
}

class GetOffersSuccessState extends ProductsState {
  const GetOffersSuccessState();
}

class GetItemTypesSuccessState extends ProductsState {
  const GetItemTypesSuccessState();
}

class ClearProductSearchResultState extends ProductsState {
  const ClearProductSearchResultState();
}

class GetProductsState extends ProductsState {
  final bool isEmpty;
  const GetProductsState({super.isLoading, super.isSuccess, super.errorMsg, this.isEmpty = false});
}

class SearchProductsState extends ProductsState {
  final bool isEmpty;
  const SearchProductsState({super.isLoading, super.isSuccess, super.errorMsg, this.isEmpty = false});
}


class GetAddOnsStates extends ProductsState {
  const GetAddOnsStates({super.isLoading, super.isSuccess, super.errorMsg });
}

class GetItemSuggestionStates extends ProductsState {
  const GetItemSuggestionStates({super.isLoading, super.isSuccess, super.errorMsg });
}


class GetItemSuggestionsImageStates extends ProductsState {
  const GetItemSuggestionsImageStates({super.isLoading, super.isSuccess, super.errorMsg });
}
