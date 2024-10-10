import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/assets.dart';
import '../../../../../widgets/loading_widget.dart';
import '../../../../../widgets/rounded_btn.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';
import '../../blocs/cubit/table_cubit.dart';
import '../table_details_widget.dart';
import '../table_item_widget.dart';

class MobileTablesManagement extends StatelessWidget {
  const MobileTablesManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final tables = context.select((TableCubit bloc) => bloc.tables);
    return   Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      context.watch<MenuDrawerCubit>().selectedPageContent.text,
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  RoundedBtnWidget(
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
                    btnText: 'Add Table',
                  )
                ],
              ),
              context.sizedBoxHeightSmall,
              Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<TableCubit>().getAllTables();
                      return Future<void>.delayed(const Duration(seconds: 2));
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(

                        child: Wrap(
                          children: tables.map((e) => TableItemWidget(
                            table: e,
                            itemPadding:   EdgeInsets.only(right: 10, top: 10, left: 10),
                            tableWidth : 130,
                             tableHeight : 130,
                            chairHeight : 4,
                            chairWidth : 40,
                          ),).toList(),
                        ),
                      ),
                    )
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
        )
      ],
    );
  }
}
