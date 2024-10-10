import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/main_category/main_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/sub_category/sub_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/image_selection_section_widget.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/two_options_section_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../../theme/theme_data.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/item_hint_textfield_widget.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/scrollable_widget.dart';
import '../../../data/models/entity/apps.dart';
import '../../../data/models/entity/products.dart';
import 'hidden_apps_section_widget.dart';

class CategoryDetailsDialog extends StatefulWidget {
  const CategoryDetailsDialog({
    super.key,
    this.mainCatId,
    this.subCatId,
    bool? isSub,
    this.catEnName,
    this.catFrName,
    this.catTrName,
    this.catArName,
    this.catLogo,
    this.visibleApplications,
    this.catIsActive = true,
    this.width,
    this.height,
  })  : _isSub = isSub ?? (subCatId != null),
        _isEditMode = (mainCatId != null || subCatId != null) && catEnName != null,
        assert(subCatId != null ? mainCatId != null : true);

  final double? width;
  final double? height;
  final int? mainCatId;
  final int? subCatId;
  final bool _isSub;
  final bool _isEditMode;
  final String? catEnName;
  final String? catFrName;
  final String? catTrName;
  final String? catArName;
  final String? catLogo;
  final List<String>? visibleApplications;
  final bool catIsActive;
/*   final Function(int? mainCategoryId, String enName, String frName, String trName, String arName,
      XFile? image, bool isActive) onSaveTap; */

  @override
  State<CategoryDetailsDialog> createState() => _CategoryDetailsDialogState();
}

class _CategoryDetailsDialogState extends State<CategoryDetailsDialog> with ImagesConditions {
  late final _categoryEnNameController = TextEditingController(text: widget.catEnName ?? '');

  late final _categoryFrNameController = TextEditingController(text: widget.catFrName ?? '');

  late final _categoryArNameController = TextEditingController(text: widget.catArName ?? '');

  late final _categoryTrNameController = TextEditingController(text: widget.catTrName ?? '');

  late bool _isActive = widget.catIsActive;

  late List<String> _selectedVisibleApps = widget.visibleApplications ??
      [
        ...Apps.values.map(
          (e) => e.name,
        )
      ];

  XFile? selectedImage;

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  List<ProductsCategory> _mainCategories = <ProductsCategory>[];
  ProductsCategory? _selectedMainCategory;

