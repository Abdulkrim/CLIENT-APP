part of 'product_reports_cubit.dart';

sealed class ProductReportsState extends Equatable {
  const ProductReportsState();

  @override
  List<Object?> get props => [];
}

final class ProductReportsInitial extends ProductReportsState {}

final class GetProductsLoadingState extends ProductReportsState {
  const GetProductsLoadingState();
}

final class GetProductsSuccessState extends ProductReportsState {
  final int page;
  final bool hasMore;
  const GetProductsSuccessState(this.page, this.hasMore);

  @override
  List<Object> get props => [page, hasMore];
}

final class GetProductsFailedState extends ProductReportsState {
  const GetProductsFailedState();
}

final class GetDownloadLinkLoadingState extends ProductReportsState {
  const GetDownloadLinkLoadingState();
}

final class GetDownloadLinkState extends ProductReportsState {
  final String? link;
  final String? errorMsg;
  const GetDownloadLinkState({this.link, this.errorMsg});

  @override
  List<Object?> get props => [link, errorMsg];
}
