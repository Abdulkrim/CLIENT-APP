import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/main_screen/presentation/blocs/main_screen_bloc.dart';
import 'package:merchant_dashboard/injection.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/app_status_toggle_widget.dart';
import '../../../../widgets/tooltip_widget.dart';
import '../blocs/notifications_bloc.dart';

class SmsSettingsWidget extends StatefulWidget {
  const SmsSettingsWidget({super.key});

  @override
  State<SmsSettingsWidget> createState() => _SmsSettingsWidgetState();
}

class _SmsSettingsWidgetState extends State<SmsSettingsWidget> with DownloadUtils {
  @override
  void initState() {
    super.initState();

  }

  bool _isSmsAllowed = true;
  num _smsBalance = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state is GetNotificationSettingsStates && state.isSuccess) {
          _isSmsAllowed = context.read<NotificationsBloc>().smsNotification!.smsAllowed;
          _smsBalance = context.read<NotificationsBloc>().smsNotification!.smsBalance;
        }
      },
      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            TooltipWidget(text: S.current.smsAllowedTooltip),
            context.sizedBoxWidthMicro,
            Text(S.current.smsAllowed, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            AppSwitchToggle(
              label: _isSmsAllowed ? S.current.active : S.current.inActive,
              currentStatus: _isSmsAllowed,
              onStatusChanged: (status) {
                setState(() => _isSmsAllowed = status);

                context.read<NotificationsBloc>().add(UpdateNotificationSettings(_isSmsAllowed));
              },
              scale: .7,
            ),
          ]),
          Text('Your current balance: $_smsBalance  ',
              style: context.textTheme.bodyMedium?.copyWith(color: _smsBalance == 0 ? Colors.grey : Colors.black)),
          RoundedBtnWidget(
            onTap: () => openWhatsAppLink(
                defaultText:
                    'Requesting SMS balance top up\nBranchId: ${getIt<MainScreenBloc>().selectedMerchantBranch.merchantId}\nBranchName: ${getIt<MainScreenBloc>().selectedMerchantBranch.merchantName}'),
            btnText: 'Top up',
            btnPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          ),
        ],
      ),
    );
  }
}
