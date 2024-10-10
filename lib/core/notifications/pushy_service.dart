import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_dashboard/main.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

class PushyService {
  static Future init() async {
    Pushy.listen();
    await PushyService.pushyRegister();
    Pushy.setNotificationListener(backgroundNotificationListener);
    Pushy.setNotificationIcon('ic_notification');
  }

  static Future pushyRegister() async {
    try {
      String deviceToken = await Pushy.register();
      debugPrint('Pushy device token: $deviceToken');
      debugPrint('Pushy device token: $deviceToken');

      /// getIt<Logger>().i('Pushy device token: $deviceToken');
    } on PlatformException catch (error) {
      // Display an alert with the error message
      /// getIt<Logger>().e('Pushy Error: $error');
      debugPrint('Pushy Error: $error');
    }
  }

  static Future pushySubscribeToOrderManagementTopic(String branchID) async {
    if (branchID == '0') {
      return;
    }
    debugPrint('subscribe client_order_management_$branchID');
    debugPrint('client_order_management_$branchID');
    Pushy.subscribe('client_order_management_$branchID');
  }

  static Future pushyUnSubscribeToOrderManagementTopic(String branchID) async {
    if (branchID == '0') {
      return;
    }
    debugPrint('client_order_management_$branchID');
    print('unsubscribe client_order_management_$branchID');
    Pushy.unsubscribe('client_order_management_$branchID');
  }
}
