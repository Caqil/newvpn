import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_model.g.dart';

@HiveType(typeId: 60)
@JsonSerializable()
class ReceiptModel {
  @HiveField(0)
  final String receiptData;

  @HiveField(1)
  final String platform;

  @HiveField(2)
  final String productId;

  @HiveField(3)
  final String transactionId;

  @HiveField(4)
  final String? originalTransactionId;

  @HiveField(5)
  final DateTime purchaseDate;

  @HiveField(6)
  final DateTime? expirationDate;

  @HiveField(7)
  final DateTime? cancellationDate;

  @HiveField(8)
  final ReceiptStatus status;

  @HiveField(9)
  final DateTime lastValidatedAt;

  @HiveField(10)
  final DateTime? lastValidationAttemptAt;

  @HiveField(11)
  final int validationAttempts;

  @HiveField(12)
  final String? lastValidationError;

  @HiveField(13)
  final bool isValid;

  @HiveField(14)
  final bool isExpired;

  @HiveField(15)
  final bool isRefunded;

  @HiveField(16)
  final bool isInTrialPeriod;

  @HiveField(17)
  final bool isInIntroductoryPricePeriod;

  @HiveField(18)
  final bool isAutoRenewing;

  @HiveField(19)
  final String? subscriptionGroupId;

  @HiveField(20)
  final String? webOrderLineItemId;

  @HiveField(21)
  final Map<String, dynamic> storeSpecificData;

  @HiveField(22)
  final String? deviceId;

  @HiveField(23)
  final String? userId;

  @HiveField(24)
  final double? price;

  @HiveField(25)
  final String? currency;

  @HiveField(26)
  final String? countryCode;

  @HiveField(27)
  final Map<String, dynamic> validationResponse;

