import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class DeviceModel {
  @HiveField(0)
  final String deviceId;

  @HiveField(1)
  final String deviceName;

  @HiveField(2)
  final String platform;

  @HiveField(3)
  final String platformVersion;

  @HiveField(4)
  final String deviceModel;

  @HiveField(5)
  final String deviceBrand;

  @HiveField(6)
  final String appVersion;

  @HiveField(7)
  final String appBuildNumber;

  @HiveField(8)
  final DateTime registeredAt;

  @HiveField(9)
  final DateTime lastActiveAt;

  @HiveField(10)
  final bool isRegistered;

  @HiveField(11)
  final String? fcmToken;

  @HiveField(12)
  final Map<String, dynamic> deviceSpecs;

  @HiveField(13)
  final String locale;

  @HiveField(14)
  final String timeZone;

  @HiveField(15)
  final bool hasVpnPermission;

  @HiveField(16)
  final bool hasNotificationPermission;

  @HiveField(17)
  final String? userId;

  @HiveField(18)
  final int totalAppLaunches;

  @HiveField(19)
  final Duration totalAppUsage;

  @HiveField(20)
  final DateTime? firstLaunchAt;

  @HiveField(21)
  final DateTime? lastUpdateAt;

  @HiveField(22)
  final bool isRooted;

  @HiveField(23)
  final bool isEmulator;

  @HiveField(24)
  final String? networkType;

  @HiveField(25)
  final String? carrierName;

  const DeviceModel({
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    required this.platformVersion,
    required this.deviceModel,
    required this.deviceBrand,
    required this.appVersion,
    required this.appBuildNumber,
    required this.registeredAt,
    required this.lastActiveAt,
    this.isRegistered = false,
    this.fcmToken,
    this.deviceSpecs = const {},
    required this.locale,
    required this.timeZone,
    this.hasVpnPermission = false,
    this.hasNotificationPermission = false,
    this.userId,
    this.totalAppLaunches = 0,
    this.totalAppUsage = Duration.zero,
    this.firstLaunchAt,
    this.lastUpdateAt,
    this.isRooted = false,
    this.isEmulator = false,
    this.networkType,
    this.carrierName,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);

  DeviceModel copyWith({
    String? deviceId,
    String? deviceName,
    String? platform,
    String? platformVersion,
    String? deviceModel,
    String? deviceBrand,
    String? appVersion,
    String? appBuildNumber,
    DateTime? registeredAt,
    DateTime? lastActiveAt,
    bool? isRegistered,
    String? fcmToken,
    Map<String, dynamic>? deviceSpecs,
    String? locale,
    String? timeZone,
    bool? hasVpnPermission,
    bool? hasNotificationPermission,
    String? userId,
    int? totalAppLaunches,
    Duration? totalAppUsage,
    DateTime? firstLaunchAt,
    DateTime? lastUpdateAt,
    bool? isRooted,
    bool? isEmulator,
    String? networkType,
    String? carrierName,
  }) {
    return DeviceModel(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      platform: platform ?? this.platform,
      platformVersion: platformVersion ?? this.platformVersion,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceBrand: deviceBrand ?? this.deviceBrand,
      appVersion: appVersion ?? this.appVersion,
      appBuildNumber: appBuildNumber ?? this.appBuildNumber,
      registeredAt: registeredAt ?? this.registeredAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isRegistered: isRegistered ?? this.isRegistered,
      fcmToken: fcmToken ?? this.fcmToken,
      deviceSpecs: deviceSpecs ?? this.deviceSpecs,
      locale: locale ?? this.locale,
      timeZone: timeZone ?? this.timeZone,
      hasVpnPermission: hasVpnPermission ?? this.hasVpnPermission,
      hasNotificationPermission:
          hasNotificationPermission ?? this.hasNotificationPermission,
      userId: userId ?? this.userId,
      totalAppLaunches: totalAppLaunches ?? this.totalAppLaunches,
      totalAppUsage: totalAppUsage ?? this.totalAppUsage,
      firstLaunchAt: firstLaunchAt ?? this.firstLaunchAt,
      lastUpdateAt: lastUpdateAt ?? this.lastUpdateAt,
      isRooted: isRooted ?? this.isRooted,
      isEmulator: isEmulator ?? this.isEmulator,
      networkType: networkType ?? this.networkType,
      carrierName: carrierName ?? this.carrierName,
    );
  }

  // Helper methods
  Duration get timeSinceRegistration => DateTime.now().difference(registeredAt);
  Duration get timeSinceLastActive => DateTime.now().difference(lastActiveAt);

  bool get isRecentlyActive => timeSinceLastActive.inHours < 24;
  bool get isNewDevice => timeSinceRegistration.inDays < 7;

  String get displayName =>
      deviceName.isNotEmpty ? deviceName : '$deviceBrand $deviceModel';

  String get platformInfo => '$platform $platformVersion';
  String get appInfo => '$appVersion ($appBuildNumber)';

  bool get hasAllPermissions => hasVpnPermission && hasNotificationPermission;

  Map<String, dynamic> toRegistrationData() {
    return {
      'device_id': deviceId,
      'device_name': deviceName,
      'platform': platform,
      'platform_version': platformVersion,
      'device_model': deviceModel,
      'device_brand': deviceBrand,
      'app_version': appVersion,
      'app_build_number': appBuildNumber,
      'locale': locale,
      'timezone': timeZone,
      'device_specs': deviceSpecs,
      'fcm_token': fcmToken,
      'is_rooted': isRooted,
      'is_emulator': isEmulator,
      'network_type': networkType,
      'carrier_name': carrierName,
      'registered_at': registeredAt.toIso8601String(),
    };
  }

  // For analytics
  Map<String, dynamic> get analyticsProperties => {
    'device_platform': platform,
    'device_model': deviceModel,
    'device_brand': deviceBrand,
    'platform_version': platformVersion,
    'app_version': appVersion,
    'locale': locale,
    'timezone': timeZone,
    'is_rooted': isRooted,
    'is_emulator': isEmulator,
    'total_launches': totalAppLaunches,
    'days_since_install': timeSinceRegistration.inDays,
    'has_vpn_permission': hasVpnPermission,
    'has_notification_permission': hasNotificationPermission,
  };

  @override
  String toString() =>
      'DeviceModel(id: $deviceId, name: $displayName, platform: $platformInfo)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModel &&
          runtimeType == other.runtimeType &&
          deviceId == other.deviceId;

  @override
  int get hashCode => deviceId.hashCode;
}

// Device specifications model
@HiveType(typeId: 11)
@JsonSerializable()
class DeviceSpecsModel {
  @HiveField(0)
  final String? cpuType;

  @HiveField(1)
  final int? ramSizeGB;

  @HiveField(2)
  final int? storageSizeGB;

  @HiveField(3)
  final int? availableStorageGB;

  @HiveField(4)
  final String? screenResolution;

  @HiveField(5)
  final double? screenDensity;

  @HiveField(6)
  final double? screenSizeInches;

  @HiveField(7)
  final int? batteryLevel;

  @HiveField(8)
  final bool? isCharging;

  @HiveField(9)
  final bool? isLowPowerMode;

  @HiveField(10)
  final String? connectionType;

  @HiveField(11)
  final bool? hasFingerprint;

  @HiveField(12)
  final bool? hasFaceId;

  @HiveField(13)
  final bool? hasNfc;

  @HiveField(14)
  final bool? hasBluetooth;

  @HiveField(15)
  final String? kernelVersion;

  const DeviceSpecsModel({
    this.cpuType,
    this.ramSizeGB,
    this.storageSizeGB,
    this.availableStorageGB,
    this.screenResolution,
    this.screenDensity,
    this.screenSizeInches,
    this.batteryLevel,
    this.isCharging,
    this.isLowPowerMode,
    this.connectionType,
    this.hasFingerprint,
    this.hasFaceId,
    this.hasNfc,
    this.hasBluetooth,
    this.kernelVersion,
  });

  factory DeviceSpecsModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceSpecsModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceSpecsModelToJson(this);

  DeviceSpecsModel copyWith({
    String? cpuType,
    int? ramSizeGB,
    int? storageSizeGB,
    int? availableStorageGB,
    String? screenResolution,
    double? screenDensity,
    double? screenSizeInches,
    int? batteryLevel,
    bool? isCharging,
    bool? isLowPowerMode,
    String? connectionType,
    bool? hasFingerprint,
    bool? hasFaceId,
    bool? hasNfc,
    bool? hasBluetooth,
    String? kernelVersion,
  }) {
    return DeviceSpecsModel(
      cpuType: cpuType ?? this.cpuType,
      ramSizeGB: ramSizeGB ?? this.ramSizeGB,
      storageSizeGB: storageSizeGB ?? this.storageSizeGB,
      availableStorageGB: availableStorageGB ?? this.availableStorageGB,
      screenResolution: screenResolution ?? this.screenResolution,
      screenDensity: screenDensity ?? this.screenDensity,
      screenSizeInches: screenSizeInches ?? this.screenSizeInches,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isCharging: isCharging ?? this.isCharging,
      isLowPowerMode: isLowPowerMode ?? this.isLowPowerMode,
      connectionType: connectionType ?? this.connectionType,
      hasFingerprint: hasFingerprint ?? this.hasFingerprint,
      hasFaceId: hasFaceId ?? this.hasFaceId,
      hasNfc: hasNfc ?? this.hasNfc,
      hasBluetooth: hasBluetooth ?? this.hasBluetooth,
      kernelVersion: kernelVersion ?? this.kernelVersion,
    );
  }

  // Helper methods
  bool get isLowEndDevice => ramSizeGB != null && ramSizeGB! < 4;
  bool get isHighEndDevice => ramSizeGB != null && ramSizeGB! >= 8;
  bool get hasLowStorage =>
      availableStorageGB != null && availableStorageGB! < 2;
  bool get hasSecureBiometrics => hasFingerprint == true || hasFaceId == true;
  bool get isLowBattery => batteryLevel != null && batteryLevel! < 20;

  String get deviceTier {
    if (isHighEndDevice) return 'high_end';
    if (isLowEndDevice) return 'low_end';
    return 'mid_range';
  }

  @override
  String toString() =>
      'DeviceSpecsModel(ram: ${ramSizeGB}GB, storage: ${storageSizeGB}GB)';
}
