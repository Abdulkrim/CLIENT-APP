part of 'sub_category_bloc.dart';

sealed class SubCategoryEvent extends Equatable {
  const SubCategoryEvent();

  @override
  List<Object?> get props => [];
}

class SearchSubCategoriesEvent extends SubCategoryEvent {
  final String searchText;
  const SearchSubCategoriesEvent(this.searchText);
  @override
  List<Object> get props => [searchText];
}

class GetSubCategoriesEvent extends SubCategoryEvent {
  final int mainCategoryId;
  const GetSubCategoriesEvent(this.mainCategoryId);
  @override
  List<Object> get props => [mainCategoryId];
}

class DeleteSubCategoryRequestEvent extends SubCategoryEvent {
  final int subCategoryId;
  const DeleteSubCategoryRequestEvent(this.subCategoryId);
  @override
  List<Object> get props => [subCategoryId];
}

class EditSubCategoryRequestEvent extends SubCategoryEvent {
  final int? mainCategoryId;
  final int subCategoryId;
  final String categoryFrName;
  final String categoryTrName;
  final String categoryArName;
  final String categoryEnName;
  final XFile? categoryImage;
  final bool isActive;
  final List<String> visibleApplications;

  const EditSubCategoryRequestEvent({
    this.mainCategoryId,
    required this.subCategoryId,
    required this.categoryFrName,
    required this.categoryTrName,
    required this.categoryArName,
    required this.categoryEnName,
    required this.isActive,
    required this.categoryImage,
    required this.visibleApplications,
  });

  @override
  List<Object?> get props => [
        subCategoryId,
        mainCategoryId,
        categoryFrName,
        categoryTrName,
        categoryArName,
        categoryEnName,
        isActive,
        categoryImage,
        visibleApplications
      ];
}

class AddSubCategoryRequestEvent extends SubCategoryEvent {
  final int selectedMainCatId;
  final String categoryFrName;
  final String categoryTrName;
  final String categoryArName;
  final String categoryEnName;
  final XFile? categoryImage;
  final bool isActive;
  final List<String> visibleApplications;

  const AddSubCategoryRequestEvent({
    required this.selectedMainCatId,
    required this.isActive,
    required this.categoryFrName,
    required this.categoryTrName,
    required this.categoryArName,
    required this.categoryEnName,
    required this.visibleApplications,
    required this.categoryImage,
  });

  @override
  List<Object?> get props => [
        isActive,
        categoryFrName,
        categoryTrName,
        categoryArName,
        categoryEnName,
        visibleApplications,
        categoryImage,
      ];
}

class ClearSearchResultEvent extends SubCategoryEvent {
  const ClearSearchResultEvent();
}
