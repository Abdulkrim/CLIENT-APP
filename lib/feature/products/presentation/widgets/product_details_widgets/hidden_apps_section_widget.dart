import 'package:flutter/material.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../../core/constants/defaults.dart';
import '../../../../../widgets/app_ink_well_widget.dart';
import '../../../data/models/entity/apps.dart';

class HiddenAppsSectionWidget extends StatefulWidget {
  const HiddenAppsSectionWidget({super.key, required this.preSelectedApps, required this.onSelectedAppsChanged});

  final List<String> preSelectedApps;
  final Function(List<String>) onSelectedAppsChanged;

  @override
  State<HiddenAppsSectionWidget> createState() => _HiddenAppsSectionWidgetState();
}

class _HiddenAppsSectionWidgetState extends State<HiddenAppsSectionWidget> {
  List<String> _selectedApps = [];

  @override
  void initState() {
    super.initState();

    _selectedApps = widget.preSelectedApps;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            S.current.selectVisibleApps,
          ),
        ),
        ...Apps.values
            .map(
              (e) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    e.name,
                    style: const TextStyle(
                      color: Color(0xff404040),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  context.sizedBoxWidthMicro,
                  AppInkWell(
                    onTap: () {
                      _selectedApps.contains(e.name) ? _selectedApps.remove(e.name) : _selectedApps.add(e.name);

                      // widget.onSelectedAppsChanged(_selectedApps);

                      setState(() {});
                    },
                    child: AnimatedContainer(
                      duration: Defaults.defaultAnimDuration,
                      height: 20,
                      width: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedApps.contains(e.name) ? context.colorScheme.primaryColor : null,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _selectedApps.contains(e.name) ? context.colorScheme.primaryColor : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  context.sizedBoxWidthExtraSmall,
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
