import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/report/presentation/pages/products/product_reports_screen.dart';
import 'package:merchant_dashboard/feature/report/presentation/pages/sub_categories/sub_category_reports_screen.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../generated/l10n.dart';
import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';

class DesktopCategorizedReportsScreen extends StatefulWidget {
  const DesktopCategorizedReportsScreen({super.key});

  @override
  State<DesktopCategorizedReportsScreen> createState() => _DesktopCategorizedReportsScreenState();
}

class _DesktopCategorizedReportsScreenState extends State<DesktopCategorizedReportsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.watch<MenuDrawerCubit>().selectedPageContent.text,
                  style: context.textTheme.titleLarge,
                ),
              ),
              Expanded(child:   TabBar(controller: _tabController ,  tabs: [
                Tab(text: S.current.subcategory),
                Tab(text: S.current.products),
              ]),),
            ],
          ),

          context.sizedBoxHeightExtraSmall,
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: const [
              SubCategoryReportScreen(),
              ProductReportsScreen(),
            ],
          )),
        ],
      ),
    );
  }
}
