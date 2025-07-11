// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceModelAdapter extends TypeAdapter<DeviceModel> {
  @override
  final int typeId = 10;

  @override
  DeviceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceModel(
      deviceId: fields[0] as String,
      deviceName: fields[1] as String,
      platform: fields[2] as String,
      platformVersion: fields[3] as String,
      deviceModel: fields[4] as String,
      deviceBrand: fields[5] as String,
      appVersion: fields[6] as String,
      appBuildNumber: fields[7] as String,
      registeredAt: fields[8] as DateTime,
      lastActiveAt: fields[9] as DateTime,
      isRegistered: fields[10] as bool,
      fcmToken: fields[11] as String?,
      deviceSpecs: (fields[12] as Map).cast<String, dynamic>(),
      locale: fields[13] as String,
      timeZone: fields[14] as String,
      hasVpnPermission: fields[15] as bool,
      hasNotificationPermission: fields[16] as bool,
      userId: fields[17] as String?,
      totalAppLaunches: fields[18] as int,
      totalAppUsage: fields[19] as Duration,
      firstLaunchAt: fields[20] as DateTime?,
      lastUpdateAt: fields[21] as DateTime?,
      isRooted: fields[22] as bool,
      isEmulator: fields[23] as bool,
      networkType: fields[24] as String?,
      carrierName: fields[25] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceModel obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.deviceId)
      ..writeByte(1)
      ..write(obj.deviceName)
      ..writeByte(2)
      ..write(obj.platform)
      ..writeByte(3)
      ..write(obj.platformVersion)
      ..writeByte(4)
      ..write(obj.deviceModel)
      ..writeByte(5)
      ..write(obj.deviceBrand)
      ..writeByte(6)
      ..write(obj.appVersion)
      ..writeByte(7)
      ..write(obj.appBuildNumber)
      ..writeByte(8)
      ..write(obj.registeredAt)
      ..writeByte(9)
      ..write(obj.lastActiveAt)
      ..writeByte(10)
      ..write(obj.isRegistered)
      ..writeByte(11)
      ..write(obj.fcmToken)
      ..writeByte(12)
      ..write(obj.deviceSpecs)
      ..writeByte(13)
      ..write(obj.locale)
      ..writeByte(14)
      ..write(obj.timeZone)
      ..writeByte(15)
      ..write(obj.hasVpnPermission)
      ..writeByte(16)
      ..write(obj.hasNotificationPermission)
      ..writeByte(17)
      ..write(obj.userId)
      ..writeByte(18)
      ..write(obj.totalAppLaunches)
      ..writeByte(19)
      ..write(obj.totalAppUsage)
      ..writeByte(20)
      ..write(obj.firstLaunchAt)
      ..writeByte(21)
      ..write(obj.lastUpdateAt)
      ..writeByte(22)
      ..write(obj.isRooted)
      ..writeByte(23)
      ..write(obj.isEmulator)
      ..writeByte(24)
      ..write(obj.networkType)
      ..writeByte(25)
      ..write(obj.carrierName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeviceSpecsModelAdapter extends TypeAdapter<DeviceSpecsModel> {
  @override
  final int typeId = 11;

  @override
  DeviceSpecsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceSpecsModel(
      cpuType: fields[0] as String?,
      ramSizeGB: fields[1] as int?,
      storageSizeGB: fields[2] as int?,
      availableStorageGB: fields[3] as int?,
      screenResolution: fields[4] as String?,
      screenDensity: fields[5] as double?,
      screenSizeInches: fields[6] as double?,
      batteryLevel: fields[7] as int?,
      isCharging: fields[8] as bool?,
      isLowPowerMode: fields[9] as bool?,
      connectionType: fields[10] as String?,
      hasFingerprint: fields[11] as bool?,
      hasFaceId: fields[12] as bool?,
      hasNfc: fields[13] as bool?,
      hasBluetooth: fields[14] as bool?,
      kernelVersion: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceSpecsModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.cpuType)
      ..writeByte(1)
      ..write(obj.ramSizeGB)
      ..writeByte(2)
      ..write(obj.storageSizeGB)
      ..writeByte(3)
      ..write(obj.availableStorageGB)
      ..writeByte(4)
      ..write(obj.screenResolution)
      ..writeByte(5)
      ..write(obj.screenDensity)
      ..writeByte(6)
      ..write(obj.screenSizeInches)
      ..writeByte(7)
      ..write(obj.batteryLevel)
      ..writeByte(8)
      ..write(obj.isCharging)
      ..writeByte(9)
      ..write(obj.isLowPowerMode)
      ..writeByte(10)
      ..write(obj.connectionType)
      ..writeByte(11)
      ..write(obj.hasFingerprint)
      ..writeByte(12)
      ..write(obj.hasFaceId)
      ..writeByte(13)
      ..write(obj.hasNfc)
      ..writeByte(14)
      ..write(obj.hasBluetooth)
      ..writeByte(15)
      ..write(obj.kernelVersion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceSpecsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String,
      platform: json['platform'] as String,
      platformVersion: json['platformVersion'] as String,
      deviceModel: json['deviceModel'] as String,
      deviceBrand: json['deviceBrand'] as String,
      appVersion: json['appVersion'] as String,
      appBuildNumber: json['appBuildNumber'] as String,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      lastActiveAt: DateTime.parse(json['lastActiveAt'] as String),
      isRegistered: json['isRegistered'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String?,
      deviceSpecs: json['deviceSpecs'] as Map<String, dynamic>? ?? const {},
      locale: json['locale'] as String,
      timeZone: json['timeZone'] as String,
      hasVpnPermission: json['hasVpnPermission'] as bool? ?? false,
      hasNotificationPermission:
          json['hasNotificationPermission'] as bool? ?? false,
      userId: json['userId'] as String?,
      totalAppLaunches: (json['totalAppLaunches'] as num?)?.toInt() ?? 0,
      totalAppUsage: json['totalAppUsage'] == null
          ? Duration.zero
          : Duration(microseconds: (json['totalAppUsage'] as num).toInt()),
      firstLaunchAt: json['firstLaunchAt'] == null
          ? null
          : DateTime.parse(json['firstLaunchAt'] as String),
      lastUpdateAt: json['lastUpdateAt'] == null
          ? null
          : DateTime.parse(json['lastUpdateAt'] as String),
      isRooted: json['isRooted'] as bool? ?? false,
      isEmulator: json['isEmulator'] as bool? ?? false,
      networkType: json['networkType'] as String?,
      carrierName: json['carrierName'] as String?,
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'platform': instance.platform,
      'platformVersion': instance.platformVersion,
      'deviceModel': instance.deviceModel,
      'deviceBrand': instance.deviceBrand,
      'appVersion': instance.appVersion,
      'appBuildNumber': instance.appBuildNumber,
      'registeredAt': instance.registeredAt.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt.toIso8601String(),
      'isRegistered': instance.isRegistered,
      'fcmToken': instance.fcmToken,
      'deviceSpecs': instance.deviceSpecs,
      'locale': instance.locale,
      'timeZone': instance.timeZone,
      'hasVpnPermission': instance.hasVpnPermission,
      'hasNotificationPermission': instance.hasNotificationPermission,
      'userId': instance.userId,
      'totalAppLaunches': instance.totalAppLaunches,
      'totalAppUsage': instance.totalAppUsage.inMicroseconds,
      'firstLaunchAt': instance.firstLaunchAt?.toIso8601String(),
      'lastUpdateAt': instance.lastUpdateAt?.toIso8601String(),
      'isRooted': instance.isRooted,
      'isEmulator': instance.isEmulator,
      'networkType': instance.networkType,
      'carrierName': instance.carrierName,
    };

DeviceSpecsModel _$DeviceSpecsModelFromJson(Map<String, dynamic> json) =>
    DeviceSpecsModel(
      cpuType: json['cpuType'] as String?,
      ramSizeGB: (json['ramSizeGB'] as num?)?.toInt(),
      storageSizeGB: (json['storageSizeGB'] as num?)?.toInt(),
      availableStorageGB: (json['availableStorageGB'] as num?)?.toInt(),
      screenResolution: json['screenResolution'] as String?,
      screenDensity: (json['screenDensity'] as num?)?.toDouble(),
      screenSizeInches: (json['screenSizeInches'] as num?)?.toDouble(),
      batteryLevel: (json['batteryLevel'] as num?)?.toInt(),
      isCharging: json['isCharging'] as bool?,
      isLowPowerMode: json['isLowPowerMode'] as bool?,
      connectionType: json['connectionType'] as String?,
      hasFingerprint: json['hasFingerprint'] as bool?,
      hasFaceId: json['hasFaceId'] as bool?,
      hasNfc: json['hasNfc'] as bool?,
      hasBluetooth: json['hasBluetooth'] as bool?,
      kernelVersion: json['kernelVersion'] as String?,
    );

Map<String, dynamic> _$DeviceSpecsModelToJson(DeviceSpecsModel instance) =>
    <String, dynamic>{
      'cpuType': instance.cpuType,
      'ramSizeGB': instance.ramSizeGB,
      'storageSizeGB': instance.storageSizeGB,
      'availableStorageGB': instance.availableStorageGB,
      'screenResolution': instance.screenResolution,
      'screenDensity': instance.screenDensity,
      'screenSizeInches': instance.screenSizeInches,
      'batteryLevel': instance.batteryLevel,
      'isCharging': instance.isCharging,
      'isLowPowerMode': instance.isLowPowerMode,
      'connectionType': instance.connectionType,
      'hasFingerprint': instance.hasFingerprint,
      'hasFaceId': instance.hasFaceId,
      'hasNfc': instance.hasNfc,
      'hasBluetooth': instance.hasBluetooth,
      'kernelVersion': instance.kernelVersion,
    };
