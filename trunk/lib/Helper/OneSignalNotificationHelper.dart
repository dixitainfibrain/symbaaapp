import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class OneSignalNotificationHelper{
  Future<void> initialize()async{
    OneSignal.initialize('ONESIGNAL_APP_ID'); /// Set OneSignal App id
    PermissionStatus notificationPermissionStatus = await Permission.notification.status; /// Ask User for Permission

    if (notificationPermissionStatus == PermissionStatus.denied ||
        notificationPermissionStatus == PermissionStatus.restricted ||
        notificationPermissionStatus == PermissionStatus.permanentlyDenied) {
      await OneSignal.Notifications.requestPermission(true); /// This Will Display Prompt to User for permission to receive push notifications.
    }

    /// Normal log
    OneSignal.User.pushSubscription.addObserver((stateChanges) {
      AppGlobal.printLog('------------------Onesignal Initialization------------------');
      AppGlobal.printLog('optedIn==> ${OneSignal.User.pushSubscription.optedIn}');
      AppGlobal.printLog('optedIn==> ${OneSignal.User.pushSubscription.id}');
      AppGlobal.printLog('token==> ${OneSignal.User.pushSubscription.token}');
      debugPrint('token==> ${OneSignal.User.pushSubscription.token}');
      AppGlobal.printLog('jsonRepresentation==> ${stateChanges.current.jsonRepresentation()}');
      debugPrint('jsonRepresentation==> ${stateChanges.current.jsonRepresentation()}');
    });


    /// Click event on Notification
    OneSignal.Notifications.addClickListener((event) {
      AppGlobal.printLog('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
      AppGlobal.printLog('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: ${event.notification.rawPayload}');

      Map<String, dynamic>? additionalData = event.notification.additionalData;
      String type = (additionalData?.isNotEmpty ?? false) ? additionalData!["type"] : "";

      /// Create Function for Redirect page when click on notification
    });


    /// When App id in Foreground
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      debugPrint('NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.additionalData}');
      debugPrint('NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// notification.display() to display after preventing default
      event.notification.display();

      Map<String, dynamic>? additionalData = event.notification.additionalData;
      String type = (additionalData?.isNotEmpty ?? false) ? additionalData!["type"] : "";

      /// Create Function for Redirect page when click on notification

      AppGlobal.printLog('notificationJson ==>1 $additionalData');
    });
  }
}