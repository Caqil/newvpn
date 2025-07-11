import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@HiveType(typeId: 20)
@JsonSerializable()
class SubscriptionModel {
  @HiveField(0)
  final String productId;
  
  @HiveField(1)
  final String subscriptionType;
  
  @HiveField(2)
  final SubscriptionStatus status;
  
  @HiveField(3)
  final DateTime purchaseDate;
  
  @HiveField(4)
  final DateTime? expirationDate;
  
  @HiveField(5)
  final DateTime? renewalDate;
  
  @HiveField(6)
  final DateTime? cancellationDate;
  
  @HiveField(7)
  final String? transactionId;
  
  @HiveField(8)
  final String? originalTransactionId;
  
  @HiveField(9)
  final String receiptData;
  
  @HiveField(10)
  final String platform;
  
  @HiveField(11)
  final double price;
  
  @HiveField(12)
  final String currency;
  
  @HiveField(13)
  final bool isAutoRenewing;
  
  @HiveField(14)
  final bool isInTrialPeriod;
  
  @HiveField(15)
  final bool isInIntroductoryPricePeriod;
  
  @HiveField(16)
  final DateTime? trialEndDate;
  
  @HiveField(17)
  final DateTime? gracePeriodEndDate;
  
  @HiveField(18)
  final DateTime lastValidatedAt;
  
  @HiveField(19)
  final int validationFailureCount;
  
  @HiveField(20)
  final String? lastValidationError;
  
  @HiveField(21)
  final Map<String, dynamic> metadata;
  
  @HiveField(22)
  final String? promoCode;
  
  @HiveField(23)
  final double? discountAmount;
  
  @HiveField(24)
  final String? billingIssueDetectedAt;
  
  @HiveField(25)
  final bool hasLifetimeAccess;
  
  @HiveField(26)
  final String? deviceId;
  
  @HiveField(27)
  final DateTime? lastUsageResetAt;
  
  @HiveField(28)
  final int maxDevices;
  
  @HiveField(29)
  final List<String> allowedFeatures;

