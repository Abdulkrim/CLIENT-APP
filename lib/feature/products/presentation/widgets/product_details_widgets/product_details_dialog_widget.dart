import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/item_type.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/measure_unit.dart';
import 'package:merchant_dashboard/feature/products/data/models/entity/products.dart';
import 'package:merchant_dashboard/feature/products/presentation/blocs/sub_category/sub_category_bloc.dart';
import 'package:merchant_dashboard/feature/products/presentation/widgets/product_details_widgets/category_details_dialog.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/container_setting.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_checkbox.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';
import 'package:merchant_dashboard/widgets/searchable_dropdown.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

import '../../../../../utils/mixins/mixins.dart';
import '../../../../../widgets/network_image_rounded_widget.dart';
import '../../../../../widgets/rounded_text_input.dart';
import '../../../data/models/entity/apps.dart';
import '../../../data/models/entity/dependency_item.dart';
import '../../../data/models/entity/offer_type.dart';
import '../../../data/models/entity/suggestion_item.dart';
import '../../../data/models/entity/suggestion_item_image.dart';
import '../../blocs/main_category/main_category_bloc.dart';
import '../../blocs/products/products_bloc.dart';
import '../addons_list_dialog.dart';
import '../buying_price_warning_dialog.dart';
import '../easy_autocomplete/easy_autocomplete.dart' as myeasy;

class ProductDetailsDialogWidget extends StatefulWidget {
  final Product? product;
  final bool showLoyaltySection;
  final Function() onBackTap;

  const ProductDetailsDialogWidget({
    Key? key,
    this.product,
    required this.onBackTap,
    this.showLoyaltySection = false,
    this.selectedSubId = -1,
  }) : super(key: key);

  final int selectedSubId;

  @override
  State<ProductDetailsDialogWidget> createState() => _ProductDetailsDialogWidgetState();
}

class _ProductDetailsDialogWidgetState extends State<ProductDetailsDialogWidget> with ImagesConditions {
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

  late List<DependencyItem> _selectedAddOns = widget.product?.addOnItems ?? [];

  ItemType? _selectedItemType;

  bool _showBarcodeScanner = false;

  OfferType? _selectedOfferType;

  final _debounce = Debouncer(delay: const Duration(milliseconds: 800));

  final controller = MultiSelectController<Apps>();

  late List<String> _selectedVisibleApps =
      widget.product == null ? Apps.values.map((e) => e.name).toList() : widget.product!.visibleApplications;

