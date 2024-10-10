// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:uni_links/uni_links.dart';
//
// Future<void> initDynamicLinks() async {
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//
//   dynamicLinks.onLink.listen((dynamicLinkData) {
//     // Get.offAllNamed(getIt<IUserSession>().hasToken() ? AppRoutes.mainRoute : AppRoutes.loginRoute);
//   }).onError((error) {
//     if (kDebugMode) {
//       print('onLink error');
//     }
//     print(error.message);
//   });
// }
//
// Future<void> initUniLinks() async {
//   // Platform messages may fail, so we use a try/catch PlatformException.
//   try {
//     final initialLink = await getInitialLink();
//     // Parse the link and warn the user, if it is not correct,
//     // but keep in mind it could be `null`.
//     // Get.offAllNamed(getIt<IUserSession>().hasToken() ? AppRoutes.mainRoute : AppRoutes.loginRoute);
//   } on PlatformException {
//     // Handle exception by warning the user their action did not succeed
//     // return?
//   }
// }
