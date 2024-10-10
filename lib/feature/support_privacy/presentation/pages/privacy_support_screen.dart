import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:merchant_dashboard/feature/support_privacy/presentation/blocs/cubit/privacy_cubit.dart';
import 'package:merchant_dashboard/feature/support_privacy/presentation/widgets/mobile/delete_account_screen.dart';
import 'package:merchant_dashboard/generated/assets.dart';
import 'package:merchant_dashboard/generated/l10n.dart';
import 'package:merchant_dashboard/utils/extensions/extensions.dart';
import 'package:merchant_dashboard/widgets/rounded_btn.dart';
import 'package:merchant_dashboard/widgets/scrollable_widget.dart';

import '../../../../theme/theme_data.dart';
import '../../../../utils/mixins/mixins.dart';
import '../../../settings/presentation/widgets/desktop/contact_us_info_widget.dart';

class PrivacySupportScreen extends StatelessWidget with DownloadUtils {
  PrivacySupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableWidget(
      scrollViewPadding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 25),
          width: 380,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Color(0x0f000000),
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ], color: AppColors.white, borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const ContactUsInfoWidget(),
            context. sizedBoxHeightSmall,
          ]),
        ),
        context.sizedBoxHeightSmall,
        Visibility(
            visible: !kIsWeb,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.policyPrivacy,
                  style: context.textTheme.titleLarge,
                ),
                context.sizedBoxHeightExtraSmall,
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 25),
                    width: 380,
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(
                        color: Color(0x0f000000),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ], color: AppColors.white, borderRadius: const BorderRadius.all(Radius.circular(30))),
                    child: const Text("""
Client App Privacy Policy
Altkamul Altiqani Computers built the Client app as an [open source/free/freemium/ad-supported/commercial] app. This SERVICE is provided by Altkamul Altiqani Computers at no cost and is intended for use as is. This page is used to inform visitors regarding [my/our] policies regarding the collection, use, and disclosure of Personal Information if anyone decides to use [my/our] Service. If you choose to use [my/our] Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that [I/We] collect is used for providing and improving the Service. [I/We] will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Client App unless otherwise defined in this Privacy Policy.

Information Collection and Use
For a better experience, while using our Service, [I/We] may require you to provide us with certain personally identifiable information. The information that [I/We] request will be [retained on your device and is not collected by [me/us] in any way]/[retained by us and used as described in this privacy policy].

The app does use third-party services that may collect information used to identify you.

Link to privacy policy of third-party service providers used by the app

Google Play Services
Facebook
Log Data
[I/We] want to inform you that whenever you use [my/our] Service, in a case of an error in the app [I/We] collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing [my/our] Service, the time and date of your use of the Service, and other statistics.

Cookies
Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers
[I/We] may employ third-party companies and individuals due to the following reasons:

To facilitate our Service;
To provide the Service on our behalf;
To perform Service-related services; or
To assist us in analysing how our Service is used.
[I/We] want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

Security
[I/We] value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and [I/We] cannot guarantee its absolute security.

Links to Other Sites
This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by [me/us]. Therefore, [I/We] strongly advise you to review the Privacy Policy of these websites. [I/We] have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

Children’s Privacy
These Services do not address anyone under the age of 13. [I/We] do not knowingly collect personally identifiable information from children under 13 years of age. In the case [I/We] discover that a child under 13 has provided [me/us] with personal information, [I/We] immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact [me/us] so that [I/We] will be able to do the necessary actions.

Changes to This Privacy Policy
[I/We] may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. [I/We] will notify you of any changes by posting the new Privacy Policy on this page.
This policy is effective as of 2023-01-01

Contact Us
If you have any questions or suggestions about [my/our] Privacy Policy, do not hesitate to contact [me/us] at info@altkamul.com.
""")),
                context.sizedBoxHeightSmall,
                Hero(
                  tag: 'delete_account',
                  child: SvgPicture.asset(
                    Assets.iconsDeleteUser,
                    width: 100,
                  ),
                ),
                context.sizedBoxHeightMicro,
                Center(
                  child: Text(
                    S.current.requestDeleteAccount,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                context.sizedBoxHeightExtraSmall,
                RoundedBtnWidget(
                  onTap: () {
                    (!kIsWeb ? Get.to : Get.dialog)(BlocProvider.value(
                      value: BlocProvider.of<PrivacyCubit>(context),
                      child: DeleteAccountScreen(),
                    ));
                  },
                  btnText: S.current.deleteAccount,
                  bgColor: Colors.red,
                  btnMargin: const EdgeInsets.symmetric(horizontal: 20),
                  btnPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                context.sizedBoxHeightDefault,
              ],
            )),
      ]),
    );
  }
}
