// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscriptionModelAdapter extends TypeAdapter<SubscriptionModel> {
  @override
  final int typeId = 20;

  @override
  SubscriptionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscriptionModel(
      productId: fields[0] as String,
      subscriptionType: fields[1] as String,
      status: fields[2] as SubscriptionStatus,
      purchaseDate: fields[3] as DateTime,
      expirationDate: fields[4] as DateTime?,
      renewalDate: fields[5] as DateTime?,
      cancellationDate: fields[6] as DateTime?,
      transactionId: fields[7] as String?,
      originalTransactionId: fields[8] as String?,
      receiptData: fields[9] as String,
      platform: fields[10] as String,
      price: fields[11] as double,
      currency: fields[12] as String,
      isAutoRenewing: fields[13] as bool,
      isInTrialPeriod: fields[14] as bool,
      isInIntroductoryPricePeriod: fields[15] as bool,
      trialEndDate: fields[16] as DateTime?,
      gracePeriodEndDate: fields[17] as DateTime?,
      lastValidatedAt: fields[18] as DateTime,
      validationFailureCount: fields[19] as int,
      lastValidationError: fields[20] as String?,
      metadata: (fields[21] as Map).cast<String, dynamic>(),
      promoCode: fields[22] as String?,
      discountAmount: fields[23] as double?,
      billingIssueDetectedAt: fields[24] as String?,
      hasLifetimeAccess: fields[25] as bool,
      deviceId: fields[26] as String?,
      lastUsageResetAt: fields[27] as DateTime?,
      maxDevices: fields[28] as int,
      allowedFeatures: (fields[29] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubscriptionModel obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.subscriptionType)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.purchaseDate)
      ..writeByte(4)
      ..write(obj.expirationDate)
      ..writeByte(5)
      ..write(obj.renewalDate)
      ..writeByte(6)
      ..write(obj.cancellationDate)
      ..writeByte(7)
      ..write(obj.transactionId)
      ..writeByte(8)
      ..write(obj.originalTransactionId)
      ..writeByte(9)
      ..write(obj.receiptData)
      ..writeByte(10)
      ..write(obj.platform)
      ..writeByte(11)
      ..write(obj.price)
      ..writeByte(12)
      ..write(obj.currency)
      ..writeByte(13)
      ..write(obj.isAutoRenewing)
      ..writeByte(14)
      ..write(obj.isInTrialPeriod)
      ..writeByte(15)
      ..write(obj.isInIntroductoryPricePeriod)
      ..writeByte(16)
      ..write(obj.trialEndDate)
      ..writeByte(17)
      ..write(obj.gracePeriodEndDate)
      ..writeByte(18)
      ..write(obj.lastValidatedAt)
      ..writeByte(19)
      ..write(obj.validationFailureCount)
      ..writeByte(20)
      ..write(obj.lastValidationError)
      ..writeByte(21)
      ..write(obj.metadata)
      ..writeByte(22)
      ..write(obj.promoCode)
      ..writeByte(23)
      ..write(obj.discountAmount)
      ..writeByte(24)
      ..write(obj.billingIssueDetectedAt)
      ..writeByte(25)
      ..write(obj.hasLifetimeAccess)
      ..writeByte(26)
      ..write(obj.deviceId)
      ..writeByte(27)
      ..write(obj.lastUsageResetAt)
      ..writeByte(28)
      ..write(obj.maxDevices)
      ..writeByte(29)
      ..write(obj.allowedFeatures);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubscriptionPlanModelAdapter extends TypeAdapter<SubscriptionPlanModel> {
  @override
  final int typeId = 22;

  @override
  SubscriptionPlanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscriptionPlanModel(
      productId: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      currency: fields[4] as String,
      duration: fields[5] as String,
      features: (fields[6] as List).cast<String>(),
      isPopular: fields[7] as bool,
      originalPrice: fields[8] as double?,
      discountPercentage: fields[9] as int?,
      hasFreeTrial: fields[10] as bool,
      trialDays: fields[11] as int?,
      trialDescription: fields[12] as String?,
      isAvailable: fields[13] as bool,
      sortOrder: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubscriptionPlanModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.currency)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.features)
      ..writeByte(7)
      ..write(obj.isPopular)
      ..writeByte(8)
      ..write(obj.originalPrice)
      ..writeByte(9)
      ..write(obj.discountPercentage)
      ..writeByte(10)
      ..write(obj.hasFreeTrial)
      ..writeByte(11)
      ..write(obj.trialDays)
      ..writeByte(12)
      ..write(obj.trialDescription)
      ..writeByte(13)
      ..write(obj.isAvailable)
      ..writeByte(14)
      ..write(obj.sortOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionPlanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubscriptionStatusAdapter extends TypeAdapter<SubscriptionStatus> {
  @override
  final int typeId = 21;

  @override
  SubscriptionStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubscriptionStatus.active;
      case 1:
        return SubscriptionStatus.expired;
      case 2:
        return SubscriptionStatus.cancelled;
      case 3:
        return SubscriptionStatus.pending;
      case 4:
        return SubscriptionStatus.billingRetry;
      case 5:
        return SubscriptionStatus.paused;
      case 6:
        return SubscriptionStatus.refunded;
      default:
        return SubscriptionStatus.active;
    }
  }

  @override
  void write(BinaryWriter writer, SubscriptionStatus obj) {
    switch (obj) {
      case SubscriptionStatus.active:
        writer.writeByte(0);
        break;
      case SubscriptionStatus.expired:
        writer.writeByte(1);
        break;
      case SubscriptionStatus.cancelled:
        writer.writeByte(2);
        break;
      case SubscriptionStatus.pending:
        writer.writeByte(3);
        break;
      case SubscriptionStatus.billingRetry:
        writer.writeByte(4);
        break;
      case SubscriptionStatus.paused:
        writer.writeByte(5);
        break;
      case SubscriptionStatus.refunded:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      productId: json['productId'] as String,
      subscriptionType: json['subscriptionType'] as String,
      status: $enumDecode(_$SubscriptionStatusEnumMap, json['status']),
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      renewalDate: json['renewalDate'] == null
          ? null
          : DateTime.parse(json['renewalDate'] as String),
      cancellationDate: json['cancellationDate'] == null
          ? null
          : DateTime.parse(json['cancellationDate'] as String),
      transactionId: json['transactionId'] as String?,
      originalTransactionId: json['originalTransactionId'] as String?,
      receiptData: json['receiptData'] as String,
      platform: json['platform'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      isAutoRenewing: json['isAutoRenewing'] as bool? ?? false,
      isInTrialPeriod: json['isInTrialPeriod'] as bool? ?? false,
      isInIntroductoryPricePeriod:
          json['isInIntroductoryPricePeriod'] as bool? ?? false,
      trialEndDate: json['trialEndDate'] == null
          ? null
          : DateTime.parse(json['trialEndDate'] as String),
      gracePeriodEndDate: json['gracePeriodEndDate'] == null
          ? null
          : DateTime.parse(json['gracePeriodEndDate'] as String),
      lastValidatedAt: DateTime.parse(json['lastValidatedAt'] as String),
      validationFailureCount:
          (json['validationFailureCount'] as num?)?.toInt() ?? 0,
      lastValidationError: json['lastValidationError'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      promoCode: json['promoCode'] as String?,
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      billingIssueDetectedAt: json['billingIssueDetectedAt'] as String?,
      hasLifetimeAccess: json['hasLifetimeAccess'] as bool? ?? false,
      deviceId: json['deviceId'] as String?,
      lastUsageResetAt: json['lastUsageResetAt'] == null
          ? null
          : DateTime.parse(json['lastUsageResetAt'] as String),
      maxDevices: (json['maxDevices'] as num?)?.toInt() ?? 5,
      allowedFeatures: (json['allowedFeatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'subscriptionType': instance.subscriptionType,
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'renewalDate': instance.renewalDate?.toIso8601String(),
      'cancellationDate': instance.cancellationDate?.toIso8601String(),
      'transactionId': instance.transactionId,
      'originalTransactionId': instance.originalTransactionId,
      'receiptData': instance.receiptData,
      'platform': instance.platform,
      'price': instance.price,
      'currency': instance.currency,
      'isAutoRenewing': instance.isAutoRenewing,
      'isInTrialPeriod': instance.isInTrialPeriod,
      'isInIntroductoryPricePeriod': instance.isInIntroductoryPricePeriod,
      'trialEndDate': instance.trialEndDate?.toIso8601String(),
      'gracePeriodEndDate': instance.gracePeriodEndDate?.toIso8601String(),
      'lastValidatedAt': instance.lastValidatedAt.toIso8601String(),
      'validationFailureCount': instance.validationFailureCount,
      'lastValidationError': instance.lastValidationError,
      'metadata': instance.metadata,
      'promoCode': instance.promoCode,
      'discountAmount': instance.discountAmount,
      'billingIssueDetectedAt': instance.billingIssueDetectedAt,
      'hasLifetimeAccess': instance.hasLifetimeAccess,
      'deviceId': instance.deviceId,
      'lastUsageResetAt': instance.lastUsageResetAt?.toIso8601String(),
      'maxDevices': instance.maxDevices,
      'allowedFeatures': instance.allowedFeatures,
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.expired: 'expired',
  SubscriptionStatus.cancelled: 'cancelled',
  SubscriptionStatus.pending: 'pending',
  SubscriptionStatus.billingRetry: 'billingRetry',
  SubscriptionStatus.paused: 'paused',
  SubscriptionStatus.refunded: 'refunded',
};

SubscriptionPlanModel _$SubscriptionPlanModelFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlanModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      duration: json['duration'] as String,
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      isPopular: json['isPopular'] as bool? ?? false,
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toInt(),
      hasFreeTrial: json['hasFreeTrial'] as bool? ?? false,
      trialDays: (json['trialDays'] as num?)?.toInt(),
      trialDescription: json['trialDescription'] as String?,
      isAvailable: json['isAvailable'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SubscriptionPlanModelToJson(
        SubscriptionPlanModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'duration': instance.duration,
      'features': instance.features,
      'isPopular': instance.isPopular,
      'originalPrice': instance.originalPrice,
      'discountPercentage': instance.discountPercentage,
      'hasFreeTrial': instance.hasFreeTrial,
      'trialDays': instance.trialDays,
      'trialDescription': instance.trialDescription,
      'isAvailable': instance.isAvailable,
      'sortOrder': instance.sortOrder,
    };
