part of 'main_category_bloc.dart';

sealed class MainCategoryEvent extends Equatable {
  const MainCategoryEvent();

  @override
  List<Object?> get props => [];
}

class GetMainCategoriesEvent extends MainCategoryEvent {
  const GetMainCategoriesEvent();

  @override
  List<Object> get props => [];
}

class SearchMainCategoriesEvent extends MainCategoryEvent {
  final String searchText;
  const SearchMainCategoriesEvent(this.searchText);
  @override
  List<Object> get props => [searchText];
}

final class DeleteMainCategoryRequestEvent extends MainCategoryEvent {
  final int mainCategoryId;
  const DeleteMainCategoryRequestEvent(this.mainCategoryId);

  @override
  List<Object> get props => [mainCategoryId];
}

class EditMainCategoryRequestEvent extends MainCategoryEvent {
  final int categoryId;
  final String categoryFrName;
  final String categoryTrName;
  final String categoryArName;
  final String categoryEnName;
  final XFile? categoryImage;
  final bool isActive;
  final List<String> visibleApplications;

  const EditMainCategoryRequestEvent({
    required this.categoryId,
    required this.isActive,
    required this.categoryFrName,
    required this.categoryTrName,
    required this.categoryArName,
    required this.categoryEnName,
    required this.categoryImage,
    required this.visibleApplications,
  });

  @override
  List<Object?> get props => [
        isActive,
        categoryId,
        categoryFrName,
        categoryTrName,
        categoryArName,
        categoryEnName,
        categoryImage,
        visibleApplications
      ];
}

class AddMainCategoryRequestEvent extends MainCategoryEvent {
  final String categoryFrName;
  final String categoryTrName;
  final String categoryArName;
  final String categoryEnName;
  final List<String> visibleApplications;
  final XFile? categoryImage;
  final bool isActive;

  const AddMainCategoryRequestEvent({
    required this.categoryFrName,
    required this.categoryTrName,
    required this.categoryArName,
    required this.categoryEnName,
    required this.visibleApplications,
    required this.categoryImage,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        categoryFrName,
        categoryTrName,
        categoryArName,
        categoryEnName,
        categoryImage,
        isActive,
        visibleApplications
      ];
}
