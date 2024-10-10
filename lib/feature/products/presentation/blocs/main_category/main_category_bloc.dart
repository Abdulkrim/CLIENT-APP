import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:merchant_dashboard/core/bloc_base_state/base_bloc.dart';
import 'package:merchant_dashboard/feature/products/data/repository/category_repository.dart';

import '../../../../../core/utils/failure.dart';
import '../../../../../injection.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../data/models/entity/products.dart';

part 'main_category_event.dart';

part 'main_category_state.dart';

// todo: implement lazyloading package
@injectable
class MainCategoryBloc extends BaseBloc<MainCategoryEvent, MainCategoryState> {
  final ICategoryRepository _categoryRepository;

  List<ProductsCategory> mainCategories = [];
  final searchController = TextEditingController();

  MainCategoryBloc(this._categoryRepository) : super(MainCategoryInitial()) {
    getIt<MainScreenBloc>().stream.listen((state) {
      if (state is MerchantInfoSelectionChangedState && state.merchantInfo.hasData) {
        add(const GetMainCategoriesEvent());
      }
    });

    on<GetMainCategoriesEvent>(_getMainCategories);
    on<SearchMainCategoriesEvent>(_serachMainCategories);
    on<AddMainCategoryRequestEvent>(_addMainCategory);
    on<EditMainCategoryRequestEvent>(_editMainCategory);
    on<DeleteMainCategoryRequestEvent>(_deleteMainCategory);
  }

  void _deleteMainCategory(event, emit) async {
    emit(const DeleteMainCategoryState(isLoading: true));

    final result = await _categoryRepository.deleteMainCategory(categoryId: event.mainCategoryId);
    result.fold((left) => emit(DeleteMainCategoryState(errorMsg: left.errorMessage)), (right) {
      emit(const DeleteMainCategoryState(isSuccess: true));
      add(const GetMainCategoriesEvent());
    });
  }

  void _getMainCategories(event, emit) async {
    emit(const GetMainCategoriesState(isLoading: true));

    final Either<Failure, List<ProductsCategory>> result = await _categoryRepository.getMainCategories(); // todo: pagination
    result.fold((left) => {}, (right) {
      mainCategories = right;
      emit(const GetMainCategoriesState(isSuccess: false));
    });
  }

  void _serachMainCategories(event, emit) async {
    emit(const GetMainCategoriesState(isLoading: true));

    final Either<Failure, List<ProductsCategory>> result = await _categoryRepository.serachMainCategories(event.searchText);
    result.fold((left) => {}, (right) {
      mainCategories = right;
      emit(const GetMainCategoriesState(isSuccess: false));
    });
  }

  void _addMainCategory(event, emit) async {
    emit(const EditMainCategoriesState(isLoading: true));

    Either<Failure, (int id, String image)> result = await _categoryRepository.addMainCategory(
      categoryFrName: event.categoryFrName,
      categoryTrName: event.categoryTrName,
      categoryArName: event.categoryArName,
      categoryEnName: event.categoryEnName,
      categoryImage: event.categoryImage,
      visibleApplications: event.visibleApplications,
      isActive: event.isActive,
    );

    result.fold((left) {
      emit(EditMainCategoriesState(errorMsg: left.errorMessage));
    }, (right) {
      mainCategories = [
        ...mainCategories,
        ProductsCategory(
            categoryId: right.$1,
            categoryNameEN: event.categoryEnName,
            categoryNameFR: event.categoryFrName,
            categoryNameTR: event.categoryTrName,
            categoryNameAR: event.categoryArName,
            isActive: event.isActive,
            visibleApplications: event.visibleApplications,
            subCategories: const [],
            imageUrl: right.$2)
      ];

      emit(const EditMainCategoriesState(msg: "Category added successfully" , isAdded: true));
      searchController.clear();
    });
  }

  void _editMainCategory(event, emit) async {
    emit(const EditMainCategoriesState(isLoading: true));
    Either<Failure, String> result = await _categoryRepository.editMainCategory(
      categoryFrName: event.categoryFrName,
      categoryTrName: event.categoryTrName,
      categoryArName: event.categoryArName,
      categoryEnName: event.categoryEnName,
      categoryImage: event.categoryImage,
      visibleApplications: event.visibleApplications,
      categoryId: event.categoryId,
      isActive: event.isActive,
    );

    result.fold((left) {
      emit(EditMainCategoriesState(errorMsg: left.errorMessage));
    }, (right) {
      emit(const EditMainCategoriesState(msg: "Category edited successfully" ));

      add(const GetMainCategoriesEvent());
      searchController.clear();
    });
  }
}
