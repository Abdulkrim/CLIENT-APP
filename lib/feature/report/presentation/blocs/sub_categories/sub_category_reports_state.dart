part of 'sub_category_reports_cubit.dart';

sealed class SubCategoryReportsState extends Equatable {
  const SubCategoryReportsState();

  @override
  List<Object> get props => [];
}

final class SubCategoryReportsInitial extends SubCategoryReportsState {}

final class GetSubCategoriesLoadingState extends SubCategoryReportsState {
  const GetSubCategoriesLoadingState();
}

final class GetSubCategoriesSuccessState extends SubCategoryReportsState {
  final int page;
  final bool hasMore;
  const GetSubCategoriesSuccessState(this.page, this.hasMore);

  @override
  List<Object> get props => [page, hasMore];
}

final class GetSubCategoriesFailedState extends SubCategoryReportsState {
  const GetSubCategoriesFailedState();
}

final class GetDownloadLinkLoadingState extends SubCategoryReportsState {
  const GetDownloadLinkLoadingState();
}

final class GetDownloadLinkState extends SubCategoryReportsState {
  final String? link;
  final String? errorMsg;
  const GetDownloadLinkState({
    this.link,
    this.errorMsg,
  });
}
