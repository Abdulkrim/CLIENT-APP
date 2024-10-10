import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/core/utils/configuration.dart';
import 'package:merchant_dashboard/core/utils/validations/validation.dart';
import 'package:merchant_dashboard/core/utils/validations/validator.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/region/data/models/entity/region_data.dart';
import 'package:merchant_dashboard/feature/region/presentation/widgets/regions_dropdowns_widget.dart';
import 'package:merchant_dashboard/feature/signup/data/models/entity/business_type.dart';
import 'package:merchant_dashboard/feature/signup/presentation/blocs/sign_up_bloc.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/rounded_dropdown_list.dart';
import '../../../../../widgets/rounded_text_input.dart';

class CreateBranchDialog extends StatefulWidget {
  const CreateBranchDialog({
    super.key,
    required this.goNextPage,
    this.showBackButton = true,
    this.nextButtonText,
    this.width,
    this.height,
  });

  final Function goNextPage;
  final double? width;
  final double? height;
  final String? nextButtonText;
  final bool showBackButton;

  @override
  State<CreateBranchDialog> createState() => _CreateBranchDialogState();
}

class _CreateBranchDialogState extends State<CreateBranchDialog> {
  final _formKey = GlobalKey<FormState>();

  final _branchNameController = TextEditingController();
  final _domainController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _emailController = TextEditingController(text: getIt<MainScreenBloc>().loggedInMerchantInfo?.email);
  late final _phoneController =
      TextEditingController(text: getIt<MainScreenBloc>().loggedInMerchantInfo?.withoutPrefixPhoneNumber);

  final _selectedCountryCode = ''.obs;
  RegionData? _selectedRegion;

  int? _selectedBusinessType;

  @override
  void initState() {
    super.initState();

    context.read<SignUpBloc>().add(const GetAllBusinessTypesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final businessTypes = context.select<SignUpBloc, List<BusinessType>>((bloc) => bloc.businessTypes);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxHeight = constraints.maxHeight;
            const double calculatedHeight = 1500;

            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0, // Set minimum height if needed
                maxHeight: calculatedHeight > maxHeight ? maxHeight : calculatedHeight,
              ),
              child: Container(
                width: widget.width,
                margin: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 32, right: 26, left: 26),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.current.pleaseSelectBusinessTypeAndCountry,
                        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      context.sizedBoxHeightMicro,
                      Text(
                        S.current.selectBusinessTypeDescription,
                        style: context.textTheme.bodySmall?.copyWith(color: AppColors.gray),
                      ),
                      context.sizedBoxHeightSmall,
                      Text('${S.current.businessType}*',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedDropDownList(
                          margin: EdgeInsets.zero,
                          validator: (p0) => (p0 == null) ? S.current.selectBusinessType : null,
                          selectedValue: _selectedBusinessType,
                          isExpanded: true,
                          onChange: (p0) => setState(() => _selectedBusinessType = p0),
                          items: businessTypes
                              .map((e) => DropdownMenuItem<int>(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.black),
                                  )))
                              .toList()),
                      context.sizedBoxHeightExtraSmall,
                      Text('${S.current.branchName}*',
                          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        hintText: S.current.branchName,
                        isRequired: true,
                        textEditController: _branchNameController,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text('${S.current.enterSubDomain}*',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                          maxLength: 63,
                          textEditController: _domainController,
                          hintText: '',
                          height: null,
                          isRequired: true,
                          validator: Validator.apply(context, [DomainValidation()]),
                          suffixIcon: (!_domainController.text.contains(getIt<Configuration>().branchUrl))
                              ? Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  Text('.${getIt<Configuration>().branchUrl}  '),
                                ])
                              : null),
                      context.sizedBoxHeightExtraSmall,
                      RegionsDropDownWidget(
                        mandatoryChar: '*',
                        onCountryChanged: ({countryCode}) => _selectedCountryCode(countryCode ?? ''),
                        onCityChanged: (RegionData selectedItem) {
                          _selectedRegion = selectedItem;
                        },
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text('${S.current.businessAddress}*',
                          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        isRequired: true,
                        hintText: S.current.businessAddress,
                        textEditController: _businessAddressController,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        minLines: 4,
                        maxLines: 4,
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text('${S.current.emailAddress}*',
                          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        hintText: S.current.emailAddress,
                        isRequired: true,
                        validator: Validator.apply(context, [EmailValidation()]),
                        textEditController: _emailController,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      context.sizedBoxHeightExtraSmall,
                      Text('${S.current.phoneNumber}*',
                          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      context.sizedBoxHeightMicro,
                      RoundedTextInputWidget(
                        hintText: '234567891',
                        isRequired: true,
                        keyboardType: TextInputType.number,
                        prefixWidget: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('   +'),
                            /*  Obx(
                                () => Visibility(
                                  visible: !_phoneController.text.startsWith(_selectedCountryCode.value.replaceAll('+', '')),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 6),
                                    child: Text(
                                      _selectedCountryCode.value,
                                      style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),*/
                          ],
                        ),
                        textEditController: _phoneController,
                        maxLength: 12,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      context.sizedBoxHeightDefault,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.showBackButton)
                            RoundedBtnWidget(
                              onTap: () => Get.back(),
                              btnText: S.current.back,
                              height: 40,
                              btnMargin: EdgeInsets.zero,
                              bgColor: Colors.transparent,
                              btnTextColor: AppColors.black,
                              btnIcon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: AppColors.black,
                                size: 15,
                              ),
                            ),
                          BlocConsumer<SignUpBloc, SignUpState>(
                            listener: (context, state) {
                              if (state is CreateBranchStates && state.isSuccess) {
                                context.showCustomeAlert(S.current.yourBranchCreatedSuccessfully);
                                widget.goNextPage();
                              } else if (state is CreateBranchStates && state.error != null) {
                                context.showCustomeAlert(state.error);
                              }
                            },
                            builder: (context, state) {
                              return (state is CreateBranchStates && state.isLoading)
                                  ? const LoadingWidget()
                                  : RoundedBtnWidget(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<SignUpBloc>().add(CreateBranchEvent(
                                                domainText: _domainController.text.trim(),
                                                name: _branchNameController.text.trim(),
                                                phoneNumber: '+${_phoneController.text.trim()}',
                                                email: _emailController.text.trim(),
                                                branchAddress: _businessAddressController.text.trim(),
                                                businessTypeId: _selectedBusinessType!,
                                                selectedCityId: _selectedRegion?.cityId,
                                                countryId: _selectedRegion!.countryId!,
                                                cityName: _selectedRegion!.cityName!,
                                              ));
                                        }
                                      },
                                      btnText: widget.nextButtonText ?? S.current.save,
                                      width: 100,
                                      height: 40,
                                    );
                            },
                          ),
                        ],
                      ),
                      context.sizedBoxHeightExtraSmall,
                    ],
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
