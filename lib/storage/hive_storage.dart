import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/device_model.dart';
import '../models/subscription_model.dart';
import '../models/vpn_server_model.dart';
import '../models/vpn_state_model.dart';
import '../models/usage_timer_model.dart';
import '../models/receipt_model.dart';
import 'hive_boxes.dart';
import 'storage_keys.dart';

class HiveStorage {
  // Initialize storage
  static Future<void> init() async {
    await HiveBoxes.init();
  }
  
  // Generic storage methods
  static Future<void> put<T>(String key, T value, {String? boxName}) async {
    final box = boxName != null ? HiveBoxes.getBoxByName(boxName) : HiveBoxes.mainBox;
    if (box != null) {
      await box.put(key, value);
    }
  }
  
  static T? get<T>(String key, {T? defaultValue, String? boxName}) {
    final box = boxName != null ? HiveBoxes.getBoxByName(boxName) : HiveBoxes.mainBox;
    return box?.get(key, defaultValue: defaultValue);
  }
  
  static Future<void> delete(String key, {String? boxName}) async {
    final box = boxName != null ? HiveBoxes.getBoxByName(boxName) : HiveBoxes.mainBox;
    await box?.delete(key);
  }
  
  static bool contains(String key, {String? boxName}) {
    final box = boxName != null ? HiveBoxes.getBoxByName(boxName) : HiveBoxes.mainBox;
    return box?.containsKey(key) ?? false;
  }
  
  // User Data Methods
  static Future<void> saveUser(UserModel user) async {
    await put(StorageKeys.currentUser, user, boxName: StorageKeys.userBox);
    await put(StorageKeys.isUserLoggedIn, true, boxName: StorageKeys.userBox);
    await put(StorageKeys.lastLoginDate, DateTime.now(), boxName: StorageKeys.userBox);
  }
  
  static UserModel? getUser() {
    return get<UserModel>(StorageKeys.currentUser, boxName: StorageKeys.userBox);
  }
  
  static bool isUserLoggedIn() {
    return get<bool>(StorageKeys.isUserLoggedIn, defaultValue: false, boxName: StorageKeys.userBox) ?? false;
  }
  
  static Future<void> clearUser() async {
    await delete(StorageKeys.currentUser, boxName: StorageKeys.userBox);
    await put(StorageKeys.isUserLoggedIn, false, boxName: StorageKeys.userBox);
  }
  
  // Device Data Methods
  static Future<void> saveDevice(DeviceModel device) async {
    await put(StorageKeys.deviceInfo, device, boxName: StorageKeys.deviceBox);
    await put(StorageKeys.deviceId, device.deviceId, boxName: StorageKeys.deviceBox);
    await put(StorageKeys.deviceRegistered, device.isRegistered, boxName: StorageKeys.deviceBox);
    await put(StorageKeys.deviceRegistrationDate, device.registeredAt, boxName: StorageKeys.deviceBox);
  }
  
  static DeviceModel? getDevice() {
    return get<DeviceModel>(StorageKeys.deviceInfo, boxName: StorageKeys.deviceBox);
  }
  
  static String? getDeviceId() {
    return get<String>(StorageKeys.deviceId, boxName: StorageKeys.deviceBox);
  }
  
  static bool isDeviceRegistered() {
    return get<bool>(StorageKeys.deviceRegistered, defaultValue: false, boxName: StorageKeys.deviceBox) ?? false;
  }
  
  static Future<void> updateDeviceRegistration(bool isRegistered) async {
    await put(StorageKeys.deviceRegistered, isRegistered, boxName: StorageKeys.deviceBox);
    if (isRegistered) {
      await put(StorageKeys.deviceRegistrationDate, DateTime.now(), boxName: StorageKeys.deviceBox);
    }
  }
  
  // Subscription Data Methods
  static Future<void> saveSubscription(SubscriptionModel subscription) async {
    await put(StorageKeys.currentSubscription, subscription, boxName: StorageKeys.subscriptionBox);
    await put(StorageKeys.isPremiumUser, subscription.isPremiumUser, boxName: StorageKeys.subscriptionBox);
    await put(StorageKeys.subscriptionStatus, subscription.status, boxName: StorageKeys.subscriptionBox);
    await put(StorageKeys.subscriptionExpiry, subscription.expirationDate, boxName: StorageKeys.subscriptionBox);
  }
  
  static SubscriptionModel? getSubscription() {
    return get<SubscriptionModel>(StorageKeys.currentSubscription, boxName: StorageKeys.subscriptionBox);
  }
  
  static bool isPremiumUser() {
    return get<bool>(StorageKeys.isPremiumUser, defaultValue: false, boxName: StorageKeys.subscriptionBox) ?? false;
  }
  
