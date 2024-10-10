import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../generated/assets.dart';
import '../../../../../injection.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';

class ContactUsInfoWidget extends StatelessWidget with DownloadUtils {
  const ContactUsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(text: S.current.contactUs, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          TextSpan(
              text: S.current.today,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: context.colorScheme.primaryColor,
              )),
        ])),
        context.sizedBoxHeightExtraSmall,
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsPhone,
              color: context.colorScheme.primaryColor,
              width: 15,
            ),
            context.sizedBoxWidthMicro,
            RichText(
                text: TextSpan(children: [
              TextSpan(text: S.current.callUs, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '+971 (06) 5288988',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primaryColor,
                  )),
            ])),
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsWhatsappNumber,
              color: context.colorScheme.primaryColor,
              width: 15,
            ),
            context.sizedBoxWidthMicro,
            RichText(
                text: TextSpan(children: [
              TextSpan(text: '${S.current.whatsapp}: ', style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: ' +971 800 9922',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primaryColor,
                  )),
            ])),
            context.sizedBoxWidthMicro,
            FloatingActionButton(
                backgroundColor: Colors.green,
                shape: const CircleBorder(),
                mini: true,
                onPressed: () => openWhatsAppLink(
                    defaultText: (!getIt<MainScreenBloc>().selectedMerchantBranch.hasData)
                        ? ''
                        : "BranchId: ${getIt<MainScreenBloc>().selectedMerchantBranch.merchantId}\nBranchName: ${getIt<MainScreenBloc>().selectedMerchantBranch.merchantName}"),
                child: Image.asset(
                  Assets.iconsWhatsapp,
                  width: 20,
                  color: Colors.white,
                ))
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsOpenEmail,
              color: context.colorScheme.primaryColor,
              width: 15,
            ),
            context.sizedBoxWidthMicro,
            RichText(
                text: TextSpan(children: [
              TextSpan(text: S.current.email, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: ': info@altkamul.com',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primaryColor,
                  )),
            ])),
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.iconsLocation,
              color: context.colorScheme.primaryColor,
              width: 15,
            ),
            context.sizedBoxWidthMicro,
            Text(S.current.address, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text('Address: The City Gate Tower,\nOffice number 1703, 17th Floor\nAl Itihad Street - Sharjah - UAE',
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.primaryColor,
                )),
          ],
        ),
      ],
    );
  }
}
