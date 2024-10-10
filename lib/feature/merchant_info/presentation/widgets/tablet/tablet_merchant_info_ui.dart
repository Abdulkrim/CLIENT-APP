import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/merchant_info/data/models/entity/merchant_information.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/blocs/merchant_info_bloc.dart';
import 'package:merchant_dashboard/feature/merchant_info/presentation/widgets/desktop/desktop_merchant_info_body_widget.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';

import '../../../../main_screen/presentation/blocs/menu_drawer/menu_drawer_cubit.dart';

class TabletMerchantInfoUI extends StatelessWidget {
  const TabletMerchantInfoUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.watch<MenuDrawerCubit>().selectedPageContent.text,
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
        /* Row(
          children: [
            Expanded(
                child: MerchantLogoWidget(
              title: S.current.defaultLogo,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.defaultLogoLink ?? ''),
              logoKey: LogoTypes.defaulltLogo.typeId,
            )),
            Expanded(
                child: MerchantLogoWidget(
              title: S.current.logo,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.logoLink ?? ''),
              logoKey: LogoTypes.logo.typeId,
            )),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: MerchantLogoWidget(
              title: S.current.footerLogo,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.footerLogoLink ?? ''),
              logoKey: LogoTypes.footerLogo.typeId,
            )),
            Expanded(
                child: MerchantLogoWidget(
              title: S.current.logoPrinting,
              url: context.select<MerchantInfoBloc, String>((value) => value.merchantInformation?.printingLogoLink ?? ''),
              logoKey: LogoTypes.printingLogo.typeId,
            )),
          ],
        ), */
        context.sizedBoxHeightSmall,
        DesktopMerchantInfoBodyWidget(
          merchantInformation:
              context.select<MerchantInfoBloc, MerchantInformation?>((value) => value.merchantInformation),
        ),
      ],
    );
  }
}
