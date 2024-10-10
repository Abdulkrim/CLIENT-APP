import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/sub_category/sub_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/category_details_dialog.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/two_options_section_widget.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/item_hint_textfield_widget.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../data/models/entity/apps.dart';
import '../../../data/models/entity/dependency_item.dart';
import '../../../data/models/entity/offer_type.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/products/products_bloc.dart';
import '../buying_price_warning_dialog.dart';
import '../product_addon_items_table_widget.dart';
import 'hidden_apps_section_widget.dart';
import 'image_selection_section_widget.dart';

class ProductDetailsDialogWidget extends StatefulWidget {
  final Product? product;
  final bool showLoyaltySection;

  const ProductDetailsDialogWidget({
    Key? key,
    this.product,
    this.showLoyaltySection = false,
    this.selectedSubId = -1,
  }) : super(key: key);

  final int selectedSubId;

  @override
  State<ProductDetailsDialogWidget> createState() => _ProductDetailsDialogWidgetState();
}

class _ProductDetailsDialogWidgetState extends State<ProductDetailsDialogWidget> {
  late final TextEditingController _productNameEnController = TextEditingController(text: widget.product?.productNameEN);

  late final TextEditingController _productPriceController =
  TextEditingController(text: widget.product?.originalPrice.toString());

  late final TextEditingController _productDiscountController = TextEditingController(text: widget.product?.discount.toString());

  late final TextEditingController _productBuyingPriceController =
  TextEditingController(text: widget.product?.buyingPrice.toString());

  late final TextEditingController _productMinPriceController = TextEditingController(text: widget.product?.minPrice.toString());

  late final TextEditingController _productMaxPriceController = TextEditingController(text: widget.product?.maxPrice.toString());

  late final TextEditingController _productQuantityController = TextEditingController(text: widget.product?.quantity.toString());

  late final TextEditingController _productStockController = TextEditingController(text: '0');

  late final TextEditingController _productDescriptionController =
  TextEditingController(text: widget.product?.description.toString());

  late final TextEditingController _rechargePointController =
  TextEditingController(text: widget.product?.rechargePoint.toString());
  late final TextEditingController _redeemPointController = TextEditingController(text: widget.product?.redeemPoint.toString());

  late final TextEditingController _productBarcodeNumberController =
  TextEditingController(text: widget.product?.barcodeNumber.toString());

  late bool _isActive = widget.product?.isActive ?? true;

  late bool _isOpenPrice = (widget.product?.isOpenPrice ?? false);

  late bool _isOpenQuantity = widget.product?.isOpenQuantity ?? false;

  late bool _canHaveStock = widget.product?.canHaveStock ?? false;

  List<ProductsCategory> _mainCategories = <ProductsCategory>[];

  late ProductsCategory? _selectedMainCategory = _mainCategories.first;

  List<SubCategory> _subCategories = [];

  SubCategory? _selectedSubCategory;

  List<MeasureUnit> _measureUnits = <MeasureUnit>[];

  late MeasureUnit? _selectedUnitOfMeasure;

  XFile selectedImage = XFile('');

  late List<int> _selectedAddOnIds = widget.product?.addOnItems.map((e) => e.itemId).toList() ?? [];

  ItemType? _selectedItemType;

  bool _showBarcodeScanner = false;

  OfferType? _selectedOfferType;

  int? _selectedSuggestionImageId;

  late List<String> _selectedVisibleApps =
  widget.product == null ? Apps.values.map((e) => e.name).toList() : widget.product!.visibleApplications;