  const ReceiptModel({
    required this.receiptData,
    required this.platform,
    required this.productId,
    required this.transactionId,
    this.originalTransactionId,
    required this.purchaseDate,
    this.expirationDate,
    this.cancellationDate,
    this.status = ReceiptStatus.pending,
    required this.lastValidatedAt,
    this.lastValidationAttemptAt,
    this.validationAttempts = 0,
    this.lastValidationError,
    this.isValid = false,
    this.isExpired = false,
    this.isRefunded = false,
    this.isInTrialPeriod = false,
    this.isInIntroductoryPricePeriod = false,
    this.isAutoRenewing = false,
    this.subscriptionGroupId,
    this.webOrderLineItemId,
    this.storeSpecificData = const {},
    this.deviceId,
    this.userId,
    this.price,
    this.currency,
    this.countryCode,
    this.validationResponse = const {},
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);

  // Create from in-app purchase data
  factory ReceiptModel.fromPurchaseData({
    required String receiptData,
    required String platform,
    required String productId,
    required String transactionId,
    String? originalTransactionId,
    required DateTime purchaseDate,
    DateTime? expirationDate,
    String? deviceId,
    String? userId,
    double? price,
    String? currency,
    String? countryCode,
    bool isAutoRenewing = false,
    bool isInTrialPeriod = false,
    Map<String, dynamic> additionalData = const {},
  }) {
    return ReceiptModel(
      receiptData: receiptData,
      platform: platform,
      productId: productId,
      transactionId: transactionId,
      originalTransactionId: originalTransactionId,
      purchaseDate: purchaseDate,
      expirationDate: expirationDate,
      lastValidatedAt: DateTime.now(),
      deviceId: deviceId,
      userId: userId,
      price: price,
      currency: currency,
      countryCode: countryCode,
      isAutoRenewing: isAutoRenewing,
      isInTrialPeriod: isInTrialPeriod,
      storeSpecificData: additionalData,
    );
  }

  ReceiptModel copyWith({
    String? receiptData,
    String? platform,
    String? productId,
    String? transactionId,
    String? originalTransactionId,
    DateTime? purchaseDate,
    DateTime? expirationDate,
    DateTime? cancellationDate,
    ReceiptStatus? status,
    DateTime? lastValidatedAt,
    DateTime? lastValidationAttemptAt,
    int? validationAttempts,
    String? lastValidationError,
    bool? isValid,
    bool? isExpired,
    bool? isRefunded,
    bool? isInTrialPeriod,
    bool? isInIntroductoryPricePeriod,
    bool? isAutoRenewing,
    String? subscriptionGroupId,
    String? webOrderLineItemId,
    Map<String, dynamic>? storeSpecificData,
    String? deviceId,
    String? userId,
    double? price,
    String? currency,
    String? countryCode,
    Map<String, dynamic>? validationResponse,
  }) {
    return ReceiptModel(
      receiptData: receiptData ?? this.receiptData,
      platform: platform ?? this.platform,
      productId: productId ?? this.productId,
      transactionId: transactionId ?? this.transactionId,
      originalTransactionId:
          originalTransactionId ?? this.originalTransactionId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expirationDate: expirationDate ?? this.expirationDate,
      cancellationDate: cancellationDate ?? this.cancellationDate,
      status: status ?? this.status,
      lastValidatedAt: lastValidatedAt ?? this.lastValidatedAt,
      lastValidationAttemptAt:
          lastValidationAttemptAt ?? this.lastValidationAttemptAt,
      validationAttempts: validationAttempts ?? this.validationAttempts,
      lastValidationError: lastValidationError ?? this.lastValidationError,
      isValid: isValid ?? this.isValid,
      isExpired: isExpired ?? this.isExpired,
      isRefunded: isRefunded ?? this.isRefunded,
      isInTrialPeriod: isInTrialPeriod ?? this.isInTrialPeriod,
      isInIntroductoryPricePeriod:
          isInIntroductoryPricePeriod ?? this.isInIntroductoryPricePeriod,
      isAutoRenewing: isAutoRenewing ?? this.isAutoRenewing,
      subscriptionGroupId: subscriptionGroupId ?? this.subscriptionGroupId,
      webOrderLineItemId: webOrderLineItemId ?? this.webOrderLineItemId,
      storeSpecificData: storeSpecificData ?? this.storeSpecificData,
      deviceId: deviceId ?? this.deviceId,
      userId: userId ?? this.userId,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      countryCode: countryCode ?? this.countryCode,
      validationResponse: validationResponse ?? this.validationResponse,
    );
  }

  // Helper methods
  bool get needsValidation {
    final timeSinceValidation = DateTime.now().difference(lastValidatedAt);
    return timeSinceValidation.inHours >= 1 || validationAttempts == 0;
  }

  bool get isValidSubscription => isValid && !isExpired && !isRefunded;

  bool get isCurrentlyValid {
    if (!isValid || isRefunded) return false;
    if (expirationDate == null) return true; // Lifetime purchase
    return expirationDate!.isAfter(DateTime.now());
  }

  bool get shouldRetryValidation {
    if (validationAttempts >= 5) return false; // Max retry attempts
    if (lastValidationAttemptAt == null) return true;

    final timeSinceLastAttempt = DateTime.now().difference(
      lastValidationAttemptAt!,
    );
    return timeSinceLastAttempt.inMinutes >=
        (validationAttempts * 5); // Exponential backoff
  }

  Duration? get timeUntilExpiry {
    if (expirationDate == null) return null;
    final now = DateTime.now();
    if (expirationDate!.isBefore(now)) return Duration.zero;
    return expirationDate!.difference(now);
  }

  Duration get purchaseAge => DateTime.now().difference(purchaseDate);
  Duration get validationAge => DateTime.now().difference(lastValidatedAt);

  String get statusText {
    switch (status) {
      case ReceiptStatus.valid:
        return 'Valid';
      case ReceiptStatus.invalid:
        return 'Invalid';
      case ReceiptStatus.pending:
        return 'Pending Validation';
      case ReceiptStatus.expired:
        return 'Expired';
      case ReceiptStatus.refunded:
        return 'Refunded';
      case ReceiptStatus.cancelled:
        return 'Cancelled';
      case ReceiptStatus.failed:
        return 'Validation Failed';
    }
  }

  String get platformDisplayName {
    switch (platform.toLowerCase()) {
      case 'ios':
      case 'app_store':
        return 'App Store';
      case 'android':
      case 'play_store':
        return 'Google Play';
      default:
        return platform;
    }
  }

  String get subscriptionType {
    switch (productId.toLowerCase()) {
      case 'monthly':
      case 'com.vpn360ai.monthly':
        return 'Monthly';
      case 'yearly':
      case 'com.vpn360ai.yearly':
        return 'Yearly';
      case 'lifetime':
      case 'com.vpn360ai.lifetime':
        return 'Lifetime';
      default:
        return 'Unknown';
    }
  }

  String get formattedPrice {
    if (price == null || currency == null) return 'N/A';
    return '$price $currency';
  }

  String get formattedPurchaseDate => _formatDate(purchaseDate);
  String get formattedExpirationDate =>
      expirationDate != null ? _formatDate(expirationDate!) : 'Never';
  String get formattedLastValidated => _formatDate(lastValidatedAt);

  // Validation data for API
  Map<String, dynamic> toValidationData() {
    return {
      'receipt_data': receiptData,
      'product_id': productId,
      'transaction_id': transactionId,
      'original_transaction_id': originalTransactionId,
      'platform': platform,
      'device_id': deviceId,
      'user_id': userId,
      'purchase_date': purchaseDate.toIso8601String(),
      'country_code': countryCode,
      'store_specific_data': storeSpecificData,
    };
  }

  // Update from validation response
  ReceiptModel updateFromValidation({
    required bool isValid,
    required ReceiptStatus status,
    DateTime? expirationDate,
    DateTime? cancellationDate,
    bool? isExpired,
    bool? isRefunded,
    bool? isAutoRenewing,
    bool? isInTrialPeriod,
    bool? isInIntroductoryPricePeriod,
    String? subscriptionGroupId,
    String? webOrderLineItemId,
    Map<String, dynamic>? validationResponse,
    String? error,
  }) {
    return copyWith(
      isValid: isValid,
      status: status,
      expirationDate: expirationDate ?? this.expirationDate,
      cancellationDate: cancellationDate ?? this.cancellationDate,
      isExpired: isExpired ?? this.isExpired,
      isRefunded: isRefunded ?? this.isRefunded,
      isAutoRenewing: isAutoRenewing ?? this.isAutoRenewing,
      isInTrialPeriod: isInTrialPeriod ?? this.isInTrialPeriod,
      isInIntroductoryPricePeriod:
          isInIntroductoryPricePeriod ?? this.isInIntroductoryPricePeriod,
      subscriptionGroupId: subscriptionGroupId ?? this.subscriptionGroupId,
      webOrderLineItemId: webOrderLineItemId ?? this.webOrderLineItemId,
      validationResponse: validationResponse ?? this.validationResponse,
      lastValidatedAt: DateTime.now(),
      lastValidationAttemptAt: DateTime.now(),
      validationAttempts: validationAttempts + 1,
      lastValidationError: error,
    );
  }

  // Store-specific helpers
  bool get isAppStoreReceipt =>
      platform.toLowerCase() == 'ios' || platform.toLowerCase() == 'app_store';
  bool get isPlayStoreReceipt =>
      platform.toLowerCase() == 'android' ||
      platform.toLowerCase() == 'play_store';

  String? get appStoreReceiptData => isAppStoreReceipt ? receiptData : null;

  Map<String, dynamic>? get playStoreReceiptData {
    if (!isPlayStoreReceipt) return null;
    return storeSpecificData.isNotEmpty ? storeSpecificData : null;
  }

  // Security validation
  bool get hasValidSignature {
    // This would typically validate the receipt signature
    // Implementation depends on platform-specific validation
    return receiptData.isNotEmpty && transactionId.isNotEmpty;
  }

  bool get isReceiptTampered {
    // Basic tamper detection
    if (receiptData.isEmpty || transactionId.isEmpty) return true;
    if (purchaseDate.isAfter(DateTime.now())) return true;
    if (expirationDate != null && expirationDate!.isBefore(purchaseDate))
      return true;
    return false;
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  String toString() =>
      'ReceiptModel(product: $productId, status: $status, platform: $platform, valid: $isValid)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptModel &&
          runtimeType == other.runtimeType &&
          transactionId == other.transactionId &&
          platform == other.platform;

  @override
  int get hashCode => transactionId.hashCode ^ platform.hashCode;
}

@HiveType(typeId: 61)
enum ReceiptStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  valid,
  @HiveField(2)
  invalid,
  @HiveField(3)
  expired,
  @HiveField(4)
  refunded,
  @HiveField(5)
  cancelled,
  @HiveField(6)
  failed,
}

@HiveType(typeId: 62)
@JsonSerializable()
class ReceiptValidationResponseModel {
  @HiveField(0)
  final bool isValid;

