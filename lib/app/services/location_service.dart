import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService extends GetxService {
  Future<LocationService> init() async {
    Get.log('Requesting location permissions...');
    await requestLocationPermission();
    return this;
  }

  Future<void> requestLocationPermission() async {
    try {
      // Check current permission status
      PermissionStatus status = await Permission.location.status;

      if (status.isDenied) {
        // Request permission
        status = await Permission.location.request();
        
        if (status.isGranted) {
          Get.log('Location permission granted');
        } else if (status.isPermanentlyDenied) {
          Get.log('Location permission permanently denied');
          // Optionally, you can show a dialog to open app settings
          // await openAppSettings();
        } else {
          Get.log('Location permission denied');
        }
      } else if (status.isGranted) {
        Get.log('Location permission already granted');
      } else if (status.isPermanentlyDenied) {
        Get.log('Location permission permanently denied');
      }
    } catch (e) {
      Get.log('Error requesting location permission: $e');
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    PermissionStatus status = await Permission.location.status;
    return status.isGranted;
  }
}

