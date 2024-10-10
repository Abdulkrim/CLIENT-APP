import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({Key? key, required this.onLogoutClick}) : super(key: key);

  final Function onLogoutClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundedBtnWidget(
              onTap: () => onLogoutClick(),
              btnText: S.current.logout,
              height: 45.0,
              width: 290,
              btnIcon: SvgPicture.asset(Assets.iconsLogout),
            ),
          ),
        ),
      ],
    );
  }
}