  SuggestionItemImage? _selectedImageSuggestion;

/*
  @override
  void dispose() {
    super.dispose();
  }
*/

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        controller.selectWhere((item) => _selectedVisibleApps.contains(item.value.name));
      },
    );

    context.read<ProductsBloc>()
      ..suggestionItems = []
      ..suggestionItemImages = [];
  }

  void _sendAddOrEditProduct() {
    if (widget.product != null) {
      context.read<ProductsBloc>().add(EditProductRequestEvent(
            productId: widget.product!.productId,
            productEnName: _productNameEnController.text.trim(),
            suggestionImageId: _selectedImageSuggestion?.imageId,
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
            addOnIds: _selectedAddOns.map((e) => e.itemId).toList(),
            redeemPoint: _redeemPointController.text.trim(),
            rechargePoint: _rechargePointController.text.trim(),
            hiddenApplications: _selectedVisibleApps,
          ));
    } else {
      context.read<ProductsBloc>().add(AddProductRequestEvent(
            productEnName: _productNameEnController.text.trim(),
            suggestionImageId: _selectedImageSuggestion?.imageId,
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
            addOnIds: _selectedAddOns.map((e) => e.itemId).toList(),
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

    _selectedItemType ??= widget.product?.itemType ?? context.select<ProductsBloc, ItemType?>((value) => value.itemTypes.firstOrNull);
  }

  final _productFormKey = GlobalKey<FormState>();

  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    _provideDialogData();

    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton.icon(
                  onPressed: widget.onBackTap,
                  label: Text(
                    (widget.product != null) ? 'Edit Product' : 'Add Product',
                    style: context.textTheme.titleLarge,
                  ),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<ProductsBloc, ProductsState>(listener: (_, state) {
                      if (state is EditProductStates && state.errorMsg.isNotEmpty) {
                        context.showCustomeAlert(state.errorMsg);
                      } else if (state is EditProductStates && state.msg.isNotEmpty) {
                        widget.onBackTap();
                        context.showCustomeAlert(state.msg);
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
                  child: SizedBox(
                    width: double.infinity,
                    child: ScrollableWidget(
                      child: Wrap(
                        children: [
                          ContainerSetting(
                            blur: 20,
                            maxWidth: 550,
                            padding: const EdgeInsets.all(12),
                            child: Form(
                                key: _productFormKey,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(S.current.type,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 8),
                                            RoundedDropDownList(
                                                selectedValue: _selectedItemType,
                                                onChange: (type) => setState(() => _selectedItemType = type!),
                                                margin: const EdgeInsets.only(right: 8),
                                                isExpanded: true,
                                                items:
                                                    (context.select<ProductsBloc, List<ItemType>>((value) => value.itemTypes))
                                                        .map<DropdownMenuItem<ItemType>>(
                                                          (ItemType value) => DropdownMenuItem<ItemType>(
                                                            value: value,
                                                            child: Text(
                                                              value.name,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(color: AppColors.black),
                                                              textAlign: TextAlign.start,
                                                              overflow: TextOverflow.clip,
                                                            ),
                                                          ),
                                                        )
                                                        .toList()),
                                          ],
                                        )),
                                        if (!(_selectedItemType?.isAddOnType ?? false))
                                          RoundedBtnWidget(
                                            onTap: () async {
                                              final List<DependencyItem>? selectedAddons = await ((context.isPhone)
                                                  ? Get.to
                                                  : Get.dialog)(BlocProvider<ProductsBloc>.value(
                                                value: BlocProvider.of<ProductsBloc>(context),
                                                child: AddOnsListDialog(
                                                  initialAddOnItems: _selectedAddOns,
                                                  allAddOnItems: context.read<ProductsBloc>().addOnProducts,
                                                ),
                                              ));
                      
                                              if (selectedAddons != null) {
                                                setState(() => _selectedAddOns = selectedAddons);
                                              }
                                            },
                                            btnPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                            btnIcon: const Icon(Icons.add_rounded),
                                            btnText: S.current.manageAddOnItems,
                                            btnTextColor: context.colorScheme.primaryColor,
                                            boxBorder: Border.all(color: context.colorScheme.primaryColor),
                                            bgColor: AppColors.lightPrimaryColor,
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: _selectedAddOns
                                          .map((e) => Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30),
                                                    color: AppColors.lightPrimaryColor),
                                                child: Text(
                                                  e.relatedItemNameEn,
                                                  style: context.textTheme.bodyMedium
                                                      ?.copyWith(color: context.colorScheme.primaryColor),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(S.current.offerType,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 8),
                                            RoundedDropDownList(
                                                selectedValue: _selectedOfferType,
                                                onChange: (offer) => setState(() => _selectedOfferType = offer),
                                                margin: const EdgeInsets.only(right: 8),
                                                isExpanded: true,
                                                items:
                                                    (context.select<ProductsBloc, List<OfferType>>((value) => value.offerTypes))
                                                        .map<DropdownMenuItem<OfferType>>(
                                                          (OfferType value) => DropdownMenuItem<OfferType>(
                                                            value: value,
                                                            child: Text(
                                                              value.offerTypeName,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(color: AppColors.black),
                                                              textAlign: TextAlign.start,
                                                              overflow: TextOverflow.clip,
                                                            ),
                                                          ),
                                                        )
                                                        .toList()),
                                          ],
                                        )),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(S.current.measureUnit,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
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
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .labelMedium
                                                                ?.copyWith(color: AppColors.black),
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.clip,
                                                          ),
                                                        ),
                                                      )
                                                      .toList()),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    context.isPhone
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              _mainCategoriesSection(),
                                              const SizedBox(height: 16),
                                              _subCategoriesSection(),
                                            ],
                                          )
                                        : Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: _mainCategoriesSection()),
                                              const SizedBox(width: 10),
                                              Expanded(child: _subCategoriesSection()),
                                            ],
                                          ),
                                    const SizedBox(height: 16),
                                    context.isPhone
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              _nameSectionWidget(),
                                              const SizedBox(height: 16),
                                              _barcodeSectionWidget(),
                                            ],
                                          )
                                        : Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: _nameSectionWidget()),
                                              const SizedBox(width: 10),
                                              Expanded(child: _barcodeSectionWidget()),
                                            ],
                                          ),
                                    const SizedBox(height: 16),
                                    context.isPhone
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              _descriptionSectionWidget(),
                                              const SizedBox(height: 16),
                                              _priceSectionWidget(),
                                            ],
                                          )
                                        : Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: _descriptionSectionWidget(),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: _priceSectionWidget(),
                                              ),
                                            ],
                                          ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(S.current.discount,
                                            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 8),
                                        RoundedTextInputWidget(
                                          hintText: '',
                                          width: 200,
                                          textEditController: _productDiscountController,
                                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(S.current.buyingPrice,
                                                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              RoundedTextInputWidget(
                                                hintText: '10.0',
                                                textEditController: _productBuyingPriceController,
                                                isRequired: true,
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(decimal: true, signed: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Text(S.current.selectVisibleApps,
                                                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              //todo: change this with dropdownsearch
                                              /* DropdownSearch<String>.multiSelection(
                                                items: Apps.values.map((e) => e.name).toList(),
                                                popupProps: PopupPropsMultiSelection.menu(
                                                  showSelectedItems: true,
                                                ),
                                                onChanged: (value) {
                                                  print('marjan $value');
                                                },
                                                dropdownBuilder: (context, selectedItems) => Wrap(
                                                  children: selectedItems
                                                      .map(
                                                        (e) => Container(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 10, vertical: 4),
                                                          margin: const EdgeInsets.symmetric(
                                                              horizontal: 8, vertical: 8),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(30),
                                                              color: AppColors.lightGray),
                                                          child: Row(mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                e,
                                                                style: context.textTheme.bodyMedium?.copyWith(
                                                                    color: context.colorScheme.primaryColor),
                                                              ),
                                                              IconButton(onPressed: ()=> , icon: Icon(Icons.cancel_rounded, color: Colors.black))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                selectedItems: _selectedVisibleApps,
                                              ), */
                      
                                              MultiDropdown<Apps>(
                                                items: Apps.values.map((e) => DropdownItem(value: e, label: e.name)).toList(),
                                                controller: controller,
                                                enabled: true,
                                                searchEnabled: false,
                                                chipDecoration: ChipDecoration(
                                                  backgroundColor: AppColors.lightPrimaryColor,
                                                  wrap: true,
                                                  spacing: 1,
                                                ),
                                                fieldDecoration: FieldDecoration(
                                                  hintStyle: context.textTheme.bodyMedium?.copyWith(color: AppColors.gray),
                                                  showClearIcon: false,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(
                                                      color: Color(0xffeeeeee),
                                                    ),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: BorderSide(
                                                      color: context.colorScheme.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                dropdownDecoration: const DropdownDecoration(
                                                  maxHeight: 500,
                                                ),
                                                dropdownItemDecoration: const DropdownItemDecoration(
                                                  selectedIcon: Icon(Icons.check_circle_rounded, color: Colors.green),
                                                ),
                                                onSelectionChange: (selectedItems) {
                                                  _selectedVisibleApps = selectedItems.map((e) => e.name).toList();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        RoundedCheckBoxWidget(
                                          initalCheck: _isOpenPrice,
                                          onChnageCheck: (check) => setState(() => _isOpenPrice = check),
                                          text: S.current.openPrice,
                                        ),
                                        const SizedBox(height: 8),
                                        Visibility(
                                          visible: _isOpenPrice,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(S.current.minimumPrice,
                                                      style:
                                                          context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 8),
                                                  RoundedTextInputWidget(
                                                    hintText: '10',
                                                    textEditController: _productMinPriceController,
                                                    keyboardType:
                                                        const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  ),
                                                ],
                                              )),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(S.current.maximumPrice,
                                                      style:
                                                          context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                                  const SizedBox(height: 8),
                                                  RoundedTextInputWidget(
                                                    hintText: '10',
                                                    textEditController: _productMaxPriceController,
                                                    keyboardType:
                                                        const TextInputType.numberWithOptions(decimal: true, signed: true),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        RoundedCheckBoxWidget(
                                          initalCheck: _canHaveStock,
                                          onChnageCheck: (check) => setState(() => _canHaveStock = check),
                                          text: S.current.canHaveStock,
                                        ),
                                        const SizedBox(height: 8),
                                        Visibility(
                                          visible:
                                              _canHaveStock && widget.product == null, // Display this input just in adding mode
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(S.current.initialQuantity,
                                                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 8),
                                              RoundedTextInputWidget(
                                                hintText: '10',
                                                width: 200,
                                                textEditController: _productStockController,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    RoundedCheckBoxWidget(
                                      initalCheck: _isActive,
                                      onChnageCheck: (check) => setState(() => _isActive = check),
                                      text: S.current.isActive,
                                    ),
                                  ],
                                )),
                          ),
                          ContainerSetting(
                              blur: 20,
                              padding: const EdgeInsets.all(16),
                              maxWidth: 470,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text('Image'),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 150,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: AppInkWell(
                                          onTap: () async {
                                            final result = await pickImageFromGallery();
                      
                                            if (result.image != null) {
                                              _selectedImageSuggestion = null;
                                              setState(() => selectedImage = (result.image!));
                                            } else if (result.errorMessage != null) {
                                              context.showCustomeAlert(result.errorMessage!);
                                            }
                                          },
                                          child: DottedBorder(
                                            // todo: merge with image selection widget
                                            borderType: BorderType.RRect,
                                            dashPattern: [6, 6],
                                            radius: const Radius.circular(10),
                                            color: Colors.black,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: AppColors.gray2, borderRadius: BorderRadius.circular(10)),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  SvgPicture.asset(
                                                    Assets.iconsUploadImage,
                                                    width: 30,
                                                    color: AppColors.black,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Center(
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(color: Colors.black, strokeAlign: 2)),
                                                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                                                        SvgPicture.asset(
                                                          Assets.iconsUploadImage,
                                                          width: 10,
                                                          color: AppColors.black,
                                                        ),
                                                        const SizedBox(width: 10),
                                                        const Text('Upload Image'),
                                                      ]),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: _selectedImageSuggestion != null
                                                      ? NetworkImage(_selectedImageSuggestion!.imageUrl)
                                                      : selectedImage.path.isNotEmpty
                                                          ? !context.isPhone
                                                              ? NetworkImage(selectedImage.path)
                                                              : FileImage(File(selectedImage.path))
                                                          : widget.product?.logo != null
                                                              ? NetworkImage(widget.product!.logo)
                                                              : const AssetImage(Assets.bgPlaceholderImage),
                                                  fit: BoxFit.cover)),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // if (state is GetItemSuggestionsImageStates && state.isLoading) const LoadingWidget(),
                                  if (context.read<ProductsBloc>().suggestionItemImages.isNotEmpty)
                                    Wrap(
                                      children: context
                                          .read<ProductsBloc>()
                                          .suggestionItemImages
                                          .map(
                                            (e) => AppInkWell(
                                              onTap: () {
                                                selectedImage = XFile('');
                      
                                                setState(() => _selectedImageSuggestion = e);
                                              },
                                              child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      image:
                                                          DecorationImage(image: NetworkImage(e.imageUrl), fit: BoxFit.cover))),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  const SizedBox(height: 16),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) => (state is EditProductStates && state.isLoading)
                      ? const LoadingWidget()
                      : ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Row(
                            children: [
                              Expanded(
                                child: Visibility(
                                  visible: widget.product != null,
                                  child: RoundedBtnWidget(
                                    btnMargin: const EdgeInsets.all(20),
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
                                    width: 200,
                                    boxBorder: Border.all(color: Colors.red),
                                    btnText: S.current.delete,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RoundedBtnWidget(
                                  btnMargin: const EdgeInsets.all(20),
                                  onTap: () {
                                    if (_productFormKey.currentState!.validate()) {
                                      if (_productNameEnController.text.trim().isEmpty) {
                                        context.showCustomeAlert('Enter product name');
                                        return;
                                      }
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
                                  width: 200,
                                ),
                              ),
                            ],
                          ),
                        )),
            ],
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align( alignment: Alignment.topLeft,child: IconButton(onPressed: ()=>_pageViewController.jumpToPage(0), icon: const Icon(Icons.arrow_back_rounded, color: Colors.black))),
              Expanded(
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    facing: CameraFacing.back,
                    torchEnabled: false,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                
                    _productBarcodeNumberController.text = barcodes.first.rawValue.toString();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainCategoriesSection() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(S.current.category, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SearchableDropdown(
                  preDefinedItem: SearchableDropDownModel(
                      item: _selectedMainCategory, displayName: _selectedMainCategory?.categoryNameEN ?? ''),
                  items: _mainCategories.map((e) => SearchableDropDownModel(item: e, displayName: e.categoryNameEN)).toList(),
                  onSelectedItemChanged: (selectedItem) {
                    setState(() {
                      _selectedMainCategory = selectedItem!.item;

                      context.read<ProductsBloc>().selectedMainCategory = selectedItem.item;

                      context.read<SubCategoryBloc>().add(GetSubCategoriesEvent(selectedItem.item!.categoryId));
                    });
                  },
                ),
              ],
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
            btnMargin: const EdgeInsets.only(bottom: 8, left: 8),
            btnPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            btnIcon: const Icon(
              Icons.edit,
              size: 15,
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
            btnMargin: const EdgeInsets.only(bottom: 8, left: 8),
            btnPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            btnIcon: const Icon(
              Icons.add_circle_rounded,
              color: Colors.black,
              size: 15,
            ),
            bgColor: const Color(0xFFEBEBEB),
          ),
        ],
      );

  Widget _subCategoriesSection() => Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.current.subcategory, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SearchableDropdown(
              key: UniqueKey(),
              preDefinedItem:
                  SearchableDropDownModel(item: _selectedSubCategory, displayName: _selectedSubCategory?.categoryNameEN ?? ''),
              items: _subCategories.map((e) => SearchableDropDownModel(item: e, displayName: e.categoryNameEN)).toList(),
              onSelectedItemChanged: (selectedItem) {
                setState(() => _selectedSubCategory = selectedItem!.item);
              },
            )
          ],
        )),
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
            btnMargin: const EdgeInsets.only(bottom: 8, left: 8),
            btnPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            btnIcon: const Icon(
              Icons.edit,
              size: 15,
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
          btnMargin: const EdgeInsets.only(bottom: 8, left: 8),
          btnPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          btnIcon: const Icon(
            Icons.add_circle_rounded,
            color: Colors.black,
            size: 15,
          ),
          bgColor: const Color(0xFFEBEBEB),
        ),
      ]);

  Widget _nameSectionWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('${S.current.productEngName}*', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          myeasy.EasyAutocomplete(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: context.colorScheme.primaryColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color(0xffeeeeee),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color(0xffeeeeee),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color(0xffeeeeee),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                  ),
                ),
              ),
              asyncSuggestions: (searchValue) async => context.read<ProductsBloc>().getSuggestionItems(searchValue),
              progressIndicatorBuilder: const CupertinoActivityIndicator(),
              onChanged: (value) => print('onChanged value: $value'),
              controller: _productNameEnController,
              onSubmitted: (value) async {
                await context.read<ProductsBloc>().getSuggestionItemsImage(value);
                setState(() {});
              })
        ],
      );

  Widget _barcodeSectionWidget() => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(S.current.barcodeNumber, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                RoundedTextInputWidget(
                  hintText: '',
                  textEditController: _productBarcodeNumberController,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Visibility(
            visible: !kIsWeb,
            child: RoundedBtnWidget(
              onTap: () {
                _pageViewController.jumpToPage(1);
              },
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
      );

  Widget _descriptionSectionWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(S.current.productDes, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          RoundedTextInputWidget(
            hintText: '',
            textEditController: _productDescriptionController,
          ),
        ],
      );

  Widget _priceSectionWidget() => Visibility(
        visible: !_isOpenPrice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.current.price, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            RoundedTextInputWidget(
              hintText: '10.0',
              textEditController: _productPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
            ),
          ],
        ),
      );
}