  const SubscriptionModel({
    required this.productId,
    required this.subscriptionType,
    required this.status,
    required this.purchaseDate,
    this.expirationDate,
    this.renewalDate,
    this.cancellationDate,
    this.transactionId,
    this.originalTransactionId,
    required this.receiptData,
    required this.platform,
    required this.price,
    required this.currency,
    this.isAutoRenewing = false,
    this.isInTrialPeriod = false,
    this.isInIntroductoryPricePeriod = false,
    this.trialEndDate,
    this.gracePeriodEndDate,
    required this.lastValidatedAt,
    this.validationFailureCount = 0,
    this.lastValidationError,
    this.metadata = const {},
    this.promoCode,
    this.discountAmount,
    this.billingIssueDetectedAt,
    this.hasLifetimeAccess = false,
    this.deviceId,
    this.lastUsageResetAt,
    this.maxDevices = 5,
    this.allowedFeatures = const [],
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);

  SubscriptionModel copyWith({
    String? productId,
    String? subscriptionType,
    SubscriptionStatus? status,
    DateTime? purchaseDate,
    DateTime? expirationDate,
    DateTime? renewalDate,
    DateTime? cancellationDate,
    String? transactionId,
    String? originalTransactionId,
    String? receiptData,
    String? platform,
    double? price,
    String? currency,
    bool? isAutoRenewing,
    bool? isInTrialPeriod,
    bool? isInIntroductoryPricePeriod,
    DateTime? trialEndDate,
    DateTime? gracePeriodEndDate,
    DateTime? lastValidatedAt,
    int? validationFailureCount,
    String? lastValidationError,
    Map<String, dynamic>? metadata,
    String? promoCode,
    double? discountAmount,
    String? billingIssueDetectedAt,
    bool? hasLifetimeAccess,
    String? deviceId,
    DateTime? lastUsageResetAt,
    int? maxDevices,
    List<String>? allowedFeatures,
  }) {
    return SubscriptionModel(
      productId: productId ?? this.productId,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      status: status ?? this.status,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expirationDate: expirationDate ?? this.expirationDate,
      renewalDate: renewalDate ?? this.renewalDate,
      cancellationDate: cancellationDate ?? this.cancellationDate,
      transactionId: transactionId ?? this.transactionId,
      originalTransactionId: originalTransactionId ?? this.originalTransactionId,
      receiptData: receiptData ?? this.receiptData,
      platform: platform ?? this.platform,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      isAutoRenewing: isAutoRenewing ?? this.isAutoRenewing,
      isInTrialPeriod: isInTrialPeriod ?? this.isInTrialPeriod,
      isInIntroductoryPricePeriod: isInIntroductoryPricePeriod ?? this.isInIntroductoryPricePeriod,
      trialEndDate: trialEndDate ?? this.trialEndDate,
      gracePeriodEndDate: gracePeriodEndDate ?? this.gracePeriodEndDate,
      lastValidatedAt: lastValidatedAt ?? this.lastValidatedAt,
      validationFailureCount: validationFailureCount ?? this.validationFailureCount,
      lastValidationError: lastValidationError ?? this.lastValidationError,
      metadata: metadata ?? this.metadata,
      promoCode: promoCode ?? this.promoCode,
      discountAmount: discountAmount ?? this.discountAmount,
      billingIssueDetectedAt: billingIssueDetectedAt ?? this.billingIssueDetectedAt,
      hasLifetimeAccess: hasLifetimeAccess ?? this.hasLifetimeAccess,
      deviceId: deviceId ?? this.deviceId,
      lastUsageResetAt: lastUsageResetAt ?? this.lastUsageResetAt,
      maxDevices: maxDevices ?? this.maxDevices,
      allowedFeatures: allowedFeatures ?? this.allowedFeatures,
    );
  }

  // Helper methods
  bool get isActive => status == SubscriptionStatus.active;
  bool get isExpired => status == SubscriptionStatus.expired || 
                      (expirationDate != null && expirationDate!.isBefore(DateTime.now()));
  bool get isCancelled => status == SubscriptionStatus.cancelled;
  bool get isPending => status == SubscriptionStatus.pending;
  bool get hasBillingIssue => status == SubscriptionStatus.billingRetry;
  bool get isInGracePeriod => gracePeriodEndDate != null && 
                             gracePeriodEndDate!.isAfter(DateTime.now());
  
  bool get isValidSubscription => (isActive || isInGracePeriod) && !isExpired;
  bool get isPremiumUser => isValidSubscription || hasLifetimeAccess;
  bool get needsValidation => DateTime.now().difference(lastValidatedAt).inHours >= 1;
  bool get hasValidationIssues => validationFailureCount > 0;
  
  Duration? get timeUntilExpiry {
    if (expirationDate == null || hasLifetimeAccess) return null;
    final now = DateTime.now();
    if (expirationDate!.isBefore(now)) return Duration.zero;
    return expirationDate!.difference(now);
  }
  
  Duration? get timeUntilRenewal {
    if (renewalDate == null || !isAutoRenewing) return null;
    final now = DateTime.now();
    if (renewalDate!.isBefore(now)) return Duration.zero;
    return renewalDate!.difference(now);
  }
  
  Duration get subscriptionDuration => DateTime.now().difference(purchaseDate);
  
  String get displayName {
    switch (subscriptionType.toLowerCase()) {
      case 'monthly':
        return 'Monthly Premium';
      case 'yearly':
        return 'Yearly Premium';
      case 'lifetime':
        return 'Lifetime Premium';
      default:
        return 'Premium Subscription';
    }
  }
  
  String get statusDisplayText {
    switch (status) {
      case SubscriptionStatus.active:
        return isInTrialPeriod ? 'Trial Active' : 'Active';
      case SubscriptionStatus.expired:
        return 'Expired';
      case SubscriptionStatus.cancelled:
        return 'Cancelled';
      case SubscriptionStatus.pending:
        return 'Pending';
      case SubscriptionStatus.billingRetry:
        return 'Billing Issue';
      case SubscriptionStatus.paused:
        return 'Paused';
      case SubscriptionStatus.refunded:
        return 'Refunded';
    }
  }
  
  bool hasFeature(String feature) {
    return isPremiumUser && (allowedFeatures.isEmpty || allowedFeatures.contains(feature));
  }
  
  String get formattedPrice => '$price $currency';
  
  // Validation helpers
  bool get shouldRetryValidation => 
    validationFailureCount < 3 && 
    DateTime.now().difference(lastValidatedAt).inMinutes >= 5;
  
  Map<String, dynamic> toValidationData() {
    return {
      'receipt_data': receiptData,
      'product_id': productId,
      'transaction_id': transactionId,
      'platform': platform,
      'device_id': deviceId,
    };
  }
  
  @override
  String toString() => 'SubscriptionModel(type: $subscriptionType, status: $status, expires: $expirationDate)';
  
  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is SubscriptionModel &&
    runtimeType == other.runtimeType &&
    productId == other.productId &&
    transactionId == other.transactionId;
  
  @override
  int get hashCode => productId.hashCode ^ transactionId.hashCode;
}

@HiveType(typeId: 21)
enum SubscriptionStatus {
  @HiveField(0)
  active,
  @HiveField(1)
  expired,
  @HiveField(2)
  cancelled,
  @HiveField(3)
  pending,
  @HiveField(4)
  billingRetry,
  @HiveField(5)
  paused,
  @HiveField(6)
  refunded,
}

@HiveType(typeId: 22)
@JsonSerializable()
class SubscriptionPlanModel {
  @HiveField(0)
  final String productId;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final double price;
  