  static Future<void> saveReceipt(ReceiptModel receipt) async {
    await put(StorageKeys.receiptData, receipt, boxName: StorageKeys.subscriptionBox);
    await put(StorageKeys.lastReceiptValidation, DateTime.now(), boxName: StorageKeys.subscriptionBox);
  }
  
  static ReceiptModel? getReceipt() {
    return get<ReceiptModel>(StorageKeys.receiptData, boxName: StorageKeys.subscriptionBox);
  }
  
  static Future<void> saveSubscriptionHistory(List<SubscriptionModel> history) async {
    await put(StorageKeys.subscriptionHistory, history, boxName: StorageKeys.subscriptionBox);
  }
  
  static List<SubscriptionModel> getSubscriptionHistory() {
    final history = get<List>(StorageKeys.subscriptionHistory, boxName: StorageKeys.subscriptionBox);
    return history?.cast<SubscriptionModel>() ?? [];
  }
  
  // Timer Data Methods
  static Future<void> saveTimer(UsageTimerModel timer) async {
    await put(StorageKeys.usageTimer, timer, boxName: StorageKeys.timerBox);
    await put(StorageKeys.totalUsedTime, timer.totalUsedTime, boxName: StorageKeys.timerBox);
    await put(StorageKeys.remainingTime, timer.remainingTime, boxName: StorageKeys.timerBox);
    await put(StorageKeys.lastTimerReset, timer.lastResetAt, boxName: StorageKeys.timerBox);
    await put(StorageKeys.isTimerActive, timer.isTimerActive, boxName: StorageKeys.timerBox);
  }
  
  static UsageTimerModel? getTimer() {
    return get<UsageTimerModel>(StorageKeys.usageTimer, boxName: StorageKeys.timerBox);
  }
  
  static Duration getTotalUsedTime() {
    return get<Duration>(StorageKeys.totalUsedTime, defaultValue: Duration.zero, boxName: StorageKeys.timerBox) ?? Duration.zero;
  }
  
  static Duration getRemainingTime() {
    return get<Duration>(StorageKeys.remainingTime, defaultValue: const Duration(hours: 1), boxName: StorageKeys.timerBox) ?? const Duration(hours: 1);
  }
  
  static bool isTimerActive() {
    return get<bool>(StorageKeys.isTimerActive, defaultValue: false, boxName: StorageKeys.timerBox) ?? false;
  }
  
  static DateTime? getLastTimerReset() {
    return get<DateTime>(StorageKeys.lastTimerReset, boxName: StorageKeys.timerBox);
  }
  
  static Future<void> saveCurrentSessionStart(DateTime startTime) async {
    await put(StorageKeys.currentSessionStart, startTime, boxName: StorageKeys.timerBox);
  }
  
  static DateTime? getCurrentSessionStart() {
    return get<DateTime>(StorageKeys.currentSessionStart, boxName: StorageKeys.timerBox);
  }
  
  static Future<void> saveUsageSessions(List<UsageSessionModel> sessions) async {
    await put(StorageKeys.usageSessions, sessions, boxName: StorageKeys.timerBox);
  }
  
  static List<UsageSessionModel> getUsageSessions() {
    final sessions = get<List>(StorageKeys.usageSessions, boxName: StorageKeys.timerBox);
    return sessions?.cast<UsageSessionModel>() ?? [];
  }
  
  // VPN Connection Methods
  static Future<void> saveVpnState(VpnConnectionModel state) async {
    await put(StorageKeys.vpnConnectionState, state);
    await put(StorageKeys.currentServer, state.serverId);
    if (state.isConnected && state.serverId != null) {
      await put(StorageKeys.lastConnectedServer, state.serverId);
    }
  }
  
  static VpnConnectionModel? getVpnState() {
    return get<VpnConnectionModel>(StorageKeys.vpnConnectionState);
  }
  
  static String? getCurrentServerId() {
    return get<String>(StorageKeys.currentServer);
  }
  
  static String? getLastConnectedServerId() {
    return get<String>(StorageKeys.lastConnectedServer);
  }
  
  static Future<void> saveSelectedServer(String serverId) async {
    await put(StorageKeys.selectedServerId, serverId);
  }
  
  static String? getSelectedServerId() {
    return get<String>(StorageKeys.selectedServerId);
  }
  
  static Future<void> saveVpnStatistics(VpnStatistics stats) async {
    await put(StorageKeys.vpnStatistics, stats);
  }
  
  static VpnStatistics? getVpnStatistics() {
    return get<VpnStatistics>(StorageKeys.vpnStatistics);
  }
  
  // Server Data Methods
  static Future<void> saveServersList(ServerListModel serverList) async {
    await put(StorageKeys.serversList, serverList, boxName: StorageKeys.serversBox);
    await put(StorageKeys.serversLastUpdate, DateTime.now(), boxName: StorageKeys.serversBox);
  }
  
