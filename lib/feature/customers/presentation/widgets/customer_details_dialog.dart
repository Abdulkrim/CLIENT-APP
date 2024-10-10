import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../core/constants/defaults.dart';
import '../../../../utils/responsive_widgets/responsive_dialog_widget.dart';
import '../../../../utils/snack_alert/snack_alert.dart';
import '../../../../widgets/item_hint_textfield_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/rounded_btn.dart';
import '../../../../widgets/rounded_text_input.dart';
import '../../../../widgets/scrollable_widget.dart';
import '../../../region/data/models/entity/region_data.dart';
import '../../../region/presentation/widgets/regions_dropdowns_widget.dart';
import '../../data/models/entity/customer_list_info.dart';
import '../../data/models/params/customer_parameter.dart';
import '../blocs/customers/customer_bloc.dart';

class CustomerDetailsDialog extends StatefulWidget {
  final Customer? customer;

  const CustomerDetailsDialog({Key? key, this.customer}) : super(key: key);

  @override
  State<CustomerDetailsDialog> createState() => _CustomerDetailsDialogState();
}

class _CustomerDetailsDialogState extends State<CustomerDetailsDialog> {
  late final TextEditingController _fullNameController = TextEditingController(text: widget.customer?.name);

  late final TextEditingController _phoneNumberController = TextEditingController(text: widget.customer?.phoneNumber);

  late final TextEditingController _streetController = TextEditingController(text: widget.customer?.customerAddress?.street);
  late final TextEditingController _locationController = TextEditingController(text: widget.customer?.customerAddress?.location);
  late final TextEditingController _districtController = TextEditingController(text: widget.customer?.customerAddress?.district);
  late final TextEditingController _flatController = TextEditingController(text: widget.customer?.customerAddress?.flat);
  late final TextEditingController _buildingNameController =
      TextEditingController(text: widget.customer?.customerAddress?.buildingName);
  late final TextEditingController _addressController =
      TextEditingController(text: widget.customer?.customerAddress?.completeAddress);
  late final TextEditingController _emailController = TextEditingController(text: widget.customer?.email);

/*  late CustomerPayType _selectedPayType =
      (widget.customer?.customerTypeId ?? 1) == 1 ? CustomerPayType.cash : CustomerPayType.credit;*/
  late Gender _selectedCustomerGender = (widget.customer?.gender ?? false) ? Gender.female : Gender.male;

  int? _selectedCityId;

