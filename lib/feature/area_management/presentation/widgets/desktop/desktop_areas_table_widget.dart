import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/entity/area_item.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/utils/snack_alert/snack_alert.dart';
import 'package:merchant_dashboard/widgets/loading_widget.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../blocs/area_management_cubit.dart';

class DesktopAreasTableWidget extends StatelessWidget {
  final Function(AreaItem? areaItem) onAreaDetailsTap;

  const DesktopAreasTableWidget({Key? key, required this.onAreaDetailsTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
                IconButton(
                    onPressed: () => context.read<AreaManagementCubit>().getBranchAreas(),
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.black,
                    ))
              ],
            ),
            RoundedBtnWidget(
              onTap: () => onAreaDetailsTap(null),
              btnText: S.current.addArea,
              btnPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              leadingIcon: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 13,
              ),
            )
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        Expanded(
          child: Stack(
            children: [
              DecoratedBox(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: .2)),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                  // border: TableBorder(horizontalInside: BorderSide(color: Colors.grey, width: .2)),
                  children: [
                    context.headerTableRow([
                      S.current.no,
                      S.current.city,
                      S.current.area,
                      S.current.minimumOrder,
                      S.current.deliveryFee,
                      S.current.actions,
                    ], headerHasColor: false),
                    ...context
                        .watch<AreaManagementCubit>()
                        .areas
                        .map((e) => TableRow(children: [
                              TableCell(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            e.id.toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Divider(
                                          color: Colors.grey,
                                          height: .2,
                                          thickness: .2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            e.areaDetails?.cityName ?? '',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        height: .2,
                                        thickness: .2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            e.areaDetails?.areaName ?? '',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        height: .2,
                                        thickness: .2,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${e.minOrderAmount} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        height: .2,
                                        thickness: .2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '${e.deliveryFee} ${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.currency)}',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        height: .2,
                                        thickness: .2,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () => onAreaDetailsTap(e),
                                          icon: SvgPicture.asset(
                                            Assets.iconsIcEdit,
                                            height: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Get.dialog(ResponsiveDialogWidget(
                                                title: S.current.deleteArea,
                                                width: 240,
                                                height: 240,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      context.sizedBoxHeightExtraSmall,
                                                      SvgPicture.asset(
                                                        Assets.iconsColoredDeleteIcon,
                                                        height: 50,
                                                      ),
                                                      context.sizedBoxHeightExtraSmall,
                                                      Text(
                                                        S.current.areYouSureDeleteArea,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      context.sizedBoxHeightExtraSmall,
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: RoundedBtnWidget(
                                                            onTap: () => Get.back(),
                                                            height: 30,
                                                            btnText: S.current.no,
                                                            bgColor: Colors.transparent,
                                                            btnTextColor: Colors.black,
                                                            boxBorder: Border.all(
                                                              color: Colors.black,
                                                            ),
                                                          )),
                                                          Expanded(
                                                              child: RoundedBtnWidget(
                                                                  height: 30,
                                                                  onTap: () {
                                                                    Get.back();
                                                                    context.read<AreaManagementCubit>().deleteArea(id: e.id);
                                                                  },
                                                                  btnText: S.current.yes)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )));
                                          },
                                          icon: SvgPicture.asset(
                                            Assets.iconsDeleteIcon,
                                            height: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 40),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: .2,
                                        thickness: .2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]))
                        .toList(),
                  ],
                ),
              ),
              Center(
                  child: BlocConsumer<AreaManagementCubit, AreaManagementState>(
                      listener: (context, state) {
                        if ((state is DeleteAreaState || state is GetAreasState) && state.errorMessage != null) {
                          context.showCustomeAlert(state.errorMessage, SnackBarType.error);
                        } else if (state is DeleteAreaState && state.isSuccess) {
                          context.showCustomeAlert(S.current.areaDeletedSuccessfully, SnackBarType.success);
                        }
                      },
                      builder: (context, state) => Visibility(
                          visible: (state is GetAreasState || state is DeleteAreaState) && state.isLoading,
                          child: const LoadingWidget()))),
            ],
          ),
        ),
      ],
    );
  }
}
