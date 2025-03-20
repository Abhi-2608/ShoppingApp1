import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// MVVM
// auth  -> service (function) -> repo 
// view -> vm (function) -> repo
//
// repo  

class PermissionManager extends GetxController {
  RxBool contactReadPermission = false.obs;
  RxBool smsReadPermission = false.obs;
  RxBool sendNotificationPermission = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPermissions();
  }

  Future<void> loadPermissions() async {
    contactReadPermission.value = await Permission.contacts.status.isGranted;
    smsReadPermission.value = await Permission.sms.status.isGranted;
    sendNotificationPermission.value =
        await Permission.notification.status.isGranted;
  }

  /*
    common  func to request a specific permission from the user 
       usage : sms read permission:
       permissionManager.requestPermission(Permission.sms, permissionManager.smsReadPermission);
   */

  Future<void> requestPermission(
      Permission permission, RxBool permissionObs) async {
    if (!permissionObs.value) {
      if (await permission.status.isDenied) {
        await permission.request();
      }
      permissionObs.value = await permission.status.isGranted;
    }
  }
}
