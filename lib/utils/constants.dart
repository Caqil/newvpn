// App Constants
class AppConstants {
  // App Info
  static const String appName = '360AI VPN';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
  static const String packageName = 'com.vpn360ai.app';

  // Time Limits
  static const Duration freeUserTimeLimit = Duration(hours: 1);
  static const Duration premiumUserTimeLimit = Duration(days: 365); // Unlimited
  static const Duration timerUpdateInterval = Duration(seconds: 1);
  static const Duration backgroundTimerCheck = Duration(minutes: 1);

  // Connection Settings
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration reconnectDelay = Duration(seconds: 5);
  static const int maxReconnectAttempts = 3;
  static const Duration vpnStateCheckInterval = Duration(seconds: 2);

  // API Settings
  static const Duration apiTimeout = Duration(seconds: 15);
  static const Duration cacheExpiration = Duration(minutes: 5);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // Subscription
  static const Duration subscriptionCheckInterval = Duration(hours: 1);
  static const Duration receiptValidationTimeout = Duration(seconds: 10);
  static const int maxValidationAttempts = 5;

  // Notifications
  static const Duration warningNotificationThreshold = Duration(minutes: 10);
  static const Duration limitReachedNotificationDelay = Duration(seconds: 5);

  // Storage Keys
  static const String userDataKey = 'user_data';
  static const String deviceDataKey = 'device_data';
  static const String subscriptionDataKey = 'subscription_data';
  static const String timerDataKey = 'timer_data';
  static const String serversDataKey = 'servers_data';
  static const String settingsDataKey = 'settings_data';
  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String firstLaunchKey = 'first_launch';
  static const String lastActiveKey = 'last_active';

  // Hive Box Names
  static const String mainBoxName = 'vpn_app_box';
  static const String userBoxName = 'user_box';
  static const String subscriptionBoxName = 'subscription_box';
  static const String timerBoxName = 'timer_box';
  static const String settingsBoxName = 'settings_box';

  // File Paths
  static const String documentsFolder = 'documents';
  static const String cacheFolder = 'cache';
  static const String logsFolder = 'logs';

  // Network
  static const String userAgent = '360AI-VPN/1.0.0';
  static const Map<String, String> defaultHeaders = {
    'User-Agent': userAgent,
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // Error Messages
  static const String connectionErrorMessage =
      'Failed to connect to VPN server';
  static const String authErrorMessage = 'Authentication failed';
  static const String timeLimitErrorMessage = 'Free time limit reached';
  static const String networkErrorMessage = 'Network connection error';
  static const String serverErrorMessage = 'Server error occurred';
  static const String validationErrorMessage = 'Receipt validation failed';

  // Default Values
  static const String defaultCountry = 'United States';
  static const String defaultProtocol = 'vmess';
  static const String defaultCurrency = 'USD';
  static const String defaultLanguage = 'en';
  static const String defaultTimezone = 'UTC';

  // Subscription Product IDs
  static const String monthlyProductId = 'com.vpn360ai.monthly';
  static const String yearlyProductId = 'com.vpn360ai.yearly';
  static const String lifetimeProductId = 'com.vpn360ai.lifetime';

  // URLs
  static const String baseApiUrl = 'https://dash.bgtunnel.com/api';
  static const String privacyPolicyUrl = 'https://your-domain.com/privacy';
  static const String termsOfServiceUrl = 'https://your-domain.com/terms';
  static const String supportUrl = 'https://your-domain.com/support';
  static const String supportEmail = 'support@your-domain.com';

  // Platform specific
  static const String iosAppId = '1234567890';
  static const String androidPackageName = packageName;

  // Analytics Events
  static const String eventAppLaunched = 'app_launched';
  static const String eventVpnConnected = 'vpn_connected';
  static const String eventVpnDisconnected = 'vpn_disconnected';
  static const String eventSubscriptionPurchased = 'subscription_purchased';
  static const String eventTimeLimitReached = 'time_limit_reached';
  static const String eventServerSelected = 'server_selected';

  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableSpeedTest = true;
  static const bool enableKillSwitch = true;
  static const bool enableAutoConnect = true;
  static const bool enableBackgroundRefresh = true;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double iconSize = 24.0;
  static const double largeIconSize = 48.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Validation Rules
  static const int minPasswordLength = 6;
  static const int maxUsernameLength = 50;
  static const int maxDeviceNameLength = 100;

  // Server Quality Thresholds
  static const int excellentPingThreshold = 50;
  static const int goodPingThreshold = 100;
  static const int fairPingThreshold = 200;
  static const double serverOverloadThreshold = 0.9;

  // Data Limits
  static const int defaultDataLimitGB = 10;
  static const int premiumDataLimitGB = -1; // Unlimited

  // Country Codes and Flags
  static const Map<String, String> countryFlags = {
    'US': '🇺🇸',
    'GB': '🇬🇧',
    'DE': '🇩🇪',
    'FR': '🇫🇷',
    'JP': '🇯🇵',
    'SG': '🇸🇬',
    'CA': '🇨🇦',
    'AU': '🇦🇺',
    'NL': '🇳🇱',
    'SE': '🇸🇪',
    'NO': '🇳🇴',
    'CH': '🇨🇭',
    'ES': '🇪🇸',
    'IT': '🇮🇹',
    'RU': '🇷🇺',
    'KR': '🇰🇷',
    'CN': '🇨🇳',
    'IN': '🇮🇳',
    'BR': '🇧🇷',
    'MX': '🇲🇽',
    'TR': '🇹🇷',
  };

  // Protocol Icons (using system icons)
  static const Map<String, String> protocolNames = {
    'vmess': 'VMess',
    'vless': 'VLESS',
    'trojan': 'Trojan',
    'shadowsocks': 'Shadowsocks',
    'ss': 'Shadowsocks',
  };

  // Default Ports
  static const Map<String, int> defaultPorts = {
    'vmess': 443,
    'vless': 443,
    'trojan': 443,
    'shadowsocks': 1080,
    'ss': 1080,
  };

  // Environment
  static const bool isProduction = bool.fromEnvironment(
    'PRODUCTION',
    defaultValue: false,
  );
  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: true);
  static const bool enableLogging = bool.fromEnvironment(
    'LOGGING',
    defaultValue: true,
  );
  static const bool mockNetworkCalls = bool.fromEnvironment(
    'MOCK_NETWORK',
    defaultValue: false,
  );
}
