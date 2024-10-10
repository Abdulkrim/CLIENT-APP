import 'package:flutter/material.dart';
import 'package:merchant_dashboard/core/utils/global.dart';
import 'package:merchant_dashboard/generated/l10n.dart';

class MissingSaveDataAlert extends StatelessWidget {
  final Function onYesTapped;
  const MissingSaveDataAlert({super.key, required this.onYesTapped});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(S.current.attention),
      content: Text(S.current.areYouSureWantToLeaveWhitOutSaveData),
      actions: [
        TextButton(
          onPressed: () {
            onYesTapped();
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

showMissingSaveDataAlert({required Function onYesTapped}) => showDialog(
      context: GlobalRoutingKeys.navigationKey.currentContext!,
      builder: (context) => MissingSaveDataAlert(
        onYesTapped: () {
          onYesTapped();
        },
      ),
    );