  static ServerListModel? getServersList() {
    return get<ServerListModel>(StorageKeys.serversList, boxName: StorageKeys.serversBox);
  }
  
  static DateTime? getServersLastUpdate() {
    return get<DateTime>(StorageKeys.serversLastUpdate, boxName: StorageKeys.serversBox);
  }
  
  static Future<void> saveFavoriteServers(List<String> serverIds) async {
    await put(StorageKeys.favoriteServers, serverIds, boxName: StorageKeys.serversBox);
  }
  
  static List<String> getFavoriteServers() {
    final favorites = get<List>(StorageKeys.favoriteServers, boxName: StorageKeys.serversBox);
    return favorites?.cast<String>() ?? [];
  }
  
  static Future<void> addFavoriteServer(String serverId) async {
    final favorites = getFavoriteServers();
    if (!favorites.contains(serverId)) {
      favorites.add(serverId);
      await saveFavoriteServers(favorites);
    }
  }
  
  static Future<void> removeFavoriteServer(String serverId) async {
    final favorites = getFavoriteServers();
    favorites.remove(serverId);
    await saveFavoriteServers(favorites);
  }
  
  static Future<void> saveServerUsageCount(Map<String, int> usageCount) async {
    await put(StorageKeys.serverUsageCount, usageCount, boxName: StorageKeys.serversBox);
  }
  
  static Map<String, int> getServerUsageCount() {
    final usage = get<Map>(StorageKeys.serverUsageCount, boxName: StorageKeys.serversBox);
    return usage?.cast<String, int>() ?? {};
  }
  
  static Future<void> incrementServerUsage(String serverId) async {
    final usageCount = getServerUsageCount();
    usageCount[serverId] = (usageCount[serverId] ?? 0) + 1;
    await saveServerUsageCount(usageCount);
  }
  
  // Settings Methods
  static Future<void> saveSetting<T>(String key, T value) async {
    await put(key, value, boxName: StorageKeys.settingsBox);
  }
  
  static T? getSetting<T>(String key, {T? defaultValue}) {
    return get<T>(key, defaultValue: defaultValue, boxName: StorageKeys.settingsBox);
  }
  
  static Future<void> saveAppSettings(Map<String, dynamic> settings) async {
    await put(StorageKeys.appSettings, settings, boxName: StorageKeys.settingsBox);
  }
  
  static Map<String, dynamic> getAppSettings() {
    final settings = get<Map>(StorageKeys.appSettings, boxName: StorageKeys.settingsBox);
    return settings?.cast<String, dynamic>() ?? {};
  }
  