  void _sendAddOrEditProduct() {
    if (widget.product != null) {
      context.read<ProductsBloc>().add(EditProductRequestEvent(
        productId: widget.product!.productId,
        productEnName: _productNameEnController.text.trim(),
        suggestionImageId: _selectedSuggestionImageId,
        productPrice: _productPriceController.text.trim(),
        buyingPrice: _productBuyingPriceController.text.trim(),
        description: _productDescriptionController.text.trim(),
        productType: _selectedItemType!,
        productQuantity: _productQuantityController.text.trim(),
        productIsActive: _isActive,
        isOpenPrice: _isOpenPrice,
        barcode: _productBarcodeNumberController.text.trim(),
        minPrice: _productMinPriceController.text.trim(),
        maxPrice: _productMaxPriceController.text.trim(),
        isOpenQuantity: _isOpenQuantity,
        productImage: (selectedImage.path.isNotEmpty) ? selectedImage : null,
        subCategory: _selectedSubCategory!.subCategoryId,
        lastSubCategoryId: widget.product!.subCategoryId,
        offerTypeId: _selectedOfferType!.offerTypeId,
        canHaveStock: _canHaveStock,
        unitOfMeasureId: _selectedUnitOfMeasure!.id,
        discount: _productDiscountController.text.trim(),
        addOnIds: _selectedAddOnIds,
        redeemPoint: _redeemPointController.text.trim(),
        rechargePoint: _rechargePointController.text.trim(),
        hiddenApplications: _selectedVisibleApps,
      ));
    } else {
      context.read<ProductsBloc>().add(AddProductRequestEvent(
        productEnName: _productNameEnController.text.trim(),
        suggestionImageId: _selectedSuggestionImageId,
        productPrice: _isOpenPrice ? _productMinPriceController.text.trim() : _productPriceController.text.trim(),
        buyingPrice: _productBuyingPriceController.text.trim(),
        description: _productDescriptionController.text.trim(),
        productType: _selectedItemType!,
        productQuantity: _productQuantityController.text.trim(),
        stockQuantity: _canHaveStock ? int.parse(_productStockController.text.trim()) : null,
        canHaveStock: _canHaveStock,
        unitOfMeasureId: _selectedUnitOfMeasure!.id,
        productIsActive: _isActive,
        isOpenPrice: _isOpenPrice,
        discount: _productDiscountController.text.trim(),
        barcode: _productBarcodeNumberController.text.trim(),
        minPrice: _productMinPriceController.text.trim(),
        maxPrice: _productMaxPriceController.text.trim(),
        isOpenQuantity: _isOpenQuantity,
        productImage: (selectedImage.path.isNotEmpty) ? selectedImage : null,
        subCategory: _selectedSubCategory!.subCategoryId,
        offerTypeId: _selectedOfferType!.offerTypeId,
        addOnIds: _selectedAddOnIds,
        redeemPoint: _redeemPointController.text.trim(),
        rechargePoint: _rechargePointController.text.trim(),
        hiddenApplications: _selectedVisibleApps,
      ));
    }
  }

  void _provideDialogData() {
    if (_mainCategories.isEmpty) {
      _mainCategories = context.select((MainCategoryBloc bloc) => bloc.mainCategories);

      _selectedMainCategory = context.read<ProductsBloc>().selectedMainCategory ??
          _mainCategories.firstWhereOrNull((element) => element.categoryId == widget.product?.categoryId) ??
          _mainCategories.first;

      _subCategories = context.select((SubCategoryBloc bloc) => bloc.subCategories);

      if (_subCategories.isNotEmpty && (_subCategories.firstOrNull?.categoryId == _selectedMainCategory?.categoryId)) {
        _selectedSubCategory = _subCategories.firstWhereOrNull((element) => element.subCategoryId == widget.selectedSubId) ??
            _subCategories.firstOrNull;
      } else {
        context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(_selectedMainCategory!.categoryId));
      }
    }

    if (_measureUnits.isEmpty) {
      _measureUnits = context.select<ProductsBloc, List<MeasureUnit>>((value) {
        _selectedUnitOfMeasure = widget.product?.itemStock?.measureUnit ??
            value.measureUnits.firstWhere(
                  (element) => element.name.toLowerCase() == 'unit',
            );
        return value.measureUnits;
      });
    }
    _selectedOfferType ??= widget.product?.offerType ??
        context.select<ProductsBloc, OfferType?>(
                (value) => value.offerTypes.firstWhereOrNull((element) => element.offerTypeName.toLowerCase() == 'normal'));

