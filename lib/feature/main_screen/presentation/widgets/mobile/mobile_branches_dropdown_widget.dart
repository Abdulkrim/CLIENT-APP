import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/entity/merchant_info.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/branch_item_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../region/presentation/blocs/region_cubit.dart';
import '../../../../signup/presentation/blocs/sign_up_bloc.dart';
import '../../../../signup/presentation/widgets/create_branch_dialog.dart';

class MobileBranchesDropDownWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final bool isExpanded;

  final TextEditingController _searchController = TextEditingController();

  MobileBranchesDropDownWidget({Key? key, this.height, this.width, this.isExpanded = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       /* IconButton(
            onPressed: () => showModalBottomSheet(
                context: context,
                constraints: BoxConstraints.tightFor(height: context.mediaQuerySize.height * .9),
                isScrollControlled: true,
                builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: BlocProvider.of<SignUpBloc>(context)),
                        BlocProvider.value(value: BlocProvider.of<RegionCubit>(context)),
                      ],
                      child: CreateBranchDialog(
                        nextButtonText: S.current.save,
                        goNextPage: () {
                          Get.back();
                        },
                      ),
                    )),
            icon: SvgPicture.asset(
              Assets.iconsAddIcon,
              width: 20,
              color: Colors.grey,
            )),*/
        Expanded(
          child: DropdownSearch<MerchantInfo>(
            filterFn: (user, filter) => (user.merchantId.contains(filter) ||
                user.merchantName.toLowerCase().contains(filter.toLowerCase())),
            items: context.select<MainScreenBloc, List<MerchantInfo>>((value) => value.merchantItems),
            selectedItem:
                context.select<MainScreenBloc, MerchantInfo>((value) => value.selectedMerchantBranch),
            clearButtonProps: const ClearButtonProps(isVisible: false),
            onChanged: (value) => context.read<MainScreenBloc>().add(MerchantSelectedChangedEvent(value!)),
            popupProps: PopupProps.bottomSheet(
                showSelectedItems: true,
                itemBuilder: (context, item, isSelected) => BranchItemWidget(
                      isSelected: isSelected,
                      item: item,
                    ),
                showSearchBox: true,
                containerBuilder: (context, popupWidget) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: ColoredBox(
                                color: AppColors.transparentGrayColor,
                                child: const SizedBox(
                                  width: 200,
                                  height: 2,
                                ),
                              )),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: popupWidget,
                          ),
                        ),
                      ],
                    ),
                searchFieldProps: TextFieldProps(
                  autofocus: true,
                  controller: _searchController,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear_rounded,
                        size: 15,
                        color: AppColors.black,
                      ),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                  ),
                ),
                bottomSheetProps: BottomSheetProps(
                  elevation: 15,
                  backgroundColor: AppColors.white,
                )),
            compareFn: (item, selectedItem) => item.merchantId == selectedItem.merchantId,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
            dropdownBuilder: (context, selectedItem) => SvgPicture.asset(
              Assets.iconsSelectBranch,
            ),
          ),
        ),
      ],
    );
  }
}
