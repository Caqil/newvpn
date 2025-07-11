import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DeviceInfoHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Generate unique device ID
  static String generateDeviceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    final combined = '$timestamp$random';
    final bytes = utf8.encode(combined);
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, 16);
  }

  // Get comprehensive device information
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      return await _getAndroidInfo(packageInfo);
    } else if (Platform.isIOS) {
      return await _getIOSInfo(packageInfo);
    } else {
      return _getDefaultInfo(packageInfo);
    }
  }

  // Get Android device information
  static Future<Map<String, dynamic>> _getAndroidInfo(
    PackageInfo packageInfo,
  ) async {
    final androidInfo = await _deviceInfo.androidInfo;

    return {
      'device_id': generateDeviceId(),
      'device_name': '${androidInfo.brand} ${androidInfo.model}',
      'platform': 'Android',
      'platform_version': androidInfo.version.release,
      'device_model': androidInfo.model,
      'device_brand': androidInfo.brand,
      'device_manufacturer': androidInfo.manufacturer,
      'app_version': packageInfo.version,
      'app_build_number': packageInfo.buildNumber,
      'package_name': packageInfo.packageName,
      'app_name': packageInfo.appName,
      'android_id': androidInfo.id,
      'board': androidInfo.board,
      'bootloader': androidInfo.bootloader,
      'device': androidInfo.device,
      'display': androidInfo.display,
      'fingerprint': androidInfo.fingerprint,
      'hardware': androidInfo.hardware,
      'host': androidInfo.host,
      'product': androidInfo.product,
      'sdk_int': androidInfo.version.sdkInt,
      'is_physical_device': androidInfo.isPhysicalDevice,
      'supported_abis': androidInfo.supportedAbis,
      'supported_32bit_abis': androidInfo.supported32BitAbis,
      'supported_64bit_abis': androidInfo.supported64BitAbis,
    };
  }

  // Get iOS device information
  static Future<Map<String, dynamic>> _getIOSInfo(
    PackageInfo packageInfo,
  ) async {
    final iosInfo = await _deviceInfo.iosInfo;

    return {
      'device_id': generateDeviceId(),
      'device_name': iosInfo.name,
      'platform': 'iOS',
      'platform_version': iosInfo.systemVersion,
      'device_model': iosInfo.model,
      'device_brand': 'Apple',
      'device_manufacturer': 'Apple',
      'app_version': packageInfo.version,
      'app_build_number': packageInfo.buildNumber,
      'package_name': packageInfo.packageName,
      'app_name': packageInfo.appName,
      'identifier_for_vendor': iosInfo.identifierForVendor,
      'localized_model': iosInfo.localizedModel,
      'system_name': iosInfo.systemName,
      'utsname_machine': iosInfo.utsname.machine,
      'utsname_nodename': iosInfo.utsname.nodename,
      'utsname_release': iosInfo.utsname.release,
      'utsname_sysname': iosInfo.utsname.sysname,
      'utsname_version': iosInfo.utsname.version,
      'is_physical_device': iosInfo.isPhysicalDevice,
    };
  }

  // Get default device information for other platforms
  static Map<String, dynamic> _getDefaultInfo(PackageInfo packageInfo) {
    return {
      'device_id': generateDeviceId(),
      'device_name': 'Unknown Device',
      'platform': Platform.operatingSystem,
      'platform_version': Platform.operatingSystemVersion,
      'device_model': 'Unknown',
      'device_brand': 'Unknown',
      'device_manufacturer': 'Unknown',
      'app_version': packageInfo.version,
      'app_build_number': packageInfo.buildNumber,
      'package_name': packageInfo.packageName,
      'app_name': packageInfo.appName,
      'is_physical_device': true,
    };
  }

  // Get platform-specific identifier
  static Future<String?> getPlatformIdentifier() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  // Check if device is rooted/jailbroken
  static Future<bool> isDeviceCompromised() async {
    if (Platform.isAndroid) {
      return await _checkAndroidRoot();
    } else if (Platform.isIOS) {
      return await _checkIOSJailbreak();
    }
    return false;
  }

  // Check if Android device is rooted
  static Future<bool> _checkAndroidRoot() async {
    try {
      // Check for common root files
      final rootPaths = [
        '/system/app/Superuser.apk',
        '/sbin/su',
        '/system/bin/su',
        '/system/xbin/su',
        '/data/local/xbin/su',
        '/data/local/bin/su',
        '/system/sd/xbin/su',
        '/system/bin/failsafe/su',
        '/data/local/su',
        '/su/bin/su',
      ];

      for (final path in rootPaths) {
        if (await File(path).exists()) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // Check if iOS device is jailbroken
  static Future<bool> _checkIOSJailbreak() async {
    try {
      // Check for common jailbreak files
      final jailbreakPaths = [
        '/Applications/Cydia.app',
        '/Library/MobileSubstrate/MobileSubstrate.dylib',
        '/bin/bash',
        '/usr/sbin/sshd',
        '/etc/apt',
        '/private/var/lib/apt/',
        '/private/var/lib/cydia',
        '/private/var/mobile/Library/SBSettings/Themes',
        '/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist',
        '/usr/libexec/ssh-keysign',
        '/var/cache/apt',
        '/var/lib/apt',
        '/var/lib/cydia',
        '/usr/sbin/frida-server',
        '/usr/bin/cycript',
        '/usr/local/bin/cycript',
        '/usr/lib/libcycript.dylib',
      ];

      for (final path in jailbreakPaths) {
        if (await File(path).exists()) {
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // Check if running on emulator/simulator
  static Future<bool> isEmulator() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return !androidInfo.isPhysicalDevice ||
          androidInfo.brand.toLowerCase() == 'generic' ||
          androidInfo.device.toLowerCase().contains('emulator') ||
          androidInfo.model.toLowerCase().contains('emulator') ||
          androidInfo.product.toLowerCase().contains('sdk');
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return !iosInfo.isPhysicalDevice;
    }
    return false;
  }

  // Get device screen information
  static Map<String, dynamic> getScreenInfo() {
    // This would typically use a package like flutter_screen_wake
    // For now, return basic info
    return {
      'screen_width': 0, // Would get actual screen width
      'screen_height': 0, // Would get actual screen height
      'pixel_ratio': 1.0, // Would get actual pixel ratio
    };
  }

  // Get device memory information
  static Future<Map<String, dynamic>> getMemoryInfo() async {
    // This would typically use platform channels to get actual memory info
    return {
      'total_memory': 0, // Total RAM in MB
      'available_memory': 0, // Available RAM in MB
      'used_memory': 0, // Used RAM in MB
    };
  }

  // Get device storage information
  static Future<Map<String, dynamic>> getStorageInfo() async {
    // This would typically use platform channels to get actual storage info
    return {
      'total_storage': 0, // Total storage in GB
      'available_storage': 0, // Available storage in GB
      'used_storage': 0, // Used storage in GB
    };
  }

  // Get device battery information
  static Future<Map<String, dynamic>> getBatteryInfo() async {
    // This would typically use battery_plus package
    return {
      'battery_level': 100, // Battery percentage
      'is_charging': false, // Charging status
      'is_low_power_mode': false, // Low power mode status
    };
  }

  // Get network information
  static Future<Map<String, dynamic>> getNetworkInfo() async {
    // This would typically use connectivity_plus package
    return {
      'connection_type': 'wifi', // wifi, mobile, ethernet, none
      'is_connected': true, // Connection status
      'carrier_name': null, // Mobile carrier name
    };
  }

  // Get device locale information
  static Map<String, dynamic> getLocaleInfo() {
    return {
      'language': Platform.localeName.split('_')[0],
      'country': Platform.localeName.contains('_')
          ? Platform.localeName.split('_')[1]
          : null,
      'locale': Platform.localeName,
      'timezone': DateTime.now().timeZoneName,
    };
  }

  // Get app permissions status
  static Future<Map<String, bool>> getPermissionsStatus() async {
    // This would check actual permissions
    return {
      'vpn': false, // VPN permission
      'notifications': false, // Notification permission
      'location': false, // Location permission (if needed)
      'camera': false, // Camera permission (if needed)
      'microphone': false, // Microphone permission (if needed)
    };
  }

  // Create device fingerprint for security
  static Future<String> createDeviceFingerprint() async {
    final deviceInfo = await getDeviceInfo();
    final locale = getLocaleInfo();

    final fingerprintData = {
      'model': deviceInfo['device_model'],
      'brand': deviceInfo['device_brand'],
      'platform': deviceInfo['platform'],
      'platform_version': deviceInfo['platform_version'],
      'locale': locale['locale'],
      'timezone': locale['timezone'],
    };

    final fingerprintString = fingerprintData.values.join('|');
    final bytes = utf8.encode(fingerprintString);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  // Check if device meets minimum requirements
  static Future<bool> meetsMinimumRequirements() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 21; // Android 5.0+
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      final version = iosInfo.systemVersion.split('.')[0];
      return int.parse(version) >= 12; // iOS 12+
    }
    return true;
  }

  // Get device security features
  static Future<Map<String, bool>> getSecurityFeatures() async {
    return {
      'has_secure_boot': false, // Secure boot availability
      'has_hardware_keystore': false, // Hardware keystore
      'has_biometric': false, // Fingerprint/Face ID
      'has_screen_lock': false, // Screen lock enabled
      'is_debugging_enabled': false, // Debug mode
    };
  }
}
