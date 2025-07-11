class StorageKeys {
  // Box Names
  static const String mainBox = 'vpn_app_box';
  static const String userBox = 'user_box';
  static const String deviceBox = 'device_box';
  static const String subscriptionBox = 'subscription_box';
  static const String timerBox = 'timer_box';
  static const String serversBox = 'servers_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';

  // User Data Keys
  static const String currentUser = 'current_user';
  static const String userProfile = 'user_profile';
  static const String userPreferences = 'user_preferences';
  static const String isUserLoggedIn = 'is_user_logged_in';
  static const String lastLoginDate = 'last_login_date';
  static const String userRegistrationDate = 'user_registration_date';

  // Device Data Keys
  static const String deviceInfo = 'device_info';
  static const String deviceId = 'device_id';
  static const String deviceName = 'device_name';
  static const String deviceRegistered = 'device_registered';
  static const String deviceRegistrationDate = 'device_registration_date';
  static const String deviceFingerprint = 'device_fingerprint';
  static const String fcmToken = 'fcm_token';
  static const String devicePermissions = 'device_permissions';

  // Subscription Data Keys
  static const String currentSubscription = 'current_subscription';
  static const String subscriptionHistory = 'subscription_history';
  static const String receiptData = 'receipt_data';
  static const String lastReceiptValidation = 'last_receipt_validation';
  static const String subscriptionStatus = 'subscription_status';
  static const String isPremiumUser = 'is_premium_user';
  static const String subscriptionExpiry = 'subscription_expiry';
  static const String autoRenewEnabled = 'auto_renew_enabled';

  // Timer Data Keys
  static const String usageTimer = 'usage_timer';
  static const String totalUsedTime = 'total_used_time';
  static const String remainingTime = 'remaining_time';
  static const String lastTimerReset = 'last_timer_reset';
  static const String currentSessionStart = 'current_session_start';
  static const String usageSessions = 'usage_sessions';
  static const String isTimerActive = 'is_timer_active';
  static const String timerWarningShown = 'timer_warning_shown';
  static const String dailyUsageLimit = 'daily_usage_limit';

  // VPN Connection Keys
  static const String vpnConnectionState = 'vpn_connection_state';
  static const String currentServer = 'current_server';
  static const String selectedServerId = 'selected_server_id';
  static const String lastConnectedServer = 'last_connected_server';
  static const String connectionHistory = 'connection_history';
  static const String vpnStatistics = 'vpn_statistics';
  static const String autoConnectEnabled = 'auto_connect_enabled';
  static const String killSwitchEnabled = 'kill_switch_enabled';

  // Server Data Keys
  static const String serversList = 'servers_list';
  static const String favoriteServers = 'favorite_servers';
  static const String serverUsageCount = 'server_usage_count';
  static const String serversLastUpdate = 'servers_last_update';
  static const String fastestServer = 'fastest_server';
  static const String recommendedServers = 'recommended_servers';
  static const String serverPingResults = 'server_ping_results';

  // App Settings Keys
  static const String appSettings = 'app_settings';
  static const String themeMode = 'theme_mode';
  static const String language = 'language';
  static const String autoStartVpn = 'auto_start_vpn';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';
  static const String backgroundRefreshEnabled = 'background_refresh_enabled';

  // Onboarding & First Launch Keys
  static const String isFirstLaunch = 'is_first_launch';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String permissionsRequested = 'permissions_requested';
  static const String vpnPermissionGranted = 'vpn_permission_granted';
  static const String notificationPermissionGranted =
      'notification_permission_granted';
  static const String tutorialCompleted = 'tutorial_completed';
  static const String ratingPromptShown = 'rating_prompt_shown';

  // Cache Keys
  static const String apiCache = 'api_cache';
  static const String userDataCache = 'user_data_cache';
  static const String serversCache = 'servers_cache';
  static const String subscriptionCache = 'subscription_cache';
  static const String lastCacheUpdate = 'last_cache_update';
  static const String cacheExpiry = 'cache_expiry';

  // Security Keys
  static const String encryptionKey = 'encryption_key';
  static const String biometricEnabled = 'biometric_enabled';
  static const String pinCode = 'pin_code';
  static const String lastSecurityCheck = 'last_security_check';
  static const String deviceTrusted = 'device_trusted';
  static const String securityLevel = 'security_level';

  // Analytics & Tracking Keys
  static const String appLaunchCount = 'app_launch_count';
  static const String totalAppUsage = 'total_app_usage';
  static const String lastActiveDate = 'last_active_date';
  static const String featureUsageStats = 'feature_usage_stats';
  static const String crashReports = 'crash_reports';
  static const String performanceMetrics = 'performance_metrics';

  // Network & Connectivity Keys
  static const String networkType = 'network_type';
  static const String lastKnownIp = 'last_known_ip';
  static const String dnsSettings = 'dns_settings';
  static const String proxySettings = 'proxy_settings';
  static const String networkPreferences = 'network_preferences';
  static const String connectionQuality = 'connection_quality';

  // Backup & Sync Keys
  static const String lastBackupDate = 'last_backup_date';
  static const String backupEnabled = 'backup_enabled';
  static const String syncEnabled = 'sync_enabled';
  static const String cloudBackupData = 'cloud_backup_data';
  static const String localBackupData = 'local_backup_data';

  // Debug & Development Keys
  static const String debugMode = 'debug_mode';
  static const String logLevel = 'log_level';
  static const String betaFeatures = 'beta_features';
  static const String developerMode = 'developer_mode';
  static const String testingFlags = 'testing_flags';

  // Notification Keys
  static const String notificationSettings = 'notification_settings';
  static const String lastNotificationShown = 'last_notification_shown';
  static const String notificationHistory = 'notification_history';
  static const String quietHours = 'quiet_hours';
  static const String notificationChannels = 'notification_channels';

  // Feature Flags Keys
  static const String featureFlags = 'feature_flags';
  static const String experimentalFeatures = 'experimental_features';
  static const String abTestingFlags = 'ab_testing_flags';
  static const String remoteConfig = 'remote_config';
  static const String featureRollout = 'feature_rollout';

  // Performance Keys
  static const String startupTime = 'startup_time';
  static const String connectionTime = 'connection_time';
  static const String apiResponseTimes = 'api_response_times';
  static const String memoryUsage = 'memory_usage';
  static const String batteryUsage = 'battery_usage';

  // Location & Server Selection Keys
  static const String userLocation = 'user_location';
  static const String nearestServers = 'nearest_servers';
  static const String geoIpData = 'geo_ip_data';
  static const String locationPreferences = 'location_preferences';
  static const String smartServerSelection = 'smart_server_selection';

  // Troubleshooting Keys
  static const String connectionIssues = 'connection_issues';
  static const String errorLogs = 'error_logs';
  static const String diagnosticData = 'diagnostic_data';
  static const String supportTickets = 'support_tickets';
  static const String troubleshootingSteps = 'troubleshooting_steps';

  // Migration Keys
  static const String dataVersion = 'data_version';
  static const String migrationStatus = 'migration_status';
  static const String legacyDataCleanup = 'legacy_data_cleanup';
  static const String schemaVersion = 'schema_version';

  // Temporary Keys (for session data)
  static const String tempPrefix = 'temp_';
  static const String sessionPrefix = 'session_';

  // Helper methods to create temporary keys
  static String tempKey(String key) => '$tempPrefix$key';
  static String sessionKey(String key) => '$sessionPrefix$key';

  // Helper methods to check key types
  static bool isTempKey(String key) => key.startsWith(tempPrefix);
  static bool isSessionKey(String key) => key.startsWith(sessionPrefix);

  // Get all user-related keys
  static List<String> get userRelatedKeys => [
    currentUser,
    userProfile,
    userPreferences,
    isUserLoggedIn,
    lastLoginDate,
    userRegistrationDate,
  ];

  // Get all device-related keys
  static List<String> get deviceRelatedKeys => [
    deviceInfo,
    deviceId,
    deviceName,
    deviceRegistered,
    deviceRegistrationDate,
    deviceFingerprint,
    fcmToken,
    devicePermissions,
  ];

  // Get all subscription-related keys
  static List<String> get subscriptionRelatedKeys => [
    currentSubscription,
    subscriptionHistory,
    receiptData,
    lastReceiptValidation,
    subscriptionStatus,
    isPremiumUser,
    subscriptionExpiry,
    autoRenewEnabled,
  ];

  // Get all timer-related keys
  static List<String> get timerRelatedKeys => [
    usageTimer,
    totalUsedTime,
    remainingTime,
    lastTimerReset,
    currentSessionStart,
    usageSessions,
    isTimerActive,
    timerWarningShown,
    dailyUsageLimit,
  ];

  // Get all VPN-related keys
  static List<String> get vpnRelatedKeys => [
    vpnConnectionState,
    currentServer,
    selectedServerId,
    lastConnectedServer,
    connectionHistory,
    vpnStatistics,
    autoConnectEnabled,
    killSwitchEnabled,
  ];

  // Get all server-related keys
  static List<String> get serverRelatedKeys => [
    serversList,
    favoriteServers,
    serverUsageCount,
    serversLastUpdate,
    fastestServer,
    recommendedServers,
    serverPingResults,
  ];

  // Get all settings-related keys
  static List<String> get settingsRelatedKeys => [
    appSettings,
    themeMode,
    language,
    autoStartVpn,
    notificationsEnabled,
    analyticsEnabled,
    crashReportingEnabled,
    backgroundRefreshEnabled,
  ];

  // Get all cache-related keys
  static List<String> get cacheRelatedKeys => [
    apiCache,
    userDataCache,
    serversCache,
    subscriptionCache,
    lastCacheUpdate,
    cacheExpiry,
  ];

  // Get all security-related keys
  static List<String> get securityRelatedKeys => [
    encryptionKey,
    biometricEnabled,
    pinCode,
    lastSecurityCheck,
    deviceTrusted,
    securityLevel,
  ];

  // Get sensitive keys that should be encrypted
  static List<String> get sensitiveKeys => [
    currentUser,
    receiptData,
    encryptionKey,
    pinCode,
    fcmToken,
    deviceFingerprint,
  ];

  // Get keys that should be backed up
  static List<String> get backupKeys => [
    ...userRelatedKeys,
    ...subscriptionRelatedKeys,
    ...settingsRelatedKeys,
    favoriteServers,
    serverUsageCount,
  ];

  // Get keys that should be cleared on logout
  static List<String> get logoutClearKeys => [
    ...userRelatedKeys,
    ...subscriptionRelatedKeys,
    ...timerRelatedKeys,
    ...vpnRelatedKeys,
    fcmToken,
  ];

  // Get keys that should be cleared on app reset
  static List<String> get resetClearKeys => [
    ...logoutClearKeys,
    ...cacheRelatedKeys,
    onboardingCompleted,
    tutorialCompleted,
    appLaunchCount,
    totalAppUsage,
  ];
}
