import 'dart:convert';
import '../storage/hive_storage.dart';
import '../storage/storage_keys.dart';
import '../models/user_model.dart';
import '../models/device_model.dart';
import '../models/subscription_model.dart';
import '../models/vpn_server_model.dart';
import '../models/vpn_state_model.dart';
import '../models/usage_timer_model.dart';
import '../models/receipt_model.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  bool _isInitialized = false;

  // Initialize storage service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await HiveStorage.init();
    _isInitialized = true;
    print('✅ Storage service initialized');
  }

  // User Management
  Future<void> saveUser(UserModel user) async {
    await HiveStorage.saveUser(user);
    await HiveStorage.updateLastActiveDate();
    print('💾 User saved: ${user.username}');
  }

  UserModel? getUser() {
    return HiveStorage.getUser();
  }

  bool isUserLoggedIn() {
    return HiveStorage.isUserLoggedIn();
  }

  Future<void> clearUser() async {
    await HiveStorage.clearUser();
    print('🗑️ User data cleared');
  }

  // Device Management
  Future<void> saveDevice(DeviceModel device) async {
    await HiveStorage.saveDevice(device);
    print('📱 Device saved: ${device.deviceName}');
  }

  DeviceModel? getDevice() {
    return HiveStorage.getDevice();
  }

  String? getDeviceId() {
    return HiveStorage.getDeviceId();
  }

  bool isDeviceRegistered() {
    return HiveStorage.isDeviceRegistered();
  }

  Future<void> updateDeviceRegistration(bool isRegistered) async {
    await HiveStorage.updateDeviceRegistration(isRegistered);
    print('📱 Device registration updated: $isRegistered');
  }

  // Subscription Management
  Future<void> saveSubscription(SubscriptionModel subscription) async {
    await HiveStorage.saveSubscription(subscription);
    print('💳 Subscription saved: ${subscription.productId}');
  }

  SubscriptionModel? getSubscription() {
    return HiveStorage.getSubscription();
  }

  bool isPremiumUser() {
    return HiveStorage.isPremiumUser();
  }

  Future<void> saveReceipt(ReceiptModel receipt) async {
    await HiveStorage.saveReceipt(receipt);
    print('🧾 Receipt saved: ${receipt.transactionId}');
  }

  ReceiptModel? getReceipt() {
    return HiveStorage.getReceipt();
  }

  Future<void> saveSubscriptionHistory(List<SubscriptionModel> history) async {
    await HiveStorage.saveSubscriptionHistory(history);
  }

  List<SubscriptionModel> getSubscriptionHistory() {
    return HiveStorage.getSubscriptionHistory();
  }

  // Timer Management
  Future<void> saveTimer(UsageTimerModel timer) async {
    await HiveStorage.saveTimer(timer);
    print('⏱️ Timer saved: ${timer.totalUsedTime}');
  }

  UsageTimerModel? getTimer() {
    return HiveStorage.getTimer();
  }

  Duration getTotalUsedTime() {
    return HiveStorage.getTotalUsedTime();
  }

  Duration getRemainingTime() {
    return HiveStorage.getRemainingTime();
  }

  bool isTimerActive() {
    return HiveStorage.isTimerActive();
  }

  DateTime? getLastTimerReset() {
    return HiveStorage.getLastTimerReset();
  }

  Future<void> saveCurrentSessionStart(DateTime startTime) async {
    await HiveStorage.saveCurrentSessionStart(startTime);
  }

  DateTime? getCurrentSessionStart() {
    return HiveStorage.getCurrentSessionStart();
  }

  Future<void> saveUsageSessions(List<UsageSessionModel> sessions) async {
    await HiveStorage.saveUsageSessions(sessions);
  }

  List<UsageSessionModel> getUsageSessions() {
    return HiveStorage.getUsageSessions();
  }

  // VPN State Management
  Future<void> saveVpnState(VpnConnectionModel state) async {
    await HiveStorage.saveVpnState(state);
    print('🔐 VPN state saved: ${state.status}');
  }

  VpnConnectionModel? getVpnState() {
    return HiveStorage.getVpnState();
  }

  String? getCurrentServerId() {
    return HiveStorage.getCurrentServerId();
  }

  String? getLastConnectedServerId() {
    return HiveStorage.getLastConnectedServerId();
  }

  Future<void> saveSelectedServer(String serverId) async {
    await HiveStorage.saveSelectedServer(serverId);
  }

  String? getSelectedServerId() {
    return HiveStorage.getSelectedServerId();
  }

  Future<void> saveVpnStatistics(VpnStatistics stats) async {
    await HiveStorage.saveVpnStatistics(stats);
  }

  VpnStatistics? getVpnStatistics() {
    return HiveStorage.getVpnStatistics();
  }

  // Server Management
  Future<void> saveServersList(ServerListModel serverList) async {
    await HiveStorage.saveServersList(serverList);
    print('🌐 Servers saved: ${serverList.servers.length} servers');
  }

  ServerListModel? getServersList() {
    return HiveStorage.getServersList();
  }

  DateTime? getServersLastUpdate() {
    return HiveStorage.getServersLastUpdate();
  }

  Future<void> saveFavoriteServers(List<String> serverIds) async {
    await HiveStorage.saveFavoriteServers(serverIds);
  }

  List<String> getFavoriteServers() {
    return HiveStorage.getFavoriteServers();
  }

  Future<void> addFavoriteServer(String serverId) async {
    await HiveStorage.addFavoriteServer(serverId);
    print('⭐ Server added to favorites: $serverId');
  }

  Future<void> removeFavoriteServer(String serverId) async {
    await HiveStorage.removeFavoriteServer(serverId);
    print('⭐ Server removed from favorites: $serverId');
  }

  Future<void> saveServerUsageCount(Map<String, int> usageCount) async {
    await HiveStorage.saveServerUsageCount(usageCount);
  }

  Map<String, int> getServerUsageCount() {
    return HiveStorage.getServerUsageCount();
  }

  Future<void> incrementServerUsage(String serverId) async {
    await HiveStorage.incrementServerUsage(serverId);
  }

  // Settings Management
  Future<void> saveSetting<T>(String key, T value) async {
    await HiveStorage.saveSetting(key, value);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return HiveStorage.getSetting<T>(key, defaultValue: defaultValue);
  }

  Future<void> saveAppSettings(Map<String, dynamic> settings) async {
    await HiveStorage.saveAppSettings(settings);
  }

  Map<String, dynamic> getAppSettings() {
    return HiveStorage.getAppSettings();
  }

  // Onboarding & First Launch
  Future<void> setFirstLaunch(bool isFirstLaunch) async {
    await HiveStorage.setFirstLaunch(isFirstLaunch);
  }

  bool isFirstLaunch() {
    return HiveStorage.isFirstLaunch();
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    await HiveStorage.setOnboardingCompleted(completed);
  }

  bool isOnboardingCompleted() {
    return HiveStorage.isOnboardingCompleted();
  }

  Future<void> setVpnPermissionGranted(bool granted) async {
    await HiveStorage.setVpnPermissionGranted(granted);
  }

  bool isVpnPermissionGranted() {
    return HiveStorage.isVpnPermissionGranted();
  }

  // Cache Management
  Future<void> cacheData<T>(String key, T data, {Duration? expiry}) async {
    await HiveStorage.cacheData(key, data, expiry: expiry);
  }

  T? getCachedData<T>(String key) {
    return HiveStorage.getCachedData<T>(key);
  }

  Future<void> clearExpiredCache() async {
    await HiveStorage.clearExpiredCache();
    print('🧹 Expired cache cleared');
  }

  // Analytics & Usage Tracking
  Future<void> incrementAppLaunchCount() async {
    await HiveStorage.incrementAppLaunchCount();
  }

  int getAppLaunchCount() {
    return HiveStorage.getAppLaunchCount();
  }

  Future<void> updateLastActiveDate() async {
    await HiveStorage.updateLastActiveDate();
  }

  DateTime? getLastActiveDate() {
    return HiveStorage.getLastActiveDate();
  }

  Future<void> saveFeatureUsageStats(Map<String, int> stats) async {
    await HiveStorage.saveFeatureUsageStats(stats);
  }

  Map<String, int> getFeatureUsageStats() {
    return HiveStorage.getFeatureUsageStats();
  }

  // Security Management
  Future<void> saveFcmToken(String token) async {
    await HiveStorage.saveFcmToken(token);
  }

  String? getFcmToken() {
    return HiveStorage.getFcmToken();
  }

  Future<void> saveDeviceFingerprint(String fingerprint) async {
    await HiveStorage.saveDeviceFingerprint(fingerprint);
  }

  String? getDeviceFingerprint() {
    return HiveStorage.getDeviceFingerprint();
  }

  // Data Export & Import
  Map<String, dynamic> exportUserData() {
    return HiveStorage.exportUserData();
  }

  Future<bool> importUserData(Map<String, dynamic> data) async {
    final success = await HiveStorage.importUserData(data);
    if (success) {
      print('📥 User data imported successfully');
    } else {
      print('❌ Failed to import user data');
    }
    return success;
  }

  // Backup & Restore
  Future<String> createBackup() async {
    final data = exportUserData();
    data['backup_version'] = '1.0.0';
    data['created_at'] = DateTime.now().toIso8601String();

    final jsonString = jsonEncode(data);
    print('💾 Backup created (${jsonString.length} bytes)');
    return jsonString;
  }

  Future<bool> restoreFromBackup(String backupJson) async {
    try {
      final data = jsonDecode(backupJson) as Map<String, dynamic>;

      // Validate backup
      if (!data.containsKey('backup_version')) {
        print('❌ Invalid backup format');
        return false;
      }

      final success = await importUserData(data);
      if (success) {
        print('✅ Backup restored successfully');
      }
      return success;
    } catch (e) {
      print('❌ Failed to restore backup: $e');
      return false;
    }
  }

  // Maintenance
  Future<void> performMaintenance() async {
    await HiveStorage.performMaintenance();
    print('🧹 Storage maintenance completed');
  }

  Future<void> resetApp() async {
    await HiveStorage.resetApp();
    print('🔄 App reset completed');
  }

  Future<void> logout() async {
    await HiveStorage.logout();
    print('👋 User logged out');
  }

  // Storage Information
  Map<String, dynamic> getStorageInfo() {
    return HiveStorage.getStorageInfo();
  }

  // Helper methods for specific data operations
  Future<void> updateUserSubscriptionStatus(bool isPremium) async {
    final user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(isPremium: isPremium);
      await saveUser(updatedUser);
    }
  }

  Future<void> updateDeviceLastActive() async {
    final device = getDevice();
    if (device != null) {
      final updatedDevice = device.copyWith(lastActiveAt: DateTime.now());
      await saveDevice(updatedDevice);
    }
  }

  Future<void> addUsageSession(UsageSessionModel session) async {
    final sessions = getUsageSessions();
    sessions.add(session);
    await saveUsageSessions(sessions);
  }

  Future<void> updateTimerSession(UsageSessionModel updatedSession) async {
    final sessions = getUsageSessions();
    final index = sessions.indexWhere(
      (s) => s.startTime == updatedSession.startTime,
    );
    if (index != -1) {
      sessions[index] = updatedSession;
      await saveUsageSessions(sessions);
    }
  }

  // Quick access methods
  bool get hasUser => getUser() != null;
  bool get hasDevice => getDevice() != null;
  bool get hasSubscription => getSubscription() != null;
  bool get hasActiveTimer => isTimerActive();
  bool get isSetupComplete => isOnboardingCompleted() && isDeviceRegistered();

  // Data validation methods
  bool isDataConsistent() {
    try {
      // Check if critical data exists and is valid
      final user = getUser();
      final device = getDevice();

      if (isUserLoggedIn() && user == null) return false;
      if (isDeviceRegistered() && device == null) return false;
      if (isPremiumUser() && getSubscription() == null) return false;

      return true;
    } catch (e) {
      print('❌ Data consistency check failed: $e');
      return false;
    }
  }

  Future<void> fixDataInconsistencies() async {
    try {
      // Fix user login state
      if (isUserLoggedIn() && getUser() == null) {
        await clearUser();
      }

      // Fix device registration state
      if (isDeviceRegistered() && getDevice() == null) {
        await updateDeviceRegistration(false);
      }

      // Fix premium status
      if (isPremiumUser() && getSubscription() == null) {
        await saveSetting(StorageKeys.isPremiumUser, false);
      }

      print('🔧 Data inconsistencies fixed');
    } catch (e) {
      print('❌ Failed to fix data inconsistencies: $e');
    }
  }

  // Close storage service
  Future<void> close() async {
    await HiveStorage.close();
    _isInitialized = false;
    print('🔒 Storage service closed');
  }
}
