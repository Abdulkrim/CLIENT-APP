import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/auth/presentation/widgets/desktop/desktop_login_form_widget.dart';
import 'package:merchant_dashboard/feature/auth/presentation/widgets/desktop/desktop_register_form_widget.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../generated/l10n.dart';

class DeskTopLoginScreen extends StatefulWidget {
  const DeskTopLoginScreen({Key? key, required this.isSignUpDefault}) : super(key: key);

  final bool isSignUpDefault;

  @override
  State<DeskTopLoginScreen> createState() => _DeskTopLoginWidgetState();
}

class _DeskTopLoginWidgetState extends State<DeskTopLoginScreen> with DownloadUtils {
  late bool _showLoginForm = !widget.isSignUpDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 20),
        decoration:
            const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.bgAuthBg), fit: BoxFit.fill)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: Get.width * 0.35,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  context.sizedBoxHeightDefault,
                  SvgPicture.asset(
                    Assets.logoCatalogakLogo,
                    width: 30,
                    height: 50,
                  ),
                  context.sizedBoxHeightDefault,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _showLoginForm
                        ? DesktopLoginFormWidget(
                            onRegisterFormTapped: () => setState(() => _showLoginForm = false),
                          )
                        : DesktopRegisterFormWidget(
                            onLoginFormTapped: () => setState(() => _showLoginForm = true)),
                  ),
                  context.sizedBoxHeightExtraSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(text: '${S.current.contactUs}:', style: context.textTheme.titleMedium),
                          TextSpan(
                              text: ' +971 800 9922',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: context.colorScheme.primaryColor,
                              )),
                        ])),
                        context.sizedBoxWidthMicro,
                        FloatingActionButton(
                            backgroundColor: Colors.green,
                            shape: const CircleBorder(),
                            mini: true,
                            onPressed: () => openWhatsAppLink(),
                            child: Image.asset(
                              Assets.iconsWhatsapp,
                              width: 20,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  context.sizedBoxHeightDefault,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () async => await openLink(
                            url:
                                'https://play.google.com/store/apps/details?id=catalogak.client.ae.altkamul'),
                        icon: SvgPicture.asset(
                          Assets.iconsGoogleplay,
                          width: 150,
                        ),
                      ),
                      context.sizedBoxWidthExtraSmall,
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () async => await openLink(
                            url: 'https://apps.apple.com/th/app/client-catalogak-app/id6469781733'),
                        icon: SvgPicture.asset(
                          Assets.iconsAppstore,
                          width: 135,
                        ),
                      ),
                    ],
                  ),
                  context.sizedBoxHeightLarge,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