  final _selectedCountryCode = ''.obs;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialogWidget(
      title: (widget.customer == null) ? S.current.addCustomer : S.current.editCustomer,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: ScrollableWidget(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ItemHintTextFieldWidget(
                    textEditingController: _fullNameController,
                    hintText: '${S.current.customerName}*',
                    isRequired: true,
                  ),
                  context.sizedBoxHeightMicro,
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<Gender>(
                          value: Gender.male,
                          title: Text(
                            S.current.male,
                            style: context.textTheme.titleSmall,
                          ),
                          groupValue: _selectedCustomerGender,
                          onChanged: (value) => setState(
                            () => _selectedCustomerGender = Gender.male,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<Gender>(
                          value: Gender.female,
                          title: Text(
                            S.current.female,
                            style: context.textTheme.titleSmall,
                          ),
                          groupValue: _selectedCustomerGender,
                          onChanged: (value) => setState(() => _selectedCustomerGender = Gender.female),
                        ),
                      ),
                    ],
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Text(S.current.email, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  context.sizedBoxHeightMicro,
                  RoundedTextInputWidget(
                    hintText: S.current.email,
                    textEditController: _emailController,
                  ),
                  context.sizedBoxHeightExtraSmall,
                  RegionsDropDownWidget(
                    mandatoryChar: '*',
                    preCountrySelected: widget.customer?.customerAddress?.city.countryId,
                    preSelectedCity: widget.customer?.customerAddress?.city.id,
                    onCountryChanged: ({countryCode}) => _selectedCountryCode(countryCode ?? ''),
                    onCityChanged: (RegionData selectedItem) {
                      _selectedCityId = selectedItem.cityId;
                    },
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Text('${S.current.phoneNumber}*', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  context.sizedBoxHeightMicro,
                  RoundedTextInputWidget(
                    hintText: '234567891',
                    keyboardType: TextInputType.number,
                    isRequired: true,
                    prefixWidget:              (widget.customer == null)? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
           
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 16, right: 6),
                            child: Text(
                              _selectedCountryCode.value,
                              style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ):null,
                    textEditController: _phoneNumberController,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  ItemHintTextFieldWidget(textEditingController: _locationController, hintText: S.current.location),
                  context.sizedBoxHeightExtraSmall,
                  ItemHintTextFieldWidget(textEditingController: _streetController, hintText: S.current.street),
                  context.sizedBoxHeightExtraSmall,
                  ItemHintTextFieldWidget(textEditingController: _districtController, hintText: S.current.district),
                  context.sizedBoxHeightExtraSmall,
                  ItemHintTextFieldWidget(textEditingController: _flatController, hintText: S.current.flat),
                  context.sizedBoxHeightExtraSmall,
                  ItemHintTextFieldWidget(textEditingController: _buildingNameController, hintText: S.current.buildName),
                  context.sizedBoxHeightExtraSmall,
                  /*ItemHintTextFieldWidget(
                      textEditingController: _addressController, hintText: S.current.additionalInfo),
                  context.sizedBoxHeightMicro,
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<CustomerPayType>(
                          value: CustomerPayType.cash,
                          title: Text(
                            S.current.cash,
                            style: context.textTheme.titleSmall,
                          ),
                          groupValue: _selectedPayType,
                          onChanged: (value) => setState(
                            () => _selectedPayType = CustomerPayType.cash,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<CustomerPayType>(
                          value: CustomerPayType.credit,
                          title: Text(
                            S.current.credit,
                            style: context.textTheme.titleSmall,
                          ),
                          groupValue: _selectedPayType,
                          onChanged: (value) => setState(() => _selectedPayType = CustomerPayType.credit),
                        ),
                      ),
                    ],
                  ),*/
                  context.sizedBoxHeightSmall,
                  BlocConsumer<CustomerBloc, CustomerState>(
                    listener: (context, state) {
                      if (state is UpdateCustomerState && state.message.isNotEmpty) {
                        Get.back();
                        context.showCustomeAlert(state.message, SnackBarType.success);
                        context.read<CustomerBloc>().add(const GetAllCustomersEvent(getMore: false));
                      } else if (state is UpdateCustomerState && state.errorMessage != null) {
                        context.showCustomeAlert(state.errorMessage!, SnackBarType.error);
                      }
                    },
                    builder: (context, state) => (state is UpdateCustomerState && state.isLoading)
                        ? const LoadingWidget()
                        : Row(
                            children: [
                              Visibility(
                                visible: widget.customer != null,
                                child: Expanded(
                                  flex: 2,
                                  child: RoundedBtnWidget(
                                    onTap: () => context.read<CustomerBloc>().add(DeleteCustomerEvent(widget.customer!.id)),
                                    btnText: S.current.deleteCustomer,
                                    height: 35,
                                    width: 300,
                                    bgColor: Colors.white,
                                    btnTextColor: Colors.red,
                                    boxBorder: Border.all(color: Colors.red),
                                    btnTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: RoundedBtnWidget(
                                      onTap: () {
                                        if(_formKey.currentState!.validate() && _selectedCityId != null ){
                                          if ((widget.customer != null)) {
                                            context.read<CustomerBloc>().add(EditCustomerEvent(
                                                customerParameter: CustomerParameter.edit(
                                                  customerId: widget.customer!.id,
                                                  addressId: widget.customer!.customerAddress!.addressId,
                                                  cityId: _selectedCityId!,
                                                  customerName: _fullNameController.text.trim(),
                                                  gender: _selectedCustomerGender.value,
                                                  phoneNumber: '${_selectedCountryCode.value}${_phoneNumberController.text.trim()}',
                                                  customerType: CustomerPayType.cash.value,
                                                  email: _emailController.text.trim(),
                                                  district: _districtController.text.trim(),
                                                  flat: _flatController.text.trim(),
                                                  location: _locationController.text.trim(),
                                                  street: _streetController.text.trim(),
                                                  buildingName: _buildingNameController.text.trim(),
                                                  completeAddress: _addressController.text.trim(),
                                                )));
                                          } else {
                                            context.read<CustomerBloc>().add(AddCustomerEvent(
                                                customerParameter: CustomerParameter.create(
                                                  cityId: _selectedCityId!,
                                                  customerName: _fullNameController.text.trim(),
                                                  gender: _selectedCustomerGender.value,
                                                  phoneNumber: '${_selectedCountryCode.value}${_phoneNumberController.text.trim()}',
                                                  email: _emailController.text.trim(),
                                                  customerType: CustomerPayType.cash.value,
                                                  district: _districtController.text.trim(),
                                                  flat: _flatController.text.trim(),
                                                  location: _locationController.text.trim(),
                                                  street: _streetController.text.trim(),
                                                  buildingName: _buildingNameController.text.trim(),
                                                  completeAddress: _addressController.text.trim(),
                                                )));
                                          }
                                        }

                                      },
                                      btnText: widget.customer == null ? S.current.addCustomer : S.current.saveChanges,
                                      height: 35,
                                      width: 300,
                                      btnTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ],
                          ),
                  ),
                  context.sizedBoxHeightSmall,
                ],
              ),
            ),
          )),
    );
  }
}
