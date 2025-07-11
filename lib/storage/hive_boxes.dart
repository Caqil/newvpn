import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/device_model.dart';
import '../models/subscription_model.dart';
import '../models/vpn_server_model.dart';
import '../models/vpn_state_model.dart';
import '../models/usage_timer_model.dart';
import '../models/receipt_model.dart';
import 'storage_keys.dart';

class HiveBoxes {
  // Box references
  static Box? _mainBox;
  static Box? _userBox;
  static Box? _deviceBox;
  static Box? _subscriptionBox;
  static Box? _timerBox;
  static Box? _serversBox;
  static Box? _settingsBox;
  static Box? _cacheBox;

  // Initialize all Hive boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    await _registerAdapters();
    await _openBoxes();
  }

  // Register all Hive type adapters
  static Future<void> _registerAdapters() async {
    // User models
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ProxiesModelAdapter());
    Hive.registerAdapter(TrojanModelAdapter());
    Hive.registerAdapter(ShadowsocksModelAdapter());
    Hive.registerAdapter(VmessModelAdapter());
    Hive.registerAdapter(VlessModelAdapter());
    Hive.registerAdapter(InboundsModelAdapter());
    Hive.registerAdapter(ExcludedInboundsModelAdapter());
    Hive.registerAdapter(AdminModelAdapter());

    // Device models
    Hive.registerAdapter(DeviceModelAdapter());
    Hive.registerAdapter(DeviceSpecsModelAdapter());

    // Subscription models
    Hive.registerAdapter(SubscriptionModelAdapter());
    Hive.registerAdapter(SubscriptionStatusAdapter());
    Hive.registerAdapter(SubscriptionPlanModelAdapter());

    // VPN server models
    Hive.registerAdapter(VpnServerModelAdapter());
    Hive.registerAdapter(ServerStatusAdapter());
    Hive.registerAdapter(ServerQualityAdapter());
    Hive.registerAdapter(ServerListModelAdapter());

    // VPN state models
    Hive.registerAdapter(VpnConnectionModelAdapter());
    Hive.registerAdapter(VpnStatusAdapter());
    Hive.registerAdapter(VpnStatisticsAdapter());
    Hive.registerAdapter(VpnConfigModelAdapter());

    // Timer models
    Hive.registerAdapter(UsageTimerModelAdapter());
    Hive.registerAdapter(TimerStatusAdapter());
    Hive.registerAdapter(UsageSessionModelAdapter());
    Hive.registerAdapter(SessionEndReasonAdapter());
    Hive.registerAdapter(TimerSettingsModelAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());

    // Receipt models
    Hive.registerAdapter(ReceiptModelAdapter());
    Hive.registerAdapter(ReceiptStatusAdapter());
    Hive.registerAdapter(ReceiptValidationResponseModelAdapter());
    Hive.registerAdapter(ReceiptHistoryModelAdapter());
  }

  // Open all Hive boxes
  static Future<void> _openBoxes() async {
    try {
      _mainBox = await Hive.openBox(StorageKeys.mainBox);
      _userBox = await Hive.openBox(StorageKeys.userBox);
      _deviceBox = await Hive.openBox(StorageKeys.deviceBox);
      _subscriptionBox = await Hive.openBox(StorageKeys.subscriptionBox);
      _timerBox = await Hive.openBox(StorageKeys.timerBox);
      _serversBox = await Hive.openBox(StorageKeys.serversBox);
      _settingsBox = await Hive.openBox(StorageKeys.settingsBox);
      _cacheBox = await Hive.openBox(StorageKeys.cacheBox);
    } catch (e) {
      print('Error opening Hive boxes: $e');
      rethrow;
    }
  }

  // Get box instances with null safety
  static Box get mainBox {
    if (_mainBox == null || !_mainBox!.isOpen) {
      throw StateError('Main box is not initialized or closed');
    }
    return _mainBox!;
  }

  static Box get userBox {
    if (_userBox == null || !_userBox!.isOpen) {
      throw StateError('User box is not initialized or closed');
    }
    return _userBox!;
  }

  static Box get deviceBox {
    if (_deviceBox == null || !_deviceBox!.isOpen) {
      throw StateError('Device box is not initialized or closed');
    }
    return _deviceBox!;
  }

  static Box get subscriptionBox {
    if (_subscriptionBox == null || !_subscriptionBox!.isOpen) {
      throw StateError('Subscription box is not initialized or closed');
    }
    return _subscriptionBox!;
  }

  static Box get timerBox {
    if (_timerBox == null || !_timerBox!.isOpen) {
      throw StateError('Timer box is not initialized or closed');
    }
    return _timerBox!;
  }

  static Box get serversBox {
    if (_serversBox == null || !_serversBox!.isOpen) {
      throw StateError('Servers box is not initialized or closed');
    }
    return _serversBox!;
  }

  static Box get settingsBox {
    if (_settingsBox == null || !_settingsBox!.isOpen) {
      throw StateError('Settings box is not initialized or closed');
    }
    return _settingsBox!;
  }

  static Box get cacheBox {
    if (_cacheBox == null || !_cacheBox!.isOpen) {
      throw StateError('Cache box is not initialized or closed');
    }
    return _cacheBox!;
  }

  // Check if boxes are initialized
  static bool get isInitialized =>
      _mainBox != null &&
      _userBox != null &&
      _deviceBox != null &&
      _subscriptionBox != null &&
      _timerBox != null &&
      _serversBox != null &&
      _settingsBox != null &&
      _cacheBox != null;

  // Check if all boxes are open
  static bool get areBoxesOpen =>
      isInitialized &&
      _mainBox!.isOpen &&
      _userBox!.isOpen &&
      _deviceBox!.isOpen &&
      _subscriptionBox!.isOpen &&
      _timerBox!.isOpen &&
      _serversBox!.isOpen &&
      _settingsBox!.isOpen &&
      _cacheBox!.isOpen;

  // Get box by name
  static Box? getBoxByName(String boxName) {
    switch (boxName) {
      case StorageKeys.mainBox:
        return _mainBox;
      case StorageKeys.userBox:
        return _userBox;
      case StorageKeys.deviceBox:
        return _deviceBox;
      case StorageKeys.subscriptionBox:
        return _subscriptionBox;
      case StorageKeys.timerBox:
        return _timerBox;
      case StorageKeys.serversBox:
        return _serversBox;
      case StorageKeys.settingsBox:
        return _settingsBox;
      case StorageKeys.cacheBox:
        return _cacheBox;
      default:
        return null;
    }
  }

  // Clear all data (for app reset)
  static Future<void> clearAll() async {
    await Future.wait([
      _mainBox?.clear() ?? Future.value(),
      _userBox?.clear() ?? Future.value(),
      _deviceBox?.clear() ?? Future.value(),
      _subscriptionBox?.clear() ?? Future.value(),
      _timerBox?.clear() ?? Future.value(),
      _serversBox?.clear() ?? Future.value(),
      _settingsBox?.clear() ?? Future.value(),
      _cacheBox?.clear() ?? Future.value(),
    ]);
  }

  // Clear user data (for logout)
  static Future<void> clearUserData() async {
    await Future.wait([
      _userBox?.clear() ?? Future.value(),
      _subscriptionBox?.clear() ?? Future.value(),
      _timerBox?.clear() ?? Future.value(),
    ]);

    // Clear specific VPN data from main box
    final vpnKeys = StorageKeys.vpnRelatedKeys;
    for (final key in vpnKeys) {
      await _mainBox?.delete(key);
    }
  }

  // Clear cache data
  static Future<void> clearCache() async {
    await _cacheBox?.clear();

    // Clear cache-related keys from other boxes
    final cacheKeys = StorageKeys.cacheRelatedKeys;
    for (final key in cacheKeys) {
      await _mainBox?.delete(key);
    }
  }

  // Clear sensitive data
  static Future<void> clearSensitiveData() async {
    final sensitiveKeys = StorageKeys.sensitiveKeys;

    await Future.wait([
      ...sensitiveKeys.map((key) => _mainBox?.delete(key) ?? Future.value()),
      ...sensitiveKeys.map((key) => _userBox?.delete(key) ?? Future.value()),
      ...sensitiveKeys.map(
        (key) => _subscriptionBox?.delete(key) ?? Future.value(),
      ),
    ]);
  }

  // Compact all boxes (optimize storage)
  static Future<void> compact() async {
    await Future.wait([
      _mainBox?.compact() ?? Future.value(),
      _userBox?.compact() ?? Future.value(),
      _deviceBox?.compact() ?? Future.value(),
      _subscriptionBox?.compact() ?? Future.value(),
      _timerBox?.compact() ?? Future.value(),
      _serversBox?.compact() ?? Future.value(),
      _settingsBox?.compact() ?? Future.value(),
      _cacheBox?.compact() ?? Future.value(),
    ]);
  }

  // Close all boxes
  static Future<void> close() async {
    await Future.wait([
      _mainBox?.close() ?? Future.value(),
      _userBox?.close() ?? Future.value(),
      _deviceBox?.close() ?? Future.value(),
      _subscriptionBox?.close() ?? Future.value(),
      _timerBox?.close() ?? Future.value(),
      _serversBox?.close() ?? Future.value(),
      _settingsBox?.close() ?? Future.value(),
      _cacheBox?.close() ?? Future.value(),
    ]);

    // Reset references
    _mainBox = null;
    _userBox = null;
    _deviceBox = null;
    _subscriptionBox = null;
    _timerBox = null;
    _serversBox = null;
    _settingsBox = null;
    _cacheBox = null;
  }

  // Get total storage size (approximate)
  static int getTotalStorageSize() {
    int totalSize = 0;

    if (_mainBox?.isOpen == true) totalSize += _mainBox!.length;
    if (_userBox?.isOpen == true) totalSize += _userBox!.length;
    if (_deviceBox?.isOpen == true) totalSize += _deviceBox!.length;
    if (_subscriptionBox?.isOpen == true) totalSize += _subscriptionBox!.length;
    if (_timerBox?.isOpen == true) totalSize += _timerBox!.length;
    if (_serversBox?.isOpen == true) totalSize += _serversBox!.length;
    if (_settingsBox?.isOpen == true) totalSize += _settingsBox!.length;
    if (_cacheBox?.isOpen == true) totalSize += _cacheBox!.length;

    return totalSize;
  }

  // Get storage statistics
  static Map<String, int> getStorageStats() {
    return {
      'main': _mainBox?.length ?? 0,
      'user': _userBox?.length ?? 0,
      'device': _deviceBox?.length ?? 0,
      'subscription': _subscriptionBox?.length ?? 0,
      'timer': _timerBox?.length ?? 0,
      'servers': _serversBox?.length ?? 0,
      'settings': _settingsBox?.length ?? 0,
      'cache': _cacheBox?.length ?? 0,
      'total': getTotalStorageSize(),
    };
  }

  // Check if storage needs cleanup
  static bool needsCleanup() {
    const maxCacheSize = 1000;
    const maxTotalSize = 5000;

    final cacheSize = _cacheBox?.length ?? 0;
    final totalSize = getTotalStorageSize();

    return cacheSize > maxCacheSize || totalSize > maxTotalSize;
  }

  // Perform cleanup
  static Future<void> performCleanup() async {
    // Clear old cache entries
    await clearCache();

    // Clear temporary keys
    final boxes = [
      _mainBox,
      _userBox,
      _deviceBox,
      _subscriptionBox,
      _timerBox,
      _serversBox,
      _settingsBox,
    ];

    for (final box in boxes) {
      if (box?.isOpen == true) {
        final keysToDelete = box!.keys
            .where(
              (key) =>
                  key is String &&
                  (StorageKeys.isTempKey(key) || StorageKeys.isSessionKey(key)),
            )
            .toList();

        for (final key in keysToDelete) {
          await box.delete(key);
        }
      }
    }

    // Compact boxes
    await compact();
  }

  // Backup critical data
  static Map<String, dynamic> backupCriticalData() {
    final backup = <String, dynamic>{};

    try {
      // Backup user data
      if (_userBox?.isOpen == true) {
        backup['user'] = Map<String, dynamic>.from(_userBox!.toMap());
      }

      // Backup subscription data
      if (_subscriptionBox?.isOpen == true) {
        backup['subscription'] = Map<String, dynamic>.from(
          _subscriptionBox!.toMap(),
        );
      }

      // Backup device data
      if (_deviceBox?.isOpen == true) {
        backup['device'] = Map<String, dynamic>.from(_deviceBox!.toMap());
      }

      // Backup important settings
      if (_settingsBox?.isOpen == true) {
        backup['settings'] = Map<String, dynamic>.from(_settingsBox!.toMap());
      }

      backup['timestamp'] = DateTime.now().toIso8601String();
      backup['version'] = '1.0.0';
    } catch (e) {
      print('Error creating backup: $e');
    }

    return backup;
  }

  // Restore from backup
  static Future<bool> restoreFromBackup(Map<String, dynamic> backup) async {
    try {
      // Validate backup
      if (!backup.containsKey('timestamp') || !backup.containsKey('version')) {
        return false;
      }

      // Restore user data
      if (backup.containsKey('user') && _userBox?.isOpen == true) {
        await _userBox!.clear();
        await _userBox!.putAll(Map<String, dynamic>.from(backup['user']));
      }

      // Restore subscription data
      if (backup.containsKey('subscription') &&
          _subscriptionBox?.isOpen == true) {
        await _subscriptionBox!.clear();
        await _subscriptionBox!.putAll(
          Map<String, dynamic>.from(backup['subscription']),
        );
      }

      // Restore device data
      if (backup.containsKey('device') && _deviceBox?.isOpen == true) {
        await _deviceBox!.clear();
        await _deviceBox!.putAll(Map<String, dynamic>.from(backup['device']));
      }

      // Restore settings
      if (backup.containsKey('settings') && _settingsBox?.isOpen == true) {
        await _settingsBox!.clear();
        await _settingsBox!.putAll(
          Map<String, dynamic>.from(backup['settings']),
        );
      }

      return true;
    } catch (e) {
      print('Error restoring backup: $e');
      return false;
    }
  }

  // Get box health status
  static Map<String, bool> getBoxHealthStatus() {
    return {
      'main': _mainBox?.isOpen ?? false,
      'user': _userBox?.isOpen ?? false,
      'device': _deviceBox?.isOpen ?? false,
      'subscription': _subscriptionBox?.isOpen ?? false,
      'timer': _timerBox?.isOpen ?? false,
      'servers': _serversBox?.isOpen ?? false,
      'settings': _settingsBox?.isOpen ?? false,
      'cache': _cacheBox?.isOpen ?? false,
      'all_healthy': areBoxesOpen,
    };
  }

  // Repair corrupted boxes
  static Future<bool> repairBoxes() async {
    try {
      final boxNames = [
        StorageKeys.mainBox,
        StorageKeys.userBox,
        StorageKeys.deviceBox,
        StorageKeys.subscriptionBox,
        StorageKeys.timerBox,
        StorageKeys.serversBox,
        StorageKeys.settingsBox,
        StorageKeys.cacheBox,
      ];

      for (final boxName in boxNames) {
        try {
          final box = getBoxByName(boxName);
          if (box == null || !box.isOpen) {
            // Try to reopen the box
            await Hive.openBox(boxName);
          }
        } catch (e) {
          print('Failed to repair box $boxName: $e');
          // Delete corrupted box and recreate
          await Hive.deleteBoxFromDisk(boxName);
          await Hive.openBox(boxName);
        }
      }

      return true;
    } catch (e) {
      print('Box repair failed: $e');
      return false;
    }
  }
}
