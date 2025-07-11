class AppConfig {
  static const String appName = '360AI VPN';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';

  // App Settings
  static const Duration freeUserTimeLimit = Duration(hours: 1);
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration apiTimeout = Duration(seconds: 15);

  // Free user limitations
  static const int maxFreeServers = 3;
  static const bool allowFreeUserServerSelection = false;
  static const Duration freeUserResetInterval = Duration(hours: 24);

  // Timer settings
  static const Duration timerUpdateInterval = Duration(seconds: 1);
  static const Duration backgroundTimerInterval = Duration(minutes: 1);

  // Subscription settings
  static const Duration subscriptionCheckInterval = Duration(hours: 1);
  static const Duration receiptValidationTimeout = Duration(seconds: 10);

  // VPN Settings
  static const Duration vpnStateCheckInterval = Duration(seconds: 5);
  static const Duration vpnReconnectDelay = Duration(seconds: 3);
  static const int maxReconnectAttempts = 3;

  // Notification settings
  static const String channelId = 'vpn_notifications';
  static const String channelName = '360AI VPN';
  static const String channelDescription = 'VPN connection notifications';

  // Storage settings
  static const String hiveBoxName = 'vpn_app_box';
  static const String userBoxName = 'user_box';
  static const String subscriptionBoxName = 'subscription_box';
  static const String timerBoxName = 'timer_box';
  static const String settingsBoxName = 'settings_box';

  // App Store / Play Store
  static const String iosAppId = '1234567890';
  static const String androidPackageName = 'com.example.vpn360ai';

  // Privacy & Terms
  static const String privacyPolicyUrl = 'https://your-domain.com/privacy';
  static const String termsOfServiceUrl = 'https://your-domain.com/terms';
  static const String supportUrl = 'https://your-domain.com/support';
  static const String supportEmail = 'support@your-domain.com';

  // Analytics & Crash Reporting
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;

  // Development flags
  static const bool isDebugMode = bool.fromEnvironment(
    'DEBUG',
    defaultValue: false,
  );
  static const bool enableLogging = bool.fromEnvironment(
    'LOGGING',
    defaultValue: true,
  );
  static const bool mockNetworkCalls = bool.fromEnvironment(
    'MOCK_NETWORK',
    defaultValue: false,
  );

  // Feature flags
  static const bool enableSpeedTest = true;
  static const bool enableKillSwitch = true;
  static const bool enableAutoConnect = true;
  static const bool enableSplitTunneling = false;

  // Default server selection
  static const String defaultServerCountry = 'United States';
  static const String defaultServerProtocol = 'vmess';
}
