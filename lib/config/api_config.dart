class ApiConfig {
  // Base URLs
  static const String baseUrl = 'https://dash.bgtunnel.com/api';
  static const String userApiUrl = '$baseUrl/user';

  // Authentication
  static const String bearerToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjYWtyNCIsImFjY2VzcyI6InN1ZG8iLCJpYXQiOjE3NTIxMTQ4NTAsImV4cCI6MjY5ODE5NDg1MH0.dgrg9VrfkWvEqjT45i74AZq1UxSeZ9xA27J9pV5rCXY';

  // API Endpoints
  static String userEndpoint(String deviceId) => '$userApiUrl/$deviceId';
  static const String registerDeviceEndpoint = '$baseUrl/device/register';
  static const String validateReceiptEndpoint =
      '$baseUrl/subscription/validate';
  static const String subscriptionStatusEndpoint =
      '$baseUrl/subscription/status';
  static const String serversEndpoint = '$baseUrl/servers';
  static const String usageStatsEndpoint = '$baseUrl/usage';

  // Headers
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $bearerToken',
    'User-Agent': '360AI-VPN/1.0.0',
  };

  static Map<String, String> get authHeaders => {
    ...defaultHeaders,
    'X-Device-Platform': 'mobile',
  };

  // HTTP Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusTooManyRequests = 429;
  static const int statusInternalServerError = 500;
  static const int statusServiceUnavailable = 503;

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const Duration backoffMultiplier = Duration(seconds: 1);

  // Response field names
  static const String proxiesField = 'proxies';
  static const String linksField = 'links';
  static const String expireField = 'expire';
  static const String dataLimitField = 'data_limit';
  static const String usedTrafficField = 'used_traffic';
  static const String statusField = 'status';
  static const String usernameField = 'username';
  static const String createdAtField = 'created_at';
  static const String onlineAtField = 'online_at';

  // Device registration fields
  static const String deviceIdField = 'device_id';
  static const String deviceNameField = 'device_name';
  static const String devicePlatformField = 'platform';
  static const String deviceVersionField = 'version';
  static const String deviceModelField = 'model';
  static const String appVersionField = 'app_version';

  // Subscription fields
  static const String receiptDataField = 'receipt_data';
  static const String productIdField = 'product_id';
  static const String transactionIdField = 'transaction_id';
  static const String purchaseDateField = 'purchase_date';
  static const String expirationDateField = 'expiration_date';

  // Error response fields
  static const String errorField = 'error';
  static const String messageField = 'message';
  static const String codeField = 'code';
  static const String detailsField = 'details';

  // Subscription product IDs
  static const String monthlyProductId = 'com.vpn360ai.monthly';
  static const String yearlyProductId = 'com.vpn360ai.yearly';
  static const String lifetimeProductId = 'com.vpn360ai.lifetime';

  // App Store specific
  static const String appStoreReceiptUrl =
      'https://buy.itunes.apple.com/verifyReceipt';
  static const String appStoreSandboxReceiptUrl =
      'https://sandbox.itunes.apple.com/verifyReceipt';

  // Google Play specific
  static const String playStoreValidationUrl =
      'https://androidpublisher.googleapis.com/androidpublisher/v3';

  // Cache configuration
  static const Duration cacheExpiration = Duration(minutes: 5);
  static const int maxCacheSize = 50; // Maximum number of cached responses

  // Rate limiting
  static const int apiCallsPerMinute = 60;
  static const Duration rateLimitWindow = Duration(minutes: 1);
}
