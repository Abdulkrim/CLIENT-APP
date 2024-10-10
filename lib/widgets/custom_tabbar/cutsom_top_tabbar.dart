import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/theme/theme_data.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'tab_item.dart';
import 'tabbar_utils.dart';

class CustomTopTabbar extends StatefulWidget {
  const CustomTopTabbar({
    super.key,
    required this.tabs,
    this.height = 38,
    this.selectedColor,
    this.tabBackgroundColor = const Color(0xfff2f2f2),
    this.initialSelection = 0,
    this.hasShadow = false,
    this.tabBorderRadius,
    this.tabBackgroundBorder,
  });
  final List<TabItem> tabs;
  final double height;
  final Color? selectedColor;
  final Color? tabBackgroundBorder;
  final Color tabBackgroundColor;
  final BorderRadiusGeometry? tabBorderRadius;
  final int initialSelection;
  final bool hasShadow;

  @override
  State<CustomTopTabbar> createState() => _CustomTopTabbarState();
}

class _CustomTopTabbarState extends State<CustomTopTabbar> {
  late double itemHeight = widget.height;

  late int _selectedTabIndex = widget.initialSelection;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
          color: widget.tabBackgroundColor,
          boxShadow: widget.hasShadow? AppStyles.boxShadow: null,
          borderRadius: widget.tabBorderRadius ?? BorderRadius.circular(8),
          border: widget.tabBackgroundBorder != null
              ? Border.all(color: widget.tabBackgroundBorder!, width: .8)
              : null),
      child: SizedBox(
        width: Get.width,
        height: itemHeight,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedPositioned(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 400),
                left: getLeftSpaceTopTabBar(
                    tabWidth: constraints.maxWidth,
                    currentPos: _selectedTabIndex,
                    tabItemsCount: widget.tabs.length),
                child: Container(
                  height: itemHeight,
                  width: getTopTabBarSelectedBoxWidth(
                      tabWidth: constraints.maxWidth, tabItemsCount: widget.tabs.length),
                  decoration: BoxDecoration(
                    color: widget.selectedColor ?? context.colorScheme.primaryColor,
                    borderRadius: widget.tabBorderRadius ?? BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0f000000),
                        offset: Offset(0, 4),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: itemHeight,
                child: Row(
                    children: widget.tabs
                        .asMap()
                        .map((index, tabItem) => MapEntry(
                              index,
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedTabIndex = index;
                                    });
                                    if (tabItem.onTap != null) tabItem.onTap!(index);
                                  },
                                  child: Text(
                                    tabItem.title,
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.labelLarge?.copyWith(
                                      color: _selectedTabIndex == index ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .values
                        .toList()),
              ),
            ],
          );
        }),
      ),
    );
  }
}
