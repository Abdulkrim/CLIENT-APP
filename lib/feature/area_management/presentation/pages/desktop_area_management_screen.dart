import 'package:flutter/material.dart';
import 'package:merchant_dashboard/feature/area_management/data/models/entity/area_item.dart';
import 'package:merchant_dashboard/feature/area_management/presentation/widgets/area_details_widget.dart';
import 'package:merchant_dashboard/feature/area_management/presentation/widgets/desktop/desktop_areas_table_widget.dart';

class DesktopAreaManagementScreen extends StatefulWidget {
  const DesktopAreaManagementScreen({super.key});

  @override
  State<DesktopAreaManagementScreen> createState() => _DesktopAreaManagementScreenState();
}

class _DesktopAreaManagementScreenState extends State<DesktopAreaManagementScreen> {
  final _pageViewController = PageController();

  AreaItem? _selectedAreaItem;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageViewController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: DesktopAreasTableWidget(
            onAreaDetailsTap: (areaItem) {
              setState(() {
                _selectedAreaItem = areaItem;
              });
              _pageViewController.jumpToPage(1);
            },
          ),
        ),
        AreaDetailsWidget(
            areaItem: _selectedAreaItem,
            onBackTap: () {
              setState(() {
                _selectedAreaItem = null;
              });
              _pageViewController.jumpToPage(0);
            }),
      ],
    );
  }
}