  @HiveField(4)
  final String currency;
  
  @HiveField(5)
  final String duration;
  
  @HiveField(6)
  final List<String> features;
  
  @HiveField(7)
  final bool isPopular;
  
  @HiveField(8)
  final double? originalPrice;
  
  @HiveField(9)
  final int? discountPercentage;
  
  @HiveField(10)
  final bool hasFreeTrial;
  
  @HiveField(11)
  final int? trialDays;
  
  @HiveField(12)
  final String? trialDescription;
  
  @HiveField(13)
  final bool isAvailable;
  
  @HiveField(14)
  final int sortOrder;

  const SubscriptionPlanModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.duration,
    required this.features,
    this.isPopular = false,
    this.originalPrice,
    this.discountPercentage,
    this.hasFreeTrial = false,
    this.trialDays,
    this.trialDescription,
    this.isAvailable = true,
    this.sortOrder = 0,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionPlanModelToJson(this);

  // Helper methods
  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  String get formattedPrice => '$price $currency';
  String get formattedOriginalPrice => originalPrice != null ? '$originalPrice $currency' : '';
  
  double get monthlyCost {
    switch (duration.toLowerCase()) {
      case 'monthly':
        return price;
      case 'yearly':
        return price / 12;
      case 'lifetime':
        return 0;
      default:
        return price;
    }
  }
  
  String get displayDuration {
    switch (duration.toLowerCase()) {
      case 'monthly':
        return 'per month';
      case 'yearly':
        return 'per year';
      case 'lifetime':
        return 'one-time payment';
      default:
        return duration;
    }
  }
  
  String get savingsText {
    if (!hasDiscount) return '';
    if (discountPercentage != null) {
      return 'Save $discountPercentage%';
    }
    if (originalPrice != null) {
      final savings = originalPrice! - price;
      return 'Save $savings $currency';
    }
    return '';
  }
  
  @override
  String toString() => 'SubscriptionPlanModel(id: $productId, name: $name, price: $formattedPrice)';
}