  @HiveField(1)
  final ReceiptStatus status;

  @HiveField(2)
  final String? errorMessage;

  @HiveField(3)
  final String? errorCode;

  @HiveField(4)
  final DateTime? expirationDate;

  @HiveField(5)
  final DateTime? cancellationDate;

  @HiveField(6)
  final bool isAutoRenewing;

  @HiveField(7)
  final bool isInTrialPeriod;

  @HiveField(8)
  final bool isInIntroductoryPricePeriod;

  @HiveField(9)
  final String? subscriptionGroupId;

  @HiveField(10)
  final String? webOrderLineItemId;

  @HiveField(11)
  final Map<String, dynamic> rawResponse;

  @HiveField(12)
  final DateTime validatedAt;

  @HiveField(13)
  final String? serverEnvironment;

  @HiveField(14)
  final Map<String, dynamic> additionalData;

  const ReceiptValidationResponseModel({
    required this.isValid,
    required this.status,
    this.errorMessage,
    this.errorCode,
    this.expirationDate,
    this.cancellationDate,
    this.isAutoRenewing = false,
    this.isInTrialPeriod = false,
    this.isInIntroductoryPricePeriod = false,
    this.subscriptionGroupId,
    this.webOrderLineItemId,
    this.rawResponse = const {},
    required this.validatedAt,
    this.serverEnvironment,
    this.additionalData = const {},
  });

