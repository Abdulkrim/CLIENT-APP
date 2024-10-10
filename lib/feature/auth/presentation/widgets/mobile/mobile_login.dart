import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/mixins/mixins.dart';
import '../desktop/desktop_register_form_widget.dart';
import 'mobile_login_form.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key, required this.isSignUpDefault}) : super(key: key);

  final bool isSignUpDefault;

  @override
  State<MobileLoginScreen> createState() => _MobileLoginWidgetState();
}

class _MobileLoginWidgetState extends State<MobileLoginScreen> with DownloadUtils {
  late bool _showLoginForm = !widget.isSignUpDefault;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [

        context.sizedBoxHeightDefault,
        SvgPicture.asset(
          Assets.logoCatalogakLogo,
          width: 30,
          height: 50,
        ),
        Expanded(
          flex: 2,
          child: ScrollableWidget(
            scrollViewPadding: const EdgeInsets.only(
              right: 32,
              left: 32,
              top: 50,
            ),
            child: Column(
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: _showLoginForm
                        ? MobileLoginFormWidget(
                            onRegisterFormTapped: () => setState(() => _showLoginForm = false),
                          )
                        : DesktopRegisterFormWidget(onLoginFormTapped: () => setState(() => _showLoginForm = true))),
                context.sizedBoxHeightExtraSmall,
                Row(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text:  '${S.current.contactUs}:', style: context.textTheme.titleMedium),
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
                context.sizedBoxHeightExtraSmall,
                Visibility(
                  visible: kIsWeb,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () async =>
                            await openLink(url: 'https://play.google.com/store/apps/details?id=catalogak.client.ae.altkamul'),
                        icon: SvgPicture.asset(
                          Assets.iconsGoogleplay,
                          width: 150,
                        ),
                      ),
                      context.sizedBoxWidthExtraSmall,
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: () async =>
                            await openLink(url: 'https://apps.apple.com/th/app/client-catalogak-app/id6469781733'),
                        icon: SvgPicture.asset(
                          Assets.iconsAppstore,
                          width: 135,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
