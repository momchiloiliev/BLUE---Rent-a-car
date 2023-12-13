import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

class DeviceUtils {
  static Future<String?> getDeviceId(ThemeData theme) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (theme.platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.androidId; // Unique ID for Android
      } else if (theme.platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor; // Unique ID for iOS
      }
    } catch (e) {
      // Handle errors, logging, or return null if the ID couldn't be retrieved
      print('Error getting device ID: $e');
      return null;
    }
    return null;
  }
}