  factory ReceiptValidationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptValidationResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiptValidationResponseModelToJson(this);

  // Factory for failed validation
  factory ReceiptValidationResponseModel.failed({
    required String errorMessage,
    String? errorCode,
    Map<String, dynamic> rawResponse = const {},
  }) {
    return ReceiptValidationResponseModel(
      isValid: false,
      status: ReceiptStatus.failed,
      errorMessage: errorMessage,
      errorCode: errorCode,
      rawResponse: rawResponse,
      validatedAt: DateTime.now(),
    );
  }

  // Factory for successful validation
  factory ReceiptValidationResponseModel.success({
    required ReceiptStatus status,
    DateTime? expirationDate,
    DateTime? cancellationDate,
    bool isAutoRenewing = false,
    bool isInTrialPeriod = false,
    bool isInIntroductoryPricePeriod = false,
    String? subscriptionGroupId,
    String? webOrderLineItemId,
    Map<String, dynamic> rawResponse = const {},
    String? serverEnvironment,
    Map<String, dynamic> additionalData = const {},
  }) {
    return ReceiptValidationResponseModel(
      isValid: status == ReceiptStatus.valid,
      status: status,
      expirationDate: expirationDate,
      cancellationDate: cancellationDate,
      isAutoRenewing: isAutoRenewing,
      isInTrialPeriod: isInTrialPeriod,
      isInIntroductoryPricePeriod: isInIntroductoryPricePeriod,
      subscriptionGroupId: subscriptionGroupId,
      webOrderLineItemId: webOrderLineItemId,
      rawResponse: rawResponse,
      validatedAt: DateTime.now(),
      serverEnvironment: serverEnvironment,
      additionalData: additionalData,
    );
  }

  bool get hasError => errorMessage != null || errorCode != null;

  String get displayErrorMessage => errorMessage ?? 'Unknown validation error';

  Duration get validationAge => DateTime.now().difference(validatedAt);

  bool get isRecentValidation => validationAge.inMinutes < 5;

  @override
  String toString() =>
      'ReceiptValidationResponseModel(valid: $isValid, status: $status, error: $errorMessage)';
}

@HiveType(typeId: 63)
@JsonSerializable()
class ReceiptHistoryModel {
  @HiveField(0)
  final List<ReceiptModel> receipts;

  @HiveField(1)
  final DateTime lastUpdatedAt;

  @HiveField(2)
  final String? activeReceiptId;

  @HiveField(3)
  final Map<String, int> validationAttempts;

  @HiveField(4)
  final List<String> failedReceiptIds;

  const ReceiptHistoryModel({
    this.receipts = const [],
    required this.lastUpdatedAt,
    this.activeReceiptId,
    this.validationAttempts = const {},
    this.failedReceiptIds = const [],
  });

  factory ReceiptHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReceiptHistoryModelToJson(this);

  ReceiptHistoryModel copyWith({
    List<ReceiptModel>? receipts,
    DateTime? lastUpdatedAt,
    String? activeReceiptId,
    Map<String, int>? validationAttempts,
    List<String>? failedReceiptIds,
  }) {
    return ReceiptHistoryModel(
      receipts: receipts ?? this.receipts,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      activeReceiptId: activeReceiptId ?? this.activeReceiptId,
      validationAttempts: validationAttempts ?? this.validationAttempts,
      failedReceiptIds: failedReceiptIds ?? this.failedReceiptIds,
    );
  }

  // Helper methods
  ReceiptModel? get activeReceipt => activeReceiptId != null
      ? receipts.firstWhere(
          (r) => r.transactionId == activeReceiptId,
          orElse: () => receipts.first,
        )
      : null;

  List<ReceiptModel> get validReceipts =>
      receipts.where((r) => r.isValidSubscription).toList();
  List<ReceiptModel> get expiredReceipts =>
      receipts.where((r) => r.isExpired).toList();
  List<ReceiptModel> get pendingReceipts =>
      receipts.where((r) => r.status == ReceiptStatus.pending).toList();

  bool get hasValidReceipt => validReceipts.isNotEmpty;
  bool get hasActiveSubscription => activeReceipt?.isValidSubscription == true;

  ReceiptModel? get mostRecentReceipt => receipts.isNotEmpty
      ? receipts.reduce(
          (a, b) => a.purchaseDate.isAfter(b.purchaseDate) ? a : b,
        )
      : null;

  @override
  String toString() =>
      'ReceiptHistoryModel(receipts: ${receipts.length}, active: $hasActiveSubscription)';
}