  // Onboarding & First Launch
  static Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await put(StorageKeys.isFirstLaunch, isFirstLaunch, boxName: StorageKeys.settingsBox);
  }
  
  static bool isFirstLaunch() {
    return get<bool>(StorageKeys.isFirstLaunch, defaultValue: true, boxName: StorageKeys.settingsBox) ?? true;
  }
  
  static Future<void> setOnboardingCompleted(bool completed) async {
    await put(StorageKeys.onboardingCompleted, completed, boxName: StorageKeys.settingsBox);
  }
  
  static bool isOnboardingCompleted() {
    return get<bool>(StorageKeys.onboardingCompleted, defaultValue: false, boxName: StorageKeys.settingsBox) ?? false;
  }
  
  static Future<void> setVpnPermissionGranted(bool granted) async {
    await put(StorageKeys.vpnPermissionGranted, granted, boxName: StorageKeys.settingsBox);
  }
  
  static bool isVpnPermissionGranted() {
    return get<bool>(StorageKeys.vpnPermissionGranted, defaultValue: false, boxName: StorageKeys.settingsBox) ?? false;
  }
  
  // Cache Methods
  static Future<void> cacheData<T>(String key, T data, {Duration? expiry}) async {
    final cacheEntry = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await put(key, cacheEntry, boxName: StorageKeys.cacheBox);
  }
  
  static T? getCachedData<T>(String key) {
    final cacheEntry = get<Map>(key, boxName: StorageKeys.cacheBox);
    if (cacheEntry == null) return null;
    
    final timestamp = cacheEntry['timestamp'] as int?;
    final expiry = cacheEntry['expiry'] as int?;
    
    if (timestamp != null && expiry != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > expiry) {
        // Cache expired, delete it
        delete(key, boxName: StorageKeys.cacheBox);
        return null;
      }
    }
    
    return cacheEntry['data'] as T?;
  }
  
  static Future<void> clearExpiredCache() async {
    final box = HiveBoxes.cacheBox;
    final keysToDelete = <dynamic>[];
    
    for (final key in box.keys) {
      final cacheEntry = box.get(key);
      if (cacheEntry is Map) {
        final timestamp = cacheEntry['timestamp'] as int?;
        final expiry = cacheEntry['expiry'] as int?;
        
        if (timestamp != null && expiry != null) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now - timestamp > expiry) {
            keysToDelete.add(key);
          }
        }
      }
    }
    
    for (final key in keysToDelete) {
      await box.delete(key);
    }
  }
  
  // Analytics & Usage Tracking
  static Future<void> incrementAppLaunchCount() async {
    final count = get<int>(StorageKeys.appLaunchCount, defaultValue: 0) ?? 0;
    await put(StorageKeys.appLaunchCount, count + 1);
  }
  
  static int getAppLaunchCount() {
    return get<int>(StorageKeys.appLaunchCount, defaultValue: 0) ?? 0;
  }
  
  static Future<void> updateLastActiveDate() async {
    await put(StorageKeys.lastActiveDate, DateTime.now());
  }
  
  static DateTime? getLastActiveDate() {
    return get<DateTime>(StorageKeys.lastActiveDate);
  }
  
  static Future<void> saveFeatureUsageStats(Map<String, int> stats) async {
    await put(StorageKeys.featureUsageStats, stats);
  }
  
  static Map<String, int> getFeatureUsageStats() {
    final stats = get<Map>(StorageKeys.featureUsageStats);
    return stats?.cast<String, int>() ?? {};
  }
  
  // Security Methods
  static Future<void> saveFcmToken(String token) async {
    await put(StorageKeys.fcmToken, token, boxName: StorageKeys.deviceBox);
  }
  
  static String? getFcmToken() {
    return get<String>(StorageKeys.fcmToken, boxName: StorageKeys.deviceBox);
  }
  
  static Future<void> saveDeviceFingerprint(String fingerprint) async {
    await put(StorageKeys.deviceFingerprint, fingerprint, boxName: StorageKeys.deviceBox);
  }
  
  static String? getDeviceFingerprint() {
    return get<String>(StorageKeys.deviceFingerprint, boxName: StorageKeys.deviceBox);
  }
  
  // Backup & Export Methods
  static Map<String, dynamic> exportUserData() {
    final userData = <String, dynamic>{};
    
    // Export user info
    final user = getUser();
    if (user != null) userData['user'] = user.toJson();
    
    // Export subscription
    final subscription = getSubscription();
    if (subscription != null) userData['subscription'] = subscription.toJson();
    
    // Export timer data
    final timer = getTimer();
    if (timer != null) userData['timer'] = timer.toJson();
    
    // Export settings
    userData['settings'] = getAppSettings();
    
    // Export favorites
    userData['favorite_servers'] = getFavoriteServers();
    
    userData['export_date'] = DateTime.now().toIso8601String();
    userData['app_version'] = '1.0.0';
    
    return userData;
  }
  
  static Future<bool> importUserData(Map<String, dynamic> data) async {
    try {
      // Import user
      if (data.containsKey('user')) {
        final user = UserModel.fromJson(data['user']);
        await saveUser(user);
      }
      
      // Import subscription
      if (data.containsKey('subscription')) {
        final subscription = SubscriptionModel.fromJson(data['subscription']);
        await saveSubscription(subscription);
      }
      
      // Import timer
      if (data.containsKey('timer')) {
        final timer = UsageTimerModel.fromJson(data['timer']);
        await saveTimer(timer);
      }
      
      // Import settings
      if (data.containsKey('settings')) {
        await saveAppSettings(data['settings']);
      }
      
      // Import favorites
      if (data.containsKey('favorite_servers')) {
        await saveFavoriteServers(List<String>.from(data['favorite_servers']));
      }
      
      return true;
    } catch (e) {
      print('Error importing user data: $e');
      return false;
    }
  }
  
  // Maintenance Methods
  static Future<void> performMaintenance() async {
    await clearExpiredCache();
    await HiveBoxes.performCleanup();
  }
  
  static Future<void> resetApp() async {
    await HiveBoxes.clearAll();
    await setFirstLaunch(true);
    await setOnboardingCompleted(false);
  }
  
  static Future<void> logout() async {
    await HiveBoxes.clearUserData();
    await clearUser();
  }
  
  // Storage Info
  static Map<String, dynamic> getStorageInfo() {
    return {
      'total_size': HiveBoxes.getTotalStorageSize(),
      'box_stats': HiveBoxes.getStorageStats(),
      'health_status': HiveBoxes.getBoxHealthStatus(),
      'needs_cleanup': HiveBoxes.needsCleanup(),
      'is_initialized': HiveBoxes.isInitialized,
    };
  }
  
  // Close storage
  static Future<void> close() async {
    await HiveBoxes.close();
  }
}