    _selectedItemType ??= widget.product?.itemType ?? context.select<ProductsBloc, ItemType?>((value) => value.itemTypes.first);
  }

  final _productFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _provideDialogData();

    return ResponsiveDialogWidget(
      onWillPop: () async => _showBarcodeScanner
          ? () {
        setState(() => _showBarcodeScanner = false);
        return false;
      }.call()
          : true,
      title: (widget.product != null) ? 'Edit Product' : 'Add Product',
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProductsBloc, ProductsState>(listener: (_, state) {
            if (state is EditProductStates && state.errorMsg.isNotEmpty) {
              context.showCustomeAlert(state.errorMsg);
            }
          }),
          BlocListener<MainCategoryBloc, MainCategoryState>(
            listener: (context, state) {
              if (state is GetMainCategoriesState || state is EditMainCategoriesState) {
                _mainCategories = context.read<MainCategoryBloc>().mainCategories;

                if (state is EditMainCategoriesState && state.isAdded) {
                  _selectedMainCategory = context.read<MainCategoryBloc>().mainCategories.last;

                  context.read<ProductsBloc>().selectedMainCategory = _selectedMainCategory;

                  context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(_selectedMainCategory!.categoryId));
                } else {
                  _selectedMainCategory = context.read<MainCategoryBloc>().mainCategories.firstWhereOrNull(
                        (element) => element.categoryId == _selectedMainCategory?.categoryId,
                  );
                }

                setState(() {});
              }
            },
          ),
          BlocListener<SubCategoryBloc, SubCategoryState>(
            listener: (context, state) {
              if (state is GetSubCategoriesState || state is EditSubCategoriesState) {
                _subCategories = context.read<SubCategoryBloc>().subCategories;

                if (_selectedSubCategory?.categoryId != _selectedMainCategory?.categoryId) {
                  _selectedSubCategory = _subCategories.firstOrNull;
                } else {
                  _selectedSubCategory = _subCategories.firstWhereOrNull(
                        (element) => element.subCategoryId == _selectedSubCategory?.subCategoryId,
                  ) ??
                      _subCategories.firstWhereOrNull((element) => element.subCategoryId == widget.selectedSubId) ??
                      _subCategories.firstOrNull;
                }

                if (state is EditSubCategoriesState && state.isAdded) {
                  _selectedSubCategory = _subCategories.last;
                }

                setState(() {});
              }
            },
          ),
        ],
        child: Stack(
          children: [
            ScrollableWidget(
              child: Form(
                key: _productFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: ImageSelectionSectionWidget(
                        imageUrl: widget.product?.logo,
                        onImageChanged: (file) {
                          selectedImage = file;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          context.sizedBoxHeightExtraSmall,
                          Text(S.current.type,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          RoundedDropDownList(
                              selectedValue: _selectedItemType,
                              onChange: (type) => setState(() => _selectedItemType = type!),
                              margin: const EdgeInsets.only(right: 8),
                              isExpanded: true,
                              items: (context.select<ProductsBloc, List<ItemType>>((value) => value.itemTypes))
                                  .map<DropdownMenuItem<ItemType>>(
                                    (ItemType value) => DropdownMenuItem<ItemType>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                                  .toList()),
                          context.sizedBoxHeightExtraSmall,
                          if (!(_selectedItemType?.isAddOnType ?? false))
                            ProductAddOnItemsTableWidget(
                                initialAddOnItems: widget.product?.addOnItems ?? [],
                                onAddOnsChanged: ({required List<DependencyItem> addOns}) =>
                                _selectedAddOnIds = addOns.map((e) => e.itemId).toList()),
                          /*   context.sizedBoxHeightExtraSmall,
                          Visibility(
                            visible: widget.showLoyaltySection,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ItemHintTextFieldWidget(
                                    textEditingController: _rechargePointController,
                                    hintText: S.current.rechargePoint,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                  ),
                                ),
                                context.sizedBoxWidthExtraSmall,
                                Expanded(
                                  child: ItemHintTextFieldWidget(
                                    textEditingController: _redeemPointController,
                                    hintText: S.current.redeemPoint,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                          context.sizedBoxHeightExtraSmall,
                          Text("Offer Type",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          RoundedDropDownList(
                              selectedValue: _selectedOfferType,
                              onChange: (offer) => setState(() => _selectedOfferType = offer),
                              margin: const EdgeInsets.only(right: 8),
                              isExpanded: true,
                              items: (context.select<ProductsBloc, List<OfferType>>((value) => value.offerTypes))
                                  .map<DropdownMenuItem<OfferType>>(
                                    (OfferType value) => DropdownMenuItem<OfferType>(
                                  value: value,
                                  child: Text(
                                    value.offerTypeName,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                                  .toList()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              context.sizedBoxHeightExtraSmall,
                              Text(S.current.measureUnit,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              RoundedDropDownList(
                                  selectedValue: _selectedUnitOfMeasure,
                                  onChange: (p0) => setState(() => _selectedUnitOfMeasure = p0),
                                  margin: const EdgeInsets.only(right: 8),
                                  isExpanded: true,
                                  validator: (p0) => (p0 == null) ? S.current.thisFieldRequired : null,
                                  items: _measureUnits
                                      .map<DropdownMenuItem<MeasureUnit>>(
                                        (MeasureUnit value) => DropdownMenuItem<MeasureUnit>(
                                      value: value,
                                      child: Text(
                                        '${value.name} - ${value.symbol}',
                                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  )
                                      .toList()),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Text(S.current.category,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          context.sizedBoxHeightMicro,
                          Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<ProductsCategory>(
                                  filterFn: (cat, filter) => cat.categoryName.toLowerCase().contains(filter.toLowerCase()),
                                  items: _mainCategories,
                                  selectedItem: _selectedMainCategory,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMainCategory = (value);

                                      context.read<ProductsBloc>().selectedMainCategory = value;

                                      context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(value!.categoryId));
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
                              ),
                              RoundedBtnWidget(
                                onTap: () => Get.dialog(
                                  MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: BlocProvider.of<MainCategoryBloc>(context),
                                      ),
                                      BlocProvider.value(
                                        value: BlocProvider.of<SubCategoryBloc>(context),
                                      ),
                                    ],
                                    child: CategoryDetailsDialog(
                                        mainCatId: _selectedMainCategory?.categoryId,
                                        catArName: _selectedMainCategory?.categoryNameAR,
                                        catTrName: _selectedMainCategory?.categoryNameTR,
                                        catFrName: _selectedMainCategory?.categoryNameFR,
                                        catEnName: _selectedMainCategory?.categoryNameEN,
                                        catLogo: _selectedMainCategory?.imageUrl,
                                        visibleApplications: _selectedMainCategory?.visibleApplications,
                                        catIsActive: _selectedMainCategory?.isActive ?? true),
                                  ),
                                ),
                                btnText: '',
                                btnPadding: const EdgeInsets.all(8),
                                btnIcon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                bgColor: const Color(0xFFEBEBEB),
                              ),
                              RoundedBtnWidget(
                                onTap: () => Get.dialog(MultiBlocProvider(providers: [
                                  BlocProvider.value(
                                    value: BlocProvider.of<MainCategoryBloc>(context),
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<SubCategoryBloc>(context),
                                  ),
                                ], child: const CategoryDetailsDialog())),
                                btnText: '',
                                btnPadding: const EdgeInsets.all(8),
                                btnIcon: const Icon(
                                  Icons.add_circle_rounded,
                                  color: Colors.black,
                                ),
                                bgColor: const Color(0xFFEBEBEB),
                              ),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Text(S.current.subcategory,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          context.sizedBoxHeightMicro,
                          Row(
                            children: [
                              Expanded(
                                child: DropdownSearch<SubCategory>(
                                  filterFn: (cat, filter) => cat.subCategoryName.toLowerCase().contains(filter.toLowerCase()),
                                  items: _subCategories,
                                  selectedItem: _selectedSubCategory,
                                  onChanged: (value) {
                                    setState(() => _selectedSubCategory = (value));
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
                                    selectedItem?.subCategoryName ?? '-',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: context.textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _subCategories.isNotEmpty,
                                child: RoundedBtnWidget(
                                  onTap: () => Get.dialog(MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: BlocProvider.of<MainCategoryBloc>(context),
                                        ),
                                        BlocProvider.value(
                                          value: BlocProvider.of<SubCategoryBloc>(context),
                                        ),
                                      ],
                                      child: CategoryDetailsDialog(
                                        mainCatId: _selectedSubCategory?.categoryId,
                                        subCatId: _selectedSubCategory?.subCategoryId,
                                        catArName: _selectedSubCategory?.categoryNameAR,
                                        catTrName: _selectedSubCategory?.categoryNameTR,
                                        catFrName: _selectedSubCategory?.categoryNameFR,
                                        catEnName: _selectedSubCategory?.categoryNameEN,
                                        visibleApplications: _selectedSubCategory?.visibleApplications,
                                        catIsActive: _selectedSubCategory?.isActive ?? true,
                                        catLogo: _selectedSubCategory?.imageUrl,
                                      ))),
                                  btnText: '',
                                  btnPadding: const EdgeInsets.all(8),
                                  btnIcon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                  bgColor: const Color(0xFFEBEBEB),
                                ),
                              ),
                              RoundedBtnWidget(
                                onTap: () => Get.dialog(MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: BlocProvider.of<MainCategoryBloc>(context),
                                      ),
                                      BlocProvider.value(
                                        value: BlocProvider.of<SubCategoryBloc>(context),
                                      ),
                                    ],
                                    child: CategoryDetailsDialog(
                                      isSub: true,
                                      mainCatId: _selectedMainCategory?.categoryId,
                                    ))),
                                btnText: '',
                                btnPadding: const EdgeInsets.all(8),
                                btnIcon: const Icon(
                                  Icons.add_circle_rounded,
                                  color: Colors.black,
                                ),
                                bgColor: const Color(0xFFEBEBEB),
                              ),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          ItemHintTextFieldWidget(
                            isRequired: true,
                            textEditingController: _productNameEnController,
                            hintText: '${S.current.productEngName} *',
                          ),
                          context.sizedBoxHeightExtraSmall,
                          ItemHintTextFieldWidget(
                            textEditingController: _productDescriptionController,
                            hintText: S.current.productDes,
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: ItemHintTextFieldWidget(
                                  textEditingController: _productBarcodeNumberController,
                                  hintText: S.current.barcodeNumber,
                                ),
                              ),
                              Visibility(
                                visible: !kIsWeb,
                                child: RoundedBtnWidget(
                                  onTap: () => setState(() => _showBarcodeScanner = true),
                                  btnText: '',
                                  btnPadding: const EdgeInsets.all(8),
                                  btnIcon: const Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                  ),
                                  bgColor: const Color(0xFFEBEBEB),
                                ),
                              ),
                            ],
                          ),
                          context.sizedBoxHeightExtraSmall,
                          ItemHintTextFieldWidget(
                            textEditingController: _productDiscountController,
                            hintText: S.current.productDiscount,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          ),
                          Visibility(
                            visible: !_isOpenPrice,
                            child: Column(
                              children: [
                                context.sizedBoxHeightExtraSmall,
                                ItemHintTextFieldWidget(
                                  textEditingController: _productPriceController,
                                  hintText: S.current.price,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                ),
                              ],
                            ),
                          ),
                          context.sizedBoxHeightExtraSmall,
                          ItemHintTextFieldWidget(
                            isRequired: true,
                            textEditingController: _productBuyingPriceController,
                            hintText: S.current.buyingPrice,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          ),
                          context.sizedBoxHeightExtraSmall,
                          Visibility(
                            visible: _isOpenPrice,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ItemHintTextFieldWidget(
                                  textEditingController: _productMinPriceController,
                                  hintText: S.current.minimumPrice,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                ),
                                context.sizedBoxHeightExtraSmall,
                                ItemHintTextFieldWidget(
                                  textEditingController: _productMaxPriceController,
                                  hintText: S.current.maximumPrice,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                ),
                                context.sizedBoxHeightExtraSmall,
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _canHaveStock && widget.product == null, // Display this input just in adding mode
                            child: ItemHintTextFieldWidget(
                              textEditingController: _productStockController,
                              hintText: S.current.initialQuantity,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          context.sizedBoxHeightExtraSmall,
                          HiddenAppsSectionWidget(
                            preSelectedApps: _selectedVisibleApps,
                            onSelectedAppsChanged: (p0) => _selectedVisibleApps = p0,
                          ),
                          context.sizedBoxHeightExtraSmall,
                          TwoOptionsSectionWidget(
                            title: S.current.canHaveStock,
                            flagValue: _canHaveStock,
                            onFlagChange: (flag) => setState(() => _canHaveStock = flag),
                          ),
                          context.sizedBoxHeightExtraSmall,
                          TwoOptionsSectionWidget(
                            title: S.current.active,
                            flagValue: _isActive,
                            onFlagChange: (flag) => _isActive = flag,
                          ),
                          context.sizedBoxHeightExtraSmall,
                          TwoOptionsSectionWidget(
                            title: S.current.openQuantity,
                            flagValue: _isOpenQuantity,
                            onFlagChange: (flag) => _isOpenQuantity = flag,
                          ),
                          context.sizedBoxHeightExtraSmall,
                          TwoOptionsSectionWidget(
                            title: S.current.openPrice,
                            flagValue: _isOpenPrice,
                            onFlagChange: (flag) {
                              if (flag) _productDiscountController.text = '0';
                              setState(() => _isOpenPrice = flag);
                            },
                          ),
                          context.sizedBoxHeightSmall,
                          BlocBuilder<ProductsBloc, ProductsState>(
                              builder: (context, state) => (state is EditProductStates && state.isLoading)
                                  ? const LoadingWidget()
                                  : Row(
                                children: [
                                  Visibility(
                                    visible: widget.product != null,
                                    child: Expanded(
                                      child: RoundedBtnWidget(
                                        onTap: () => showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext _) {
                                            return AlertDialog.adaptive(
                                              title: Text(S.current.deleteItem),
                                              content: Text(S.current.deleteItemDesc),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    context.read<ProductsBloc>().add(DeleteProductRequestEvent(
                                                      productId: widget.product!.productId,
                                                      lastSubCategoryId: widget.product!.subCategoryId,
                                                    ));
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                                TextButton(
                                                  child: const Text('No'),
                                                  onPressed: () => Navigator.of(context).pop(),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        height: 40,
                                        bgColor: Colors.white,
                                        btnTextColor: Colors.red,
                                        boxBorder: Border.all(color: Colors.red),
                                        btnText: S.current.delete,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: RoundedBtnWidget(
                                      onTap: () {
                                        if (_productFormKey.currentState!.validate()) {
                                          if (_isOpenPrice &&
                                              (_productMinPriceController.text.trim().isEmpty ||
                                                  _productMaxPriceController.text.trim().isEmpty)) {
                                            context.showCustomeAlert(S.current.enterMinimumAndMaximumPrice);
                                            return;
                                          } else if (!_isOpenPrice && _productPriceController.text.trim().isEmpty) {
                                            context.showCustomeAlert(S.current.enterPrice);
                                            return;
                                          }

                                          if (_selectedSubCategory == null) {
                                            context.showCustomeAlert(S.current.selectSubCategory);
                                            return;
                                          }
                                          if (_selectedOfferType == null) {
                                            context.showCustomeAlert(S.current.type);
                                            return;
                                          }
                                          if (_productDiscountController.text.isNotEmpty) {
                                            if (double.parse(_productDiscountController.text) >
                                                double.parse(_productPriceController.text.trim())) {
                                              context.showCustomeAlert(S.current.discountPriceCannotBeGreaterThanPrice);
                                              return;
                                            }
                                          }

                                          if (!_isOpenPrice &&
                                              (double.tryParse(_productBuyingPriceController.text.trim()) ?? 0) >
                                                  (double.tryParse(_productPriceController.text.trim()) ?? 0)) {
                                            Get.dialog(BuyingPriceWarningDialog(
                                              onOkayTap: () => _sendAddOrEditProduct(),
                                            ));

                                            return;
                                          } else {
                                            _sendAddOrEditProduct();
                                          }
                                        }
                                      },
                                      btnText: (widget.product != null) ? S.current.saveProduct : S.current.addProduct,
                                      height: 40,
                                      width: Get.width,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: context.isPhone && _showBarcodeScanner,
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal,
                  facing: CameraFacing.back,
                  torchEnabled: false,
                ),
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  setState(() {
                    _showBarcodeScanner = (false);
                  });

                  _productBarcodeNumberController.text = barcodes.first.rawValue.toString();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
