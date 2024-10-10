import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/area_management/data/data_source/area_management_remote_datasource.dart';
import 'package:merchant_dashboard/feature/business_hours/data/data_source/branch_shifts_remote_datasource.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/feature/tables/presentation/widgets/table_qr_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/utils/responsive_widgets/responsive_dialog_widget.dart';
import 'package:merchant_dashboard/widgets/app_ink_well_widget.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../data/models/entity/table.dart' as ent;

import '../../../../theme/theme_data.dart';
import '../blocs/cubit/table_cubit.dart';
import 'table_details_widget.dart';

class TableItemWidget extends StatefulWidget {
  const TableItemWidget({
    super.key,
    required this.table,
    this.tableWidth = 160,
    this.tableHeight = 160,
    this.chairHeight = 6,
    this.chairWidth = 60,
    this.itemPadding = const EdgeInsets.only(right: 20 , top:20 , left: 20),
  });

  final ent.Table table;
  final double tableWidth;
  final double tableHeight;
  final double chairHeight;
  final double chairWidth;
  final EdgeInsetsGeometry itemPadding;

  @override
  State<TableItemWidget> createState() => _TableItemWidgetState();
}

class _TableItemWidgetState extends State<TableItemWidget> with DownloadUtils {
  bool _showEditButton = false;
  late String tableLink;
  final angle = .45;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tableLink =
        'https://${context.select((MainScreenBloc bloc) => bloc.branchGeneralInfo?.domainAddress)}/?tableId=${widget.table.id}';

    return Padding(
      padding: widget.itemPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.tableWidth,
            height: widget.tableHeight,
            child: Stack(children: [
              Center(
                child: AppInkWell(
                  onHover: (value) => setState(() => _showEditButton = value),
                  onTap: () {
                    Get.dialog(BlocProvider<TableCubit>.value(
                      value: BlocProvider.of<TableCubit>(context),
                      child: TableDetailsWidget(
                        table: widget.table,
                      ),
                    ));
                  },
                  child: Container(
                    width: widget.tableWidth - 30,
                    height: widget.tableHeight - 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle, border: Border.all(color: AppColors.gray2, width: widget.chairHeight)),
                    child: !_showEditButton
                        ? Text(
                            widget.table.tableName ?? widget.table.tableNumber?.toString() ?? '-',
                            style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          )
                        : const Icon(
                            Icons.mode_edit_outline_rounded,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: 25,
                right: 0,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 1,
                  child: Transform.rotate(
                    angle: -angle,
                    child: Container(
                      height: widget.chairWidth,
                      width: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                right: 0,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 2,
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      height: widget.chairWidth,
                      width: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 25,
                left: 0,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 3,
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      height: widget.chairWidth,
                      width: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 0,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 4,
                  child: Transform.rotate(
                    angle: -angle,
                    child: Container(
                      height: widget.chairWidth,
                      width: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 25,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 5,
                  child: Transform.rotate(
                    angle: -angle,
                    child: Container(
                      width: widget.chairWidth,
                      height: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 25,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 6,
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      width: widget.chairWidth,
                      height: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 25,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 7,
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      width: widget.chairWidth,
                      height: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 25,
                child: Visibility(
                  visible: widget.table.tableCapacity >= 8,
                  child: Transform.rotate(
                    angle: -angle,
                    child: Container(
                      width: widget.chairWidth,
                      height: widget.chairHeight,
                      decoration: BoxDecoration(
                        color: AppColors.gray2,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          context.sizedBoxHeightExtraSmall,
          TextButton(
              onPressed: () async => openLink(url: tableLink),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Catalogak link ',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const WidgetSpan(
                    child: Icon(
                  Icons.copy_rounded,
                  size: 15,
                  color: Colors.black,
                ))
              ]))),
          RoundedBtnWidget(
            onTap: () async {
              Get.dialog(TableQrWidget(
                tableLink: tableLink,
              ));
            },
            btnPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            btnText: 'Download QR',
            boxBorder: Border.all(color: Colors.black),
            bgColor: Colors.transparent,
            btnTextColor: Colors.black,
            leadingIcon: const Icon(
              Icons.qr_code_2_rounded,
              color: Colors.black,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
