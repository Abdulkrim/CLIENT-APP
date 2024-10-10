import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/data/models/entity/merchant_info.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/widgets/branch_item_widget.dart';
import 'package:merchant_dashboard/feature/region/presentation/blocs/region_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../signup/presentation/blocs/sign_up_bloc.dart';
import '../../../../signup/presentation/widgets/create_branch_dialog.dart';

class DesktopBranchesDropDownWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final bool isExpanded;

  final TextEditingController _searchController = TextEditingController();

  DesktopBranchesDropDownWidget({Key? key, this.height, this.width, this.isExpanded = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context
          .select<MainScreenBloc, bool>((value) => value.loggedInMerchantInfo?.isLoggedInUserG ?? true),
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: DropdownSearch<MerchantInfo>(
          filterFn: (user, filter) => (user.merchantId.contains(filter) ||
              user.merchantName.toLowerCase().contains(filter.toLowerCase())),
          items: context.select<MainScreenBloc, List<MerchantInfo>>((value) => value.merchantItems),
          selectedItem: context.select<MainScreenBloc, MerchantInfo>((value) => value.selectedMerchantBranch),
          clearButtonProps: ClearButtonProps(
            icon: Icon(
              Icons.clear_rounded,
              size: 15,
              color: AppColors.black,
            ),
            isVisible: context.read<MainScreenBloc>().showSelectedBranchClearBtn(),
            onPressed: () {
              context.read<MainScreenBloc>().add(const ManualBranchSelectionEvent(isReset: true));
            },
          ),
          onChanged: (value) => context.read<MainScreenBloc>().add(MerchantSelectedChangedEvent(value!)),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSelectedItems: true,
            menuProps: const MenuProps(
              backgroundColor: Colors.transparent,
              elevation: 9,
            ),
            containerBuilder: (ctx, popupWidget) {
              return Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: popupWidget,
              );
            },
            itemBuilder: (context, item, isSelected) => BranchItemWidget(
              isSelected: isSelected,
              item: item,
            ),
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              autofocus: false,
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              controller: _searchController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: context.colorScheme.primaryColor, width: .5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 223, 223, 223), width: .5),
                ),
                filled: true,
                fillColor: AppColors.white,
                hintStyle: const TextStyle(color: Colors.grey),
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
          ),
          compareFn: (item, selectedItem) => item.merchantId == selectedItem.merchantId,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: context.colorScheme.primaryColor, width: .5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColors.gray2, width: .5),
              ),
              filled: true,
              fillColor: AppColors.white,
            ),
          ),
          dropdownBuilder: (context, selectedItem) => SizedBox(
            height: 30,
            child: Row(
              children: [
               /* IconButton(
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                    onPressed: () => Get.dialog(MultiBlocProvider(
                          providers: [
                            BlocProvider<SignUpBloc>.value(value: BlocProvider.of<SignUpBloc>(context)),
                            BlocProvider<RegionCubit>.value(value: BlocProvider.of<RegionCubit>(context))
                          ],
                          child: CreateBranchDialog(
                            width: context.mediaQuerySize.width * .6,

                            nextButtonText: S.current.save,
                            goNextPage: () {
                              Get.back();
                            },
                          ),
                        )),
                    icon: SvgPicture.asset(
                      Assets.iconsAddIcon,
                      width: 20,
                    )),*/
                Expanded(
                  child: Text(
                    selectedItem?.merchantName ?? '-',
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 // todo: create a searchable dropdown for all sections