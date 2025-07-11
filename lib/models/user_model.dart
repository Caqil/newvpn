import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserModel {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String? deviceId;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final int? dataLimit;

  @HiveField(4)
  final int usedTraffic;

  @HiveField(5)
  final int lifetimeUsedTraffic;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime? onlineAt;

  @HiveField(8)
  final DateTime? expireAt;

  @HiveField(9)
  final String dataLimitResetStrategy;

  @HiveField(10)
  final String? note;

  @HiveField(11)
  final DateTime? subUpdatedAt;

  @HiveField(12)
  final String? subLastUserAgent;

  @HiveField(13)
  final int? onHoldExpireDuration;

  @HiveField(14)
  final int? onHoldTimeout;

  @HiveField(15)
  final int? autoDeleteInDays;

  @HiveField(16)
  final ProxiesModel proxies;

  @HiveField(17)
  final InboundsModel inbounds;

  @HiveField(18)
  final List<String> links;

  @HiveField(19)
  final String subscriptionUrl;

  @HiveField(20)
  final ExcludedInboundsModel excludedInbounds;

  @HiveField(21)
  final AdminModel admin;

  @HiveField(22)
  final bool isPremium;

  @HiveField(23)
  final DateTime? lastLoginAt;

  @HiveField(24)
  final String? fcmToken;

  const UserModel({
    required this.username,
    this.deviceId,
    required this.status,
    this.dataLimit,
    required this.usedTraffic,
    required this.lifetimeUsedTraffic,
    required this.createdAt,
    this.onlineAt,
    this.expireAt,
    required this.dataLimitResetStrategy,
    this.note,
    this.subUpdatedAt,
    this.subLastUserAgent,
    this.onHoldExpireDuration,
    this.onHoldTimeout,
    this.autoDeleteInDays,
    required this.proxies,
    required this.inbounds,
    required this.links,
    required this.subscriptionUrl,
    required this.excludedInbounds,
    required this.admin,
    this.isPremium = false,
    this.lastLoginAt,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Custom fromJson to handle API response
  factory UserModel.fromApiResponse(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      status: json['status'] as String,
      dataLimit: json['data_limit'] as int?,
      usedTraffic: json['used_traffic'] as int,
      lifetimeUsedTraffic: json['lifetime_used_traffic'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      onlineAt: json['online_at'] != null
          ? DateTime.parse(json['online_at'] as String)
          : null,
      expireAt: json['expire'] != null
          ? DateTime.parse(json['expire'] as String)
          : null,
      dataLimitResetStrategy: json['data_limit_reset_strategy'] as String,
      note: json['note'] as String?,
      subUpdatedAt: json['sub_updated_at'] != null
          ? DateTime.parse(json['sub_updated_at'] as String)
          : null,
      subLastUserAgent: json['sub_last_user_agent'] as String?,
      onHoldExpireDuration: json['on_hold_expire_duration'] as int?,
      onHoldTimeout: json['on_hold_timeout'] as int?,
      autoDeleteInDays: json['auto_delete_in_days'] as int?,
      proxies: ProxiesModel.fromJson(json['proxies'] as Map<String, dynamic>),
      inbounds: InboundsModel.fromJson(
        json['inbounds'] as Map<String, dynamic>,
      ),
      links: List<String>.from(json['links'] as List),
      subscriptionUrl: json['subscription_url'] as String,
      excludedInbounds: ExcludedInboundsModel.fromJson(
        json['excluded_inbounds'] as Map<String, dynamic>,
      ),
      admin: AdminModel.fromJson(json['admin'] as Map<String, dynamic>),
      isPremium: json['status'] == 'active' && json['expire'] != null,
    );
  }

  UserModel copyWith({
    String? username,
    String? deviceId,
    String? status,
    int? dataLimit,
    int? usedTraffic,
    int? lifetimeUsedTraffic,
    DateTime? createdAt,
    DateTime? onlineAt,
    DateTime? expireAt,
    String? dataLimitResetStrategy,
    String? note,
    DateTime? subUpdatedAt,
    String? subLastUserAgent,
    int? onHoldExpireDuration,
    int? onHoldTimeout,
    int? autoDeleteInDays,
    ProxiesModel? proxies,
    InboundsModel? inbounds,
    List<String>? links,
    String? subscriptionUrl,
    ExcludedInboundsModel? excludedInbounds,
    AdminModel? admin,
    bool? isPremium,
    DateTime? lastLoginAt,
    String? fcmToken,
  }) {
    return UserModel(
      username: username ?? this.username,
      deviceId: deviceId ?? this.deviceId,
      status: status ?? this.status,
      dataLimit: dataLimit ?? this.dataLimit,
      usedTraffic: usedTraffic ?? this.usedTraffic,
      lifetimeUsedTraffic: lifetimeUsedTraffic ?? this.lifetimeUsedTraffic,
      createdAt: createdAt ?? this.createdAt,
      onlineAt: onlineAt ?? this.onlineAt,
      expireAt: expireAt ?? this.expireAt,
      dataLimitResetStrategy:
          dataLimitResetStrategy ?? this.dataLimitResetStrategy,
      note: note ?? this.note,
      subUpdatedAt: subUpdatedAt ?? this.subUpdatedAt,
      subLastUserAgent: subLastUserAgent ?? this.subLastUserAgent,
      onHoldExpireDuration: onHoldExpireDuration ?? this.onHoldExpireDuration,
      onHoldTimeout: onHoldTimeout ?? this.onHoldTimeout,
      autoDeleteInDays: autoDeleteInDays ?? this.autoDeleteInDays,
      proxies: proxies ?? this.proxies,
      inbounds: inbounds ?? this.inbounds,
      links: links ?? this.links,
      subscriptionUrl: subscriptionUrl ?? this.subscriptionUrl,
      excludedInbounds: excludedInbounds ?? this.excludedInbounds,
      admin: admin ?? this.admin,
      isPremium: isPremium ?? this.isPremium,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  // Helper methods
  bool get isActive => status == 'active';
  bool get isExpired => expireAt != null && expireAt!.isBefore(DateTime.now());
  bool get hasDataLimit => dataLimit != null && dataLimit! > 0;

  double get dataUsagePercentage {
    if (!hasDataLimit) return 0.0;
    return (usedTraffic / dataLimit!) * 100;
  }

  int get remainingData {
    if (!hasDataLimit) return -1; // Unlimited
    return dataLimit! - usedTraffic;
  }

  bool get isDataLimitExceeded => hasDataLimit && usedTraffic >= dataLimit!;

  String get displayName => username.isNotEmpty ? username : 'User';

  Duration? get timeUntilExpiry {
    if (expireAt == null) return null;
    final now = DateTime.now();
    if (expireAt!.isBefore(now)) return Duration.zero;
    return expireAt!.difference(now);
  }

  @override
  String toString() =>
      'UserModel(username: $username, status: $status, isPremium: $isPremium)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          deviceId == other.deviceId;

  @override
  int get hashCode => username.hashCode ^ deviceId.hashCode;
}

@HiveType(typeId: 1)
@JsonSerializable()
class ProxiesModel {
  @HiveField(0)
  final TrojanModel trojan;

  @HiveField(1)
  final ShadowsocksModel shadowsocks;

  @HiveField(2)
  final VmessModel vmess;

  @HiveField(3)
  final VlessModel vless;

  const ProxiesModel({
    required this.trojan,
    required this.shadowsocks,
    required this.vmess,
    required this.vless,
  });

  factory ProxiesModel.fromJson(Map<String, dynamic> json) =>
      _$ProxiesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProxiesModelToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class TrojanModel {
  @HiveField(0)
  final String password;

  @HiveField(1)
  final String flow;

  const TrojanModel({required this.password, required this.flow});

  factory TrojanModel.fromJson(Map<String, dynamic> json) =>
      _$TrojanModelFromJson(json);
  Map<String, dynamic> toJson() => _$TrojanModelToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class ShadowsocksModel {
  @HiveField(0)
  final String password;

  @HiveField(1)
  final String method;

  const ShadowsocksModel({required this.password, required this.method});

  factory ShadowsocksModel.fromJson(Map<String, dynamic> json) =>
      _$ShadowsocksModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShadowsocksModelToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class VmessModel {
  @HiveField(0)
  final String id;

  const VmessModel({required this.id});

  factory VmessModel.fromJson(Map<String, dynamic> json) =>
      _$VmessModelFromJson(json);
  Map<String, dynamic> toJson() => _$VmessModelToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class VlessModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String flow;

  const VlessModel({required this.id, required this.flow});

  factory VlessModel.fromJson(Map<String, dynamic> json) =>
      _$VlessModelFromJson(json);
  Map<String, dynamic> toJson() => _$VlessModelToJson(this);
}

@HiveType(typeId: 6)
@JsonSerializable()
class InboundsModel {
  @HiveField(0)
  final List<String> trojan;

  @HiveField(1)
  final List<String> shadowsocks;

  @HiveField(2)
  final List<String> vmess;

  @HiveField(3)
  final List<String> vless;

  const InboundsModel({
    required this.trojan,
    required this.shadowsocks,
    required this.vmess,
    required this.vless,
  });

  factory InboundsModel.fromJson(Map<String, dynamic> json) =>
      _$InboundsModelFromJson(json);
  Map<String, dynamic> toJson() => _$InboundsModelToJson(this);
}

@HiveType(typeId: 7)
@JsonSerializable()
class ExcludedInboundsModel {
  @HiveField(0)
  final List<String> trojan;

  @HiveField(1)
  final List<String> shadowsocks;

  @HiveField(2)
  final List<String> vmess;

  @HiveField(3)
  final List<String> vless;

  const ExcludedInboundsModel({
    required this.trojan,
    required this.shadowsocks,
    required this.vmess,
    required this.vless,
  });

  factory ExcludedInboundsModel.fromJson(Map<String, dynamic> json) =>
      _$ExcludedInboundsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExcludedInboundsModelToJson(this);
}

@HiveType(typeId: 8)
@JsonSerializable()
class AdminModel {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final bool isSudo;

  @HiveField(2)
  final String? telegramId;

  @HiveField(3)
  final String? discordWebhook;

  const AdminModel({
    required this.username,
    required this.isSudo,
    this.telegramId,
    this.discordWebhook,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminModelToJson(this);
}
