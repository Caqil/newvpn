import 'dart:io';
import '../models/device_model.dart';
import '../utils/device_info.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../config/api_config.dart';

class DeviceService {
  static final DeviceService _instance = DeviceService._internal();
  factory DeviceService() => _instance;
  DeviceService._internal();

  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  bool _isInitialized = false;
  DeviceModel? _currentDevice;

  // Initialize device service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _apiService.initialize();
    await _storageService.initialize();

    // Load existing device or create new one
    await _loadOrCreateDevice();
    
    _isInitialized = true;
    print('📱 Device service initialized');
  }

  // Load existing device from storage or create new one
  Future<void> _loadOrCreateDevice() async {
    _currentDevice = _storageService.getDevice();
    
    if (_currentDevice == null) {
      await _createNewDevice();
    } else {
      await _updateDeviceInfo();
    }
  }

  // Create new device profile
  Future<void> _createNewDevice() async {
    try {
      print('📱 Creating new device profile...');
      
      final deviceInfo = await DeviceInfoHelper.getDeviceInfo();
      final locale = DeviceInfoHelper.getLocaleInfo();
      
      _currentDevice = DeviceModel(
        deviceId: deviceInfo['device_id'] as String,
        deviceName: deviceInfo['device_name'] as String,
        platform: deviceInfo['platform'] as String,
        platformVersion: deviceInfo['platform_version'] as String,
        deviceModel: deviceInfo['device_model'] as String,
        deviceBrand: deviceInfo['device_brand'] as String,
        appVersion: deviceInfo['app_version'] as String,
        appBuildNumber: deviceInfo['app_build_number'] as String,
        registeredAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
        locale: locale['locale'] as String,
        timeZone: locale['timezone'] as String,
        deviceSpecs: {
          'package_name': deviceInfo['package_name'],
          'is_physical_device': deviceInfo['is_physical_device'],
          if (Platform.isAndroid) ...{
            'android_id': deviceInfo['android_id'],
            'sdk_int': deviceInfo['sdk_int'],
            'supported_abis': deviceInfo['supported_abis'],
          },
          if (Platform.isIOS) ...{
            'identifier_for_vendor': deviceInfo['identifier_for_vendor'],
            'localized_model': deviceInfo['localized_model'],
          },
        },
        isRooted: await DeviceInfoHelper.isDeviceCompromised(),
        isEmulator: await DeviceInfoHelper.isEmulator(),
        firstLaunchAt: DateTime.now(),
      );

      await _storageService.saveDevice(_currentDevice!);
      print('✅ Device profile created: ${_currentDevice!.deviceId}');
    } catch (e) {
      print('❌ Failed to create device profile: $e');
      rethrow;
    }
  }

  // Update device information
  Future<void> _updateDeviceInfo() async {
    if (_currentDevice == null) return;

    try {
      final deviceInfo = await DeviceInfoHelper.getDeviceInfo();
      
      _currentDevice = _currentDevice!.copyWith(
        lastActiveAt: DateTime.now(),
        appVersion: deviceInfo['app_version'] as String,
        appBuildNumber: deviceInfo['app_build_number'] as String,
        totalAppLaunches: _currentDevice!.totalAppLaunches + 1,
        lastUpdateAt: DateTime.now(),
      );

      await _storageService.saveDevice(_currentDevice!);
    } catch (e) {
      print('❌ Failed to update device info: $e');
    }
  }

  // Register device with API
  Future<bool> registerDevice() async {
    if (_currentDevice == null) {
      print('❌ No device to register');
      return false;
    }

    if (_currentDevice!.isRegistered) {
      print('✅ Device already registered');
      return true;
    }

    try {
      print('📡 Registering device with API...');
      
      final registrationData = _currentDevice!.toRegistrationData();
      final user = await _apiService.registerDevice(registrationData);
      
      // Update device registration status
      _currentDevice = _currentDevice!.copyWith(
        isRegistered: true,
        userId: user.username,
        registeredAt: DateTime.now(),
      );
      
      await _storageService.saveDevice(_currentDevice!);
      await _storageService.saveUser(user);
      await _storageService.updateDeviceRegistration(true);
      
      print('✅ Device registered successfully');
      return true;
    } catch (e) {
      print('❌ Device registration failed: $e');
      return false;
    }
  }

  // Check device registration status
  Future<bool> checkRegistrationStatus() async {
    if (_currentDevice == null) return false;

    try {
      final user = await _apiService.getUser(_currentDevice!.deviceId);
      
      if (user.username.isNotEmpty) {
        _currentDevice = _currentDevice!.copyWith(
          isRegistered: true,
          userId: user.username,
        );
        
        await _storageService.saveDevice(_currentDevice!);
        await _storageService.saveUser(user);
        await _storageService.updateDeviceRegistration(true);
        
        return true;
      }
    } catch (e) {
      print('❌ Failed to check registration status: $e');
    }
    
    return false;
  }

  // Update FCM token
  Future<void> updateFcmToken(String token) async {
    if (_currentDevice == null) return;

    try {
      _currentDevice = _currentDevice!.copyWith(fcmToken: token);
      await _storageService.saveDevice(_currentDevice!);
      await _storageService.saveFcmToken(token);
      
      print('🔔 FCM token updated');
    } catch (e) {
      print('❌ Failed to update FCM token: $e');
    }
  }

  // Update permissions
  Future<void> updatePermissions({
    bool? vpnPermission,
    bool? notificationPermission,
  }) async {
    if (_currentDevice == null) return;

    try {
      _currentDevice = _currentDevice!.copyWith(
        hasVpnPermission: vpnPermission ?? _currentDevice!.hasVpnPermission,
        hasNotificationPermission: notificationPermission ?? _currentDevice!.hasNotificationPermission,
      );
      
      await _storageService.saveDevice(_currentDevice!);
      
      if (vpnPermission != null) {
        await _storageService.setVpnPermissionGranted(vpnPermission);
      }
      
      print('🔐 Permissions updated');
    } catch (e) {
      print('❌ Failed to update permissions: $e');
    }
  }

  // Get device fingerprint
  Future<String> getDeviceFingerprint() async {
    try {
      if (_currentDevice == null) {
        await _loadOrCreateDevice();
      }
      
      String? fingerprint = _storageService.getDeviceFingerprint();
      
      if (fingerprint == null) {
        final deviceInfo = await DeviceInfoHelper.getDeviceInfo();
        fingerprint = DeviceInfoHelper.generateDeviceFingerprint(deviceInfo);
        await _storageService.saveDeviceFingerprint(fingerprint);
      }
      
      return fingerprint;
    } catch (e) {
      print('❌ Failed to get device fingerprint: $e');
      return '';
    }
  }

  // Check device security
  Future<Map<String, bool>> checkDeviceSecurity() async {
    try {
      final isCompromised = await DeviceInfoHelper.isDeviceCompromised();
      final isEmulator = await DeviceInfoHelper.isEmulator();
      final meetsRequirements = await DeviceInfoHelper.meetsMinimumRequirements();
      
      return {
        'is_secure': !isCompromised && !isEmulator && meetsRequirements,
        'is_compromised': isCompromised,
        'is_emulator': isEmulator,
        'meets_requirements': meetsRequirements,
      };
    } catch (e) {
      print('❌ Security check failed: $e');
      return {
        'is_secure': false,
        'is_compromised': true,
        'is_emulator': false,
        'meets_requirements': false,
      };
    }
  }

  // Update app usage statistics
  Future<void> updateAppUsage() async {
    if (_currentDevice == null) return;

    try {
      final now = DateTime.now();
      final lastActive = _currentDevice!.lastActiveAt;
      final sessionDuration = now.difference(lastActive);
      
      _currentDevice = _currentDevice!.copyWith(
        lastActiveAt: now,
        totalAppUsage: _currentDevice!.totalAppUsage + sessionDuration,
        totalAppLaunches: _currentDevice!.totalAppLaunches + 1,
      );
      
      await _storageService.saveDevice(_currentDevice!);
      await _storageService.updateLastActiveDate();
      await _storageService.incrementAppLaunchCount();
    } catch (e) {
      print('❌ Failed to update app usage: $e');
    }
  }

  // Get device analytics data
  Map<String, dynamic> getAnalyticsData() {
    if (_currentDevice == null) return {};

    return _currentDevice!.analyticsProperties;
  }

  // Check if device needs update
  bool needsDeviceUpdate() {
    if (_currentDevice == null) return false;

    final lastUpdate = _currentDevice!.lastUpdateAt;
    if (lastUpdate == null) return true;

    final daysSinceUpdate = DateTime.now().difference(lastUpdate).inDays;
    return daysSinceUpdate >= 7; // Update weekly
  }

  // Validate device integrity
  Future<bool> validateDeviceIntegrity() async {
    try {
      if (_currentDevice == null) return false;

      // Check if device ID matches stored fingerprint
      final currentFingerprint = await getDeviceFingerprint();
      final storedFingerprint = _storageService.getDeviceFingerprint();
      
      if (storedFingerprint != null && currentFingerprint != storedFingerprint) {
        print('⚠️ Device fingerprint mismatch');
        return false;
      }

      // Check if device info is consistent
      final currentDeviceInfo = await DeviceInfoHelper.getDeviceInfo();
      if (currentDeviceInfo['device_id'] != _currentDevice!.deviceId) {
        print('⚠️ Device ID mismatch');
        return false;
      }

      return true;
    } catch (e) {
      print('❌ Device integrity validation failed: $e');
      return false;
    }
  }

  // Reset device registration
  Future<void> resetDeviceRegistration() async {
    try {
      if (_currentDevice != null) {
        _currentDevice = _currentDevice!.copyWith(
          isRegistered: false,
          userId: null,
        );
        await _storageService.saveDevice(_currentDevice!);
      }
      
      await _storageService.updateDeviceRegistration(false);
      print('🔄 Device registration reset');
    } catch (e) {
      print('❌ Failed to reset device registration: $e');
    }
  }

  // Get network information
  Future<Map<String, dynamic>> getNetworkInfo() async {
    return await DeviceInfoHelper.getNetworkInfo();
  }

  // Get battery information
  Future<Map<String, dynamic>> getBatteryInfo() async {
    return await DeviceInfoHelper.getBatteryInfo();
  }

  // Get device specifications
  Future<Map<String, dynamic>> getDeviceSpecs() async {
    return await DeviceInfoHelper.getMemoryInfo();
  }

  // Getters
  DeviceModel? get currentDevice => _currentDevice;
  String? get deviceId => _currentDevice?.deviceId;
  bool get isRegistered => _currentDevice?.isRegistered ?? false;
  bool get hasVpnPermission => _currentDevice?.hasVpnPermission ?? false;
  bool get hasNotificationPermission => _currentDevice?.hasNotificationPermission ?? false;
  bool get isSecure => _currentDevice != null && !_currentDevice!.isRooted && !_currentDevice!.isEmulator;

  // Device status summary
  Map<String, dynamic> getDeviceStatus() {
    if (_currentDevice == null) {
      return {
        'status': 'not_initialized',
        'message': 'Device not initialized',
      };
    }

    return {
      'status': 'active',
      'device_id': _currentDevice!.deviceId,
      'device_name': _currentDevice!.displayName,
      'platform': _currentDevice!.platformInfo,
      'app_version': _currentDevice!.appInfo,
      'is_registered': _currentDevice!.isRegistered,
      'has_permissions': _currentDevice!.hasAllPermissions,
      'is_secure': isSecure,
      'last_active': _currentDevice!.lastActiveAt.toIso8601String(),
      'total_launches': _currentDevice!.totalAppLaunches,
      'days_since_install': _currentDevice!.timeSinceRegistration.inDays,
    };
  }

  // Dispose resources
  void dispose() {
    _isInitialized = false;
    _currentDevice = null;
    print('📱 Device service disposed');
  }
}