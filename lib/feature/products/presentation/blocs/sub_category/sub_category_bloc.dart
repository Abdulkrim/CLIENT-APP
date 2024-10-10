import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/data/repository/category_repository.dart';

import '../../../../../core/bloc_base_state/base_bloc.dart';
import '../../../../../core/utils/failure.dart';

part 'sub_category_event.dart';

part 'sub_category_state.dart';

@injectable
class SubCategoryBloc extends BaseBloc<SubCategoryEvent, SubCategoryState> {
  final ICategoryRepository _categoryRepository;

  List<SubCategory> subCategories = [];

  List<SubCategory> searchResult = [];
  bool isSearchMode = false;
  final searchController = TextEditingController();

  SubCategoryBloc(this._categoryRepository) : super(SubCategoryInitial()) {
    on<GetSubCategoriesEvent>(_getSubCategories);
    on<EditSubCategoryRequestEvent>(_editSubCategory);
    on<AddSubCategoryRequestEvent>(_addSubCategory);
    on<SearchSubCategoriesEvent>(_searchSubCategories);

    on<ClearSearchResultEvent>((event, emit) {
      searchResult = [];
      isSearchMode = false;
      searchController.clear();
      emit(ClearSearchResultState());
    });
    on<DeleteSubCategoryRequestEvent>(_deleteSubCategory);
  }

  void _deleteSubCategory(event, emit) async {
    emit(const DeleteSubCategoryState(isLoading: true));

    final result = await _categoryRepository.deleteSubCategory(subCategoryId: event.subCategoryId);
    result.fold((left) => emit(DeleteSubCategoryState(errorMsg: left.errorMessage)), (right) {
      subCategories.removeWhere((element) => element.subCategoryId == event.subCategoryId);

      emit(const DeleteSubCategoryState(isSuccess: true));
      // add(  GetSubCategoriesEvent(event.mainCategoryId));
    });
  }

  void _addSubCategory(AddSubCategoryRequestEvent event, emit) async {
    emit(const EditSubCategoriesState(isLoading: true));
    Either<Failure, (int id, String image)> result = await _categoryRepository.addSubCategory(
      mainCategoryId: event.selectedMainCatId,
      categoryFrName: event.categoryFrName,
      categoryTrName: event.categoryTrName,
      categoryArName: event.categoryArName,
      categoryEnName: event.categoryEnName,
      categoryImage: event.categoryImage,
      visibleApplications: event.visibleApplications,
      isActive: event.isActive,
    );

    result.fold((left) {
      emit(EditSubCategoriesState(errorMsg: left.errorMessage ?? ''));
    }, (right) {
      subCategories = [
        ...subCategories,
        SubCategory(
          subCategoryId: right.$1,
          categoryId: event.selectedMainCatId,
          categoryNameEN: event.categoryEnName,
          categoryNameFR: event.categoryFrName,
          categoryNameTR: event.categoryTrName,
          categoryNameAR: event.categoryArName,
          visibleApplications: event.visibleApplications,
          isActive: event.isActive,
          products: const [],
          imageUrl: right.$2,
        )
      ];
      emit(const EditSubCategoriesState(msg: "Sub Category Added successfully!",isAdded: true));
    });
  }

  void _searchSubCategories(SearchSubCategoriesEvent event, emit) async {
    isSearchMode = true;
    emit(const GetSubCategoriesState(isLoading: true));

    final Either<Failure, List<SubCategory>> result =
        await _categoryRepository.searchSubCategories(event.searchText);
    result.fold((left) => {}, (right) {
      searchResult = right;
      emit(const GetSubCategoriesState(isSuccess: false));
    });
  }

  void _editSubCategory(EditSubCategoryRequestEvent event, emit) async {
    emit(const EditSubCategoriesState(isLoading: true));
    Either<Failure, String> result = await _categoryRepository.editSubCategory(
      categoryFrName: event.categoryFrName,
      categoryTrName: event.categoryTrName,
      categoryArName: event.categoryArName,
      categoryEnName: event.categoryEnName,
      categoryImage: event.categoryImage,
      visibleApplications: event.visibleApplications,
      categoryId: event.subCategoryId,
      mainCategoryId: event.mainCategoryId,
      isActive: event.isActive,
    );

    result.fold((left) {
      emit(EditSubCategoriesState(errorMsg: left.errorMessage ?? ''));
    }, (right) {
      if (subCategories
              .firstWhereOrNull((element) => element.subCategoryId == event.subCategoryId)!
              .categoryId !=
          event.mainCategoryId) {
        subCategories.removeWhere(
          (element) => element.subCategoryId == event.subCategoryId,
        );
      } else {
        if (searchResult.isNotEmpty) {
          searchResult.firstWhere((element) => element.subCategoryId == event.subCategoryId).update(
                nameEn: event.categoryEnName,
                nameFr: event.categoryFrName,
                nameTr: event.categoryTrName,
                nameAr: event.categoryArName,
                changeActive: event.isActive,
                image: right,
              );
        }
        subCategories.firstWhereOrNull((element) => element.subCategoryId == event.subCategoryId)?.update(
              nameEn: event.categoryEnName,
              nameFr: event.categoryFrName,
              nameTr: event.categoryTrName,
              nameAr: event.categoryArName,
              changeActive: event.isActive,
              image: right,
            );
      }

      if (subCategories.isNotEmpty) add(GetSubCategoriesEvent(subCategories.first.categoryId));

      emit(const EditSubCategoriesState(msg: "Sub Category edited successfully!"));
      // if(searchController.text.isNotEmpty) { add(const ClearSearchResultEvent());}
    });
  }

  void _getSubCategories(event, emit) async {

    isSearchMode = false;
    emit(const GetSubCategoriesState(isLoading: true));

    final Either<Failure, List<SubCategory>> result =
        await _categoryRepository.getAllSubCategories(event.mainCategoryId);
    result.fold((left) {}, (right) {
      subCategories = right;
      emit(const GetSubCategoriesState(isSuccess: true));
    });
  }
}