  @override
  void initState() {
    super.initState();

    if(widget._isSub){
      _mainCategories = context.read<MainCategoryBloc>().mainCategories;
      _selectedMainCategory =
          _mainCategories.firstWhereOrNull((element) => element.categoryId == widget.mainCatId) ?? _mainCategories.first;



    }


  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      width: widget.width ?? (!kIsWeb ? null : 450),
      height: widget.height ?? (!kIsWeb ? null : 500),
      title:
          '${(widget._isEditMode ? S.current.edit : S.current.add)} ${widget._isSub ? S.current.subcategory : S.current.category}',
      child: MultiBlocListener(
        listeners: [
          BlocListener<MainCategoryBloc, MainCategoryState>(
            listener: (context, state) {
              if (state is EditMainCategoriesState) {
                switch (state) {
                  case EditMainCategoriesState() when state.isLoading:
                    setState(() => _isLoading = true);
                  case EditMainCategoriesState() when state.msg.isNotEmpty:
                    Get.back();
                    setState(() => _isLoading = false);
                    context.showCustomeAlert(state.msg, SnackBarType.success);
                  case EditMainCategoriesState() when state.errorMsg.isNotEmpty:
                    setState(() => _isLoading = false);
                    context.showCustomeAlert(state.errorMsg, SnackBarType.error);
                }
              }
              if (state is DeleteMainCategoryState) {
                // todo: refactor
                if (state.isLoading) setState(() => _isLoading = true);
                if (state.errorMsg.isNotEmpty) {
                  setState(() => _isLoading = false);
                  context.showCustomeAlert(state.errorMsg, SnackBarType.error);
                }
                if (state.isSuccess) {
                  Get.back();
                  context.showCustomeAlert(S.current.mainCategoryDeletedSuccessfully, SnackBarType.error);
                }
              }
            },
          ),
          BlocListener<SubCategoryBloc, SubCategoryState>(
            listener: (context, state) {
              if (state is EditSubCategoriesState) {
                switch (state) {
                  case EditSubCategoriesState() when state.isLoading:
                    setState(() => _isLoading = true);
                  case EditSubCategoriesState() when state.msg.isNotEmpty:
                    Get.back();
                    setState(() => _isLoading = false);
                    context.showCustomeAlert(state.msg, SnackBarType.success);
                  case EditSubCategoriesState() when state.errorMsg.isNotEmpty:
                    setState(() => _isLoading = false);
                    context.showCustomeAlert(state.errorMsg, SnackBarType.error);
                }
              }

              if (state is DeleteSubCategoryState) {
                // todo: refactor
                if (state.isLoading) setState(() => _isLoading = true);
                if (state.errorMsg.isNotEmpty) {
                  setState(() => _isLoading = false);
                  context.showCustomeAlert(state.errorMsg, SnackBarType.error);
                }
                if (state.isSuccess) {
                  Get.back();
                  context.showCustomeAlert(S.current.subCategoryDeletedSuccessfully, SnackBarType.error);
                }
              }
            },
          ),
        ],
        child: ScrollableWidget(
          scrollViewPadding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                    visible: widget._isSub,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(S.current.category,
                            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                        context.sizedBoxHeightMicro,
                        DropdownSearch<ProductsCategory>(
                          filterFn: (cat, filter) =>
                              cat.categoryName.toLowerCase().contains(filter.toLowerCase()),
                          items: _mainCategories,
                          selectedItem: _selectedMainCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedMainCategory = value;

                              // context.read<ProductsBloc>().selectedMainCategory = value;

                              // context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(value!.categoryId));
                            });
                          },
                          popupProps: PopupProps.menu(
                            fit: FlexFit.loose,
                            searchFieldProps: TextFieldProps(
                              autofocus: true,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: context.colorScheme.primaryColor,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xffeeeeee),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xffeeeeee),
                                  ),
                                ),
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                            ),
                            menuProps: const MenuProps(
                              backgroundColor: Colors.transparent,
                              elevation: 9,
                            ),
                            containerBuilder: (ctx, popupWidget) {
                              return Container(
                                margin: const EdgeInsets.only(top: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: popupWidget,
                              );
                            },
                            itemBuilder: (context, item, isSelected) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                              child: Text(
                                item.categoryNameEN,
                                style: context.textTheme.labelMedium?.copyWith(color: AppColors.black),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            showSearchBox: true,
                          ),
                          compareFn: (item, selectedItem) => item.categoryId == selectedItem.categoryId,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: context.colorScheme.primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0x24656565)),
                              ),
                              filled: true,
                              fillColor: AppColors.white,
                            ),
                          ),
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.categoryName ?? '-',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: context.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        context.sizedBoxHeightExtraSmall,
                      ],
                    )),
                ItemHintTextFieldWidget(
                  textEditingController: _categoryEnNameController,
                  hintText: widget._isSub ? S.current.subCatEngName : S.current.catEngName,
                  isRequired: true,
                ),
                context.sizedBoxHeightExtraSmall,
                ItemHintTextFieldWidget(
                  textEditingController: _categoryFrNameController,
                  hintText: widget._isSub ? S.current.subCatFrenchName : S.current.catFrenchName,
                  isRequired: true,
                ),
                context.sizedBoxHeightExtraSmall,
                ItemHintTextFieldWidget(
                  textEditingController: _categoryTrNameController,
                  hintText: widget._isSub ? S.current.subCatTrName : S.current.catTrName,
                  isRequired: true,
                ),
                context.sizedBoxHeightExtraSmall,
                ItemHintTextFieldWidget(
                  textEditingController: _categoryArNameController,
                  hintText: widget._isSub ? S.current.subCatArName : S.current.catArName,
                  isRequired: true,
                ),
                context.sizedBoxHeightExtraSmall,
                TwoOptionsSectionWidget(
                  title: S.current.active,
                  flagValue: widget.catIsActive,
                  onFlagChange: (flag) => setState(() => _isActive = flag),
                ),
                context.sizedBoxHeightExtraSmall,
                HiddenAppsSectionWidget(
                  preSelectedApps: _selectedVisibleApps,
                  onSelectedAppsChanged: (p0) => _selectedVisibleApps = p0,
                ),
                context.sizedBoxHeightExtraSmall,
                SizedBox(
                  height: 100,
                  width: Get.width,
                  child: ImageSelectionSectionWidget(
                    showBackButton: false,
                    imageUrl: widget.catLogo,
                    onImageChanged: (file) {
                      selectedImage = file;
                    },
                  ),
                ),
                context.sizedBoxHeightExtraSmall,
                (_isLoading)
                    ? const LoadingWidget()
                    : Row(
                        children: [
                          Visibility(
                            visible: widget._isEditMode,
                            child: Expanded(
                                child: RoundedBtnWidget(
                              onTap: () {
                                widget._isSub
                                    ? context
                                        .read<SubCategoryBloc>()
                                        .add(DeleteSubCategoryRequestEvent(widget.subCatId!))
                                    : context
                                        .read<MainCategoryBloc>()
                                        .add(DeleteMainCategoryRequestEvent(widget.mainCatId!));
                              },
                              height: 40,
                              bgColor: Colors.red,
                              btnTextColor: Colors.white,
                              btnText: S.current.delete,
                            )),
                          ),
                          context.sizedBoxWidthMicro,
                          Expanded(
                            child: RoundedBtnWidget(
                              onTap: () {
                                if (!_formKey.currentState!.validate()) return;

                                if (widget._isEditMode) {
                                  (widget._isSub)
                                      ? context.read<SubCategoryBloc>().add(EditSubCategoryRequestEvent(
                                          subCategoryId: widget.subCatId!,
                                          mainCategoryId: _selectedMainCategory!.categoryId,
                                          categoryFrName: _categoryFrNameController.text.trim(),
                                          categoryTrName: _categoryTrNameController.text.trim(),
                                          categoryArName: _categoryArNameController.text.trim(),
                                          categoryEnName: _categoryEnNameController.text.trim(),
                                          visibleApplications: _selectedVisibleApps,
                                          isActive: _isActive,
                                          categoryImage: selectedImage))
                                      : context.read<MainCategoryBloc>().add(EditMainCategoryRequestEvent(
                                          categoryId: widget.mainCatId!,
                                          categoryFrName: _categoryFrNameController.text.trim(),
                                          categoryTrName: _categoryTrNameController.text.trim(),
                                          categoryArName: _categoryArNameController.text.trim(),
                                          categoryEnName: _categoryEnNameController.text.trim(),
                                          visibleApplications: _selectedVisibleApps,
                                          isActive: _isActive,
                                          categoryImage: selectedImage));
                                } else {
                                  (widget._isSub)
                                      ? context.read<SubCategoryBloc>().add(AddSubCategoryRequestEvent(
                                          selectedMainCatId: _selectedMainCategory!.categoryId,
                                          categoryFrName: _categoryFrNameController.text.trim(),
                                          categoryTrName: _categoryTrNameController.text.trim(),
                                          categoryArName: _categoryArNameController.text.trim(),
                                          visibleApplications: _selectedVisibleApps,
                                          categoryEnName: _categoryEnNameController.text.trim(),
                                          isActive: _isActive,
                                          categoryImage: selectedImage))
                                      : context.read<MainCategoryBloc>().add(AddMainCategoryRequestEvent(
                                          categoryFrName: _categoryFrNameController.text.trim(),
                                          categoryTrName: _categoryTrNameController.text.trim(),
                                          categoryArName: _categoryArNameController.text.trim(),
                                          categoryEnName: _categoryEnNameController.text.trim(),
                                          isActive: _isActive,
                                          visibleApplications: _selectedVisibleApps,
                                          categoryImage: selectedImage));
                                }
                              },
                              height: 40,
                              btnText: S.current.saveChanges,
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
