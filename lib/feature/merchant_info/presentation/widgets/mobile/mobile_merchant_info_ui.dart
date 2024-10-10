import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/widgets/mobile/mobile_merchant_info_body_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';


class MobileMerchantInfoUI extends StatelessWidget {
  const MobileMerchantInfoUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /* MerchantLogoWidget(
              title: S.current.defaultLogo,
              margin: EdgeInsets.zero,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.defaultLogoLink ?? ''),
              logoKey: LogoTypes.defaulltLogo.typeId,
            ),
            context.sizedBoxHeightExtraSmall,
            MerchantLogoWidget(
              title: S.current.logo,
              margin: EdgeInsets.zero,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.logoLink ?? ''),
              logoKey: LogoTypes.logo.typeId,
            ),
            context.sizedBoxHeightExtraSmall,
            MerchantLogoWidget(
              title: S.current.footerLogo,
              margin: EdgeInsets.zero,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.footerLogoLink ?? ''),
              logoKey: LogoTypes.footerLogo.typeId,
            ),
            context.sizedBoxHeightExtraSmall,
            MerchantLogoWidget(
              title: S.current.logoPrinting,
              margin: EdgeInsets.zero,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.printingLogoLink ?? ''),
              logoKey: LogoTypes.printingLogo.typeId,
            ), */
          ],
        ),
        context.sizedBoxHeightExtraSmall,
        MobileMerchantInfoBodyWidget(
            merchantInformation:
                context.select<MerchantInfoBloc, MerchantInformation?>((value) => value.merchantInformation))
      ],
    );
  }
}
