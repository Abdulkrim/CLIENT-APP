import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/tables/presentation/blocs/cubit/table_cubit.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../widgets/loading_widget.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../table_details_widget.dart';
import '../table_item_widget.dart';

class DesktopTablesManagement extends StatelessWidget {
  const DesktopTablesManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.watch<MenuDrawerCubit>().selectedPageContent.text,
                    style: context.textTheme.titleLarge,
                  ),
                  context.sizedBoxWidthMicro,
                  IconButton(
                      onPressed: () => context.read<TableCubit>().getAllTables(),
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Colors.black,
                      )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: RoundedBtnWidget(
                      onTap: () {
                        Get.dialog(BlocProvider<TableCubit>.value(
                          value: BlocProvider.of<TableCubit>(context),
                          child: const TableDetailsWidget(),
                        ));
                      },
                      btnPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      btnIcon: SvgPicture.asset(
                        Assets.iconsTablesIcon,
                        color: Colors.white,
                        width: 20,
                      ),
                      btnText: S.current.addTable,
                    ),
                  ))
                ],
              ),
              context.sizedBoxHeightSmall,
              Expanded(
                  child: ScrollableWidget(
                child: Wrap(
                  children: context
                      .select((TableCubit bloc) => bloc.tables)
                      .map((e) => TableItemWidget(
                            table: e,
                          ))
                      .toList(),
                ),
              ))
            ],
          ),
        ),
        Center(
          child: BlocBuilder<TableCubit, TableState>(
            builder: (context, state) {
              return Visibility(
                visible: (state is GetTableStates && state.isLoading),
                child: const LoadingWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}
