// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReceiptModelAdapter extends TypeAdapter<ReceiptModel> {
  @override
  final int typeId = 60;

  @override
  ReceiptModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReceiptModel(
      receiptData: fields[0] as String,
      platform: fields[1] as String,
      productId: fields[2] as String,
      transactionId: fields[3] as String,
      originalTransactionId: fields[4] as String?,
      purchaseDate: fields[5] as DateTime,
      expirationDate: fields[6] as DateTime?,
      cancellationDate: fields[7] as DateTime?,
      status: fields[8] as ReceiptStatus,
      lastValidatedAt: fields[9] as DateTime,
      lastValidationAttemptAt: fields[10] as DateTime?,
      validationAttempts: fields[11] as int,
      lastValidationError: fields[12] as String?,
      isValid: fields[13] as bool,
      isExpired: fields[14] as bool,
      isRefunded: fields[15] as bool,
      isInTrialPeriod: fields[16] as bool,
      isInIntroductoryPricePeriod: fields[17] as bool,
      isAutoRenewing: fields[18] as bool,
      subscriptionGroupId: fields[19] as String?,
      webOrderLineItemId: fields[20] as String?,
      storeSpecificData: (fields[21] as Map).cast<String, dynamic>(),
      deviceId: fields[22] as String?,
      userId: fields[23] as String?,
      price: fields[24] as double?,
      currency: fields[25] as String?,
      countryCode: fields[26] as String?,
      validationResponse: (fields[27] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReceiptModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.receiptData)
      ..writeByte(1)
      ..write(obj.platform)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.transactionId)
      ..writeByte(4)
      ..write(obj.originalTransactionId)
      ..writeByte(5)
      ..write(obj.purchaseDate)
      ..writeByte(6)
      ..write(obj.expirationDate)
      ..writeByte(7)
      ..write(obj.cancellationDate)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.lastValidatedAt)
      ..writeByte(10)
      ..write(obj.lastValidationAttemptAt)
      ..writeByte(11)
      ..write(obj.validationAttempts)
      ..writeByte(12)
      ..write(obj.lastValidationError)
      ..writeByte(13)
      ..write(obj.isValid)
      ..writeByte(14)
      ..write(obj.isExpired)
      ..writeByte(15)
      ..write(obj.isRefunded)
      ..writeByte(16)
      ..write(obj.isInTrialPeriod)
      ..writeByte(17)
      ..write(obj.isInIntroductoryPricePeriod)
      ..writeByte(18)
      ..write(obj.isAutoRenewing)
      ..writeByte(19)
      ..write(obj.subscriptionGroupId)
      ..writeByte(20)
      ..write(obj.webOrderLineItemId)
      ..writeByte(21)
      ..write(obj.storeSpecificData)
      ..writeByte(22)
      ..write(obj.deviceId)
      ..writeByte(23)
      ..write(obj.userId)
      ..writeByte(24)
      ..write(obj.price)
      ..writeByte(25)
      ..write(obj.currency)
      ..writeByte(26)
      ..write(obj.countryCode)
      ..writeByte(27)
      ..write(obj.validationResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReceiptValidationResponseModelAdapter
    extends TypeAdapter<ReceiptValidationResponseModel> {
  @override
  final int typeId = 62;

  @override
  ReceiptValidationResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReceiptValidationResponseModel(
      isValid: fields[0] as bool,
      status: fields[1] as ReceiptStatus,
      errorMessage: fields[2] as String?,
      errorCode: fields[3] as String?,
      expirationDate: fields[4] as DateTime?,
      cancellationDate: fields[5] as DateTime?,
      isAutoRenewing: fields[6] as bool,
      isInTrialPeriod: fields[7] as bool,
      isInIntroductoryPricePeriod: fields[8] as bool,
      subscriptionGroupId: fields[9] as String?,
      webOrderLineItemId: fields[10] as String?,
      rawResponse: (fields[11] as Map).cast<String, dynamic>(),
      validatedAt: fields[12] as DateTime,
      serverEnvironment: fields[13] as String?,
      additionalData: (fields[14] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReceiptValidationResponseModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.isValid)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.errorMessage)
      ..writeByte(3)
      ..write(obj.errorCode)
      ..writeByte(4)
      ..write(obj.expirationDate)
      ..writeByte(5)
      ..write(obj.cancellationDate)
      ..writeByte(6)
      ..write(obj.isAutoRenewing)
      ..writeByte(7)
      ..write(obj.isInTrialPeriod)
      ..writeByte(8)
      ..write(obj.isInIntroductoryPricePeriod)
      ..writeByte(9)
      ..write(obj.subscriptionGroupId)
      ..writeByte(10)
      ..write(obj.webOrderLineItemId)
      ..writeByte(11)
      ..write(obj.rawResponse)
      ..writeByte(12)
      ..write(obj.validatedAt)
      ..writeByte(13)
      ..write(obj.serverEnvironment)
      ..writeByte(14)
      ..write(obj.additionalData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptValidationResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReceiptHistoryModelAdapter extends TypeAdapter<ReceiptHistoryModel> {
  @override
  final int typeId = 63;

  @override
  ReceiptHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReceiptHistoryModel(
      receipts: (fields[0] as List).cast<ReceiptModel>(),
      lastUpdatedAt: fields[1] as DateTime,
      activeReceiptId: fields[2] as String?,
      validationAttempts: (fields[3] as Map).cast<String, int>(),
      failedReceiptIds: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReceiptHistoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.receipts)
      ..writeByte(1)
      ..write(obj.lastUpdatedAt)
      ..writeByte(2)
      ..write(obj.activeReceiptId)
      ..writeByte(3)
      ..write(obj.validationAttempts)
      ..writeByte(4)
      ..write(obj.failedReceiptIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReceiptStatusAdapter extends TypeAdapter<ReceiptStatus> {
  @override
  final int typeId = 61;

  @override
  ReceiptStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReceiptStatus.pending;
      case 1:
        return ReceiptStatus.valid;
      case 2:
        return ReceiptStatus.invalid;
      case 3:
        return ReceiptStatus.expired;
      case 4:
        return ReceiptStatus.refunded;
      case 5:
        return ReceiptStatus.cancelled;
      case 6:
        return ReceiptStatus.failed;
      default:
        return ReceiptStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, ReceiptStatus obj) {
    switch (obj) {
      case ReceiptStatus.pending:
        writer.writeByte(0);
        break;
      case ReceiptStatus.valid:
        writer.writeByte(1);
        break;
      case ReceiptStatus.invalid:
        writer.writeByte(2);
        break;
      case ReceiptStatus.expired:
        writer.writeByte(3);
        break;
      case ReceiptStatus.refunded:
        writer.writeByte(4);
        break;
      case ReceiptStatus.cancelled:
        writer.writeByte(5);
        break;
      case ReceiptStatus.failed:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      receiptData: json['receiptData'] as String,
      platform: json['platform'] as String,
      productId: json['productId'] as String,
      transactionId: json['transactionId'] as String,
      originalTransactionId: json['originalTransactionId'] as String?,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      cancellationDate: json['cancellationDate'] == null
          ? null
          : DateTime.parse(json['cancellationDate'] as String),
      status: $enumDecodeNullable(_$ReceiptStatusEnumMap, json['status']) ??
          ReceiptStatus.pending,
      lastValidatedAt: DateTime.parse(json['lastValidatedAt'] as String),
      lastValidationAttemptAt: json['lastValidationAttemptAt'] == null
          ? null
          : DateTime.parse(json['lastValidationAttemptAt'] as String),
      validationAttempts: (json['validationAttempts'] as num?)?.toInt() ?? 0,
      lastValidationError: json['lastValidationError'] as String?,
      isValid: json['isValid'] as bool? ?? false,
      isExpired: json['isExpired'] as bool? ?? false,
      isRefunded: json['isRefunded'] as bool? ?? false,
      isInTrialPeriod: json['isInTrialPeriod'] as bool? ?? false,
      isInIntroductoryPricePeriod:
          json['isInIntroductoryPricePeriod'] as bool? ?? false,
      isAutoRenewing: json['isAutoRenewing'] as bool? ?? false,
      subscriptionGroupId: json['subscriptionGroupId'] as String?,
      webOrderLineItemId: json['webOrderLineItemId'] as String?,
      storeSpecificData:
          json['storeSpecificData'] as Map<String, dynamic>? ?? const {},
      deviceId: json['deviceId'] as String?,
      userId: json['userId'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      countryCode: json['countryCode'] as String?,
      validationResponse:
          json['validationResponse'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'receiptData': instance.receiptData,
      'platform': instance.platform,
      'productId': instance.productId,
      'transactionId': instance.transactionId,
      'originalTransactionId': instance.originalTransactionId,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'cancellationDate': instance.cancellationDate?.toIso8601String(),
      'status': _$ReceiptStatusEnumMap[instance.status]!,
      'lastValidatedAt': instance.lastValidatedAt.toIso8601String(),
      'lastValidationAttemptAt':
          instance.lastValidationAttemptAt?.toIso8601String(),
      'validationAttempts': instance.validationAttempts,
      'lastValidationError': instance.lastValidationError,
      'isValid': instance.isValid,
      'isExpired': instance.isExpired,
      'isRefunded': instance.isRefunded,
      'isInTrialPeriod': instance.isInTrialPeriod,
      'isInIntroductoryPricePeriod': instance.isInIntroductoryPricePeriod,
      'isAutoRenewing': instance.isAutoRenewing,
      'subscriptionGroupId': instance.subscriptionGroupId,
      'webOrderLineItemId': instance.webOrderLineItemId,
      'storeSpecificData': instance.storeSpecificData,
      'deviceId': instance.deviceId,
      'userId': instance.userId,
      'price': instance.price,
      'currency': instance.currency,
      'countryCode': instance.countryCode,
      'validationResponse': instance.validationResponse,
    };

const _$ReceiptStatusEnumMap = {
  ReceiptStatus.pending: 'pending',
  ReceiptStatus.valid: 'valid',
  ReceiptStatus.invalid: 'invalid',
  ReceiptStatus.expired: 'expired',
  ReceiptStatus.refunded: 'refunded',
  ReceiptStatus.cancelled: 'cancelled',
  ReceiptStatus.failed: 'failed',
};

ReceiptValidationResponseModel _$ReceiptValidationResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReceiptValidationResponseModel(
      isValid: json['isValid'] as bool,
      status: $enumDecode(_$ReceiptStatusEnumMap, json['status']),
      errorMessage: json['errorMessage'] as String?,
      errorCode: json['errorCode'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      cancellationDate: json['cancellationDate'] == null
          ? null
          : DateTime.parse(json['cancellationDate'] as String),
      isAutoRenewing: json['isAutoRenewing'] as bool? ?? false,
      isInTrialPeriod: json['isInTrialPeriod'] as bool? ?? false,
      isInIntroductoryPricePeriod:
          json['isInIntroductoryPricePeriod'] as bool? ?? false,
      subscriptionGroupId: json['subscriptionGroupId'] as String?,
      webOrderLineItemId: json['webOrderLineItemId'] as String?,
      rawResponse: json['rawResponse'] as Map<String, dynamic>? ?? const {},
      validatedAt: DateTime.parse(json['validatedAt'] as String),
      serverEnvironment: json['serverEnvironment'] as String?,
      additionalData:
          json['additionalData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ReceiptValidationResponseModelToJson(
        ReceiptValidationResponseModel instance) =>
    <String, dynamic>{
      'isValid': instance.isValid,
      'status': _$ReceiptStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'errorCode': instance.errorCode,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'cancellationDate': instance.cancellationDate?.toIso8601String(),
      'isAutoRenewing': instance.isAutoRenewing,
      'isInTrialPeriod': instance.isInTrialPeriod,
      'isInIntroductoryPricePeriod': instance.isInIntroductoryPricePeriod,
      'subscriptionGroupId': instance.subscriptionGroupId,
      'webOrderLineItemId': instance.webOrderLineItemId,
      'rawResponse': instance.rawResponse,
      'validatedAt': instance.validatedAt.toIso8601String(),
      'serverEnvironment': instance.serverEnvironment,
      'additionalData': instance.additionalData,
    };

ReceiptHistoryModel _$ReceiptHistoryModelFromJson(Map<String, dynamic> json) =>
    ReceiptHistoryModel(
      receipts: (json['receipts'] as List<dynamic>?)
              ?.map((e) => ReceiptModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
      activeReceiptId: json['activeReceiptId'] as String?,
      validationAttempts:
          (json['validationAttempts'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      failedReceiptIds: (json['failedReceiptIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ReceiptHistoryModelToJson(
        ReceiptHistoryModel instance) =>
    <String, dynamic>{
      'receipts': instance.receipts,
      'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
      'activeReceiptId': instance.activeReceiptId,
      'validationAttempts': instance.validationAttempts,
      'failedReceiptIds': instance.failedReceiptIds,
    };
