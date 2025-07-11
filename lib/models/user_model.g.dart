// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      username: fields[0] as String,
      deviceId: fields[1] as String?,
      status: fields[2] as String,
      dataLimit: fields[3] as int?,
      usedTraffic: fields[4] as int,
      lifetimeUsedTraffic: fields[5] as int,
      createdAt: fields[6] as DateTime,
      onlineAt: fields[7] as DateTime?,
      expireAt: fields[8] as DateTime?,
      dataLimitResetStrategy: fields[9] as String,
      note: fields[10] as String?,
      subUpdatedAt: fields[11] as DateTime?,
      subLastUserAgent: fields[12] as String?,
      onHoldExpireDuration: fields[13] as int?,
      onHoldTimeout: fields[14] as int?,
      autoDeleteInDays: fields[15] as int?,
      proxies: fields[16] as ProxiesModel,
      inbounds: fields[17] as InboundsModel,
      links: (fields[18] as List).cast<String>(),
      subscriptionUrl: fields[19] as String,
      excludedInbounds: fields[20] as ExcludedInboundsModel,
      admin: fields[21] as AdminModel,
      isPremium: fields[22] as bool,
      lastLoginAt: fields[23] as DateTime?,
      fcmToken: fields[24] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.deviceId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.dataLimit)
      ..writeByte(4)
      ..write(obj.usedTraffic)
      ..writeByte(5)
      ..write(obj.lifetimeUsedTraffic)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.onlineAt)
      ..writeByte(8)
      ..write(obj.expireAt)
      ..writeByte(9)
      ..write(obj.dataLimitResetStrategy)
      ..writeByte(10)
      ..write(obj.note)
      ..writeByte(11)
      ..write(obj.subUpdatedAt)
      ..writeByte(12)
      ..write(obj.subLastUserAgent)
      ..writeByte(13)
      ..write(obj.onHoldExpireDuration)
      ..writeByte(14)
      ..write(obj.onHoldTimeout)
      ..writeByte(15)
      ..write(obj.autoDeleteInDays)
      ..writeByte(16)
      ..write(obj.proxies)
      ..writeByte(17)
      ..write(obj.inbounds)
      ..writeByte(18)
      ..write(obj.links)
      ..writeByte(19)
      ..write(obj.subscriptionUrl)
      ..writeByte(20)
      ..write(obj.excludedInbounds)
      ..writeByte(21)
      ..write(obj.admin)
      ..writeByte(22)
      ..write(obj.isPremium)
      ..writeByte(23)
      ..write(obj.lastLoginAt)
      ..writeByte(24)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProxiesModelAdapter extends TypeAdapter<ProxiesModel> {
  @override
  final int typeId = 1;

  @override
  ProxiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProxiesModel(
      trojan: fields[0] as TrojanModel,
      shadowsocks: fields[1] as ShadowsocksModel,
      vmess: fields[2] as VmessModel,
      vless: fields[3] as VlessModel,
    );
  }

  @override
  void write(BinaryWriter writer, ProxiesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trojan)
      ..writeByte(1)
      ..write(obj.shadowsocks)
      ..writeByte(2)
      ..write(obj.vmess)
      ..writeByte(3)
      ..write(obj.vless);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProxiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrojanModelAdapter extends TypeAdapter<TrojanModel> {
  @override
  final int typeId = 2;

  @override
  TrojanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrojanModel(
      password: fields[0] as String,
      flow: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TrojanModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.flow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrojanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ShadowsocksModelAdapter extends TypeAdapter<ShadowsocksModel> {
  @override
  final int typeId = 3;

  @override
  ShadowsocksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShadowsocksModel(
      password: fields[0] as String,
      method: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShadowsocksModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.method);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShadowsocksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VmessModelAdapter extends TypeAdapter<VmessModel> {
  @override
  final int typeId = 4;

  @override
  VmessModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VmessModel(
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VmessModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VmessModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VlessModelAdapter extends TypeAdapter<VlessModel> {
  @override
  final int typeId = 5;

  @override
  VlessModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VlessModel(
      id: fields[0] as String,
      flow: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VlessModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.flow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VlessModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InboundsModelAdapter extends TypeAdapter<InboundsModel> {
  @override
  final int typeId = 6;

  @override
  InboundsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InboundsModel(
      trojan: (fields[0] as List).cast<String>(),
      shadowsocks: (fields[1] as List).cast<String>(),
      vmess: (fields[2] as List).cast<String>(),
      vless: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, InboundsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trojan)
      ..writeByte(1)
      ..write(obj.shadowsocks)
      ..writeByte(2)
      ..write(obj.vmess)
      ..writeByte(3)
      ..write(obj.vless);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InboundsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExcludedInboundsModelAdapter extends TypeAdapter<ExcludedInboundsModel> {
  @override
  final int typeId = 7;

  @override
  ExcludedInboundsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExcludedInboundsModel(
      trojan: (fields[0] as List).cast<String>(),
      shadowsocks: (fields[1] as List).cast<String>(),
      vmess: (fields[2] as List).cast<String>(),
      vless: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExcludedInboundsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.trojan)
      ..writeByte(1)
      ..write(obj.shadowsocks)
      ..writeByte(2)
      ..write(obj.vmess)
      ..writeByte(3)
      ..write(obj.vless);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExcludedInboundsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AdminModelAdapter extends TypeAdapter<AdminModel> {
  @override
  final int typeId = 8;

  @override
  AdminModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminModel(
      username: fields[0] as String,
      isSudo: fields[1] as bool,
      telegramId: fields[2] as String?,
      discordWebhook: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.isSudo)
      ..writeByte(2)
      ..write(obj.telegramId)
      ..writeByte(3)
      ..write(obj.discordWebhook);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String,
      deviceId: json['deviceId'] as String?,
      status: json['status'] as String,
      dataLimit: (json['dataLimit'] as num?)?.toInt(),
      usedTraffic: (json['usedTraffic'] as num).toInt(),
      lifetimeUsedTraffic: (json['lifetimeUsedTraffic'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      onlineAt: json['onlineAt'] == null
          ? null
          : DateTime.parse(json['onlineAt'] as String),
      expireAt: json['expireAt'] == null
          ? null
          : DateTime.parse(json['expireAt'] as String),
      dataLimitResetStrategy: json['dataLimitResetStrategy'] as String,
      note: json['note'] as String?,
      subUpdatedAt: json['subUpdatedAt'] == null
          ? null
          : DateTime.parse(json['subUpdatedAt'] as String),
      subLastUserAgent: json['subLastUserAgent'] as String?,
      onHoldExpireDuration: (json['onHoldExpireDuration'] as num?)?.toInt(),
      onHoldTimeout: (json['onHoldTimeout'] as num?)?.toInt(),
      autoDeleteInDays: (json['autoDeleteInDays'] as num?)?.toInt(),
      proxies: ProxiesModel.fromJson(json['proxies'] as Map<String, dynamic>),
      inbounds:
          InboundsModel.fromJson(json['inbounds'] as Map<String, dynamic>),
      links: (json['links'] as List<dynamic>).map((e) => e as String).toList(),
      subscriptionUrl: json['subscriptionUrl'] as String,
      excludedInbounds: ExcludedInboundsModel.fromJson(
          json['excludedInbounds'] as Map<String, dynamic>),
      admin: AdminModel.fromJson(json['admin'] as Map<String, dynamic>),
      isPremium: json['isPremium'] as bool? ?? false,
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'deviceId': instance.deviceId,
      'status': instance.status,
      'dataLimit': instance.dataLimit,
      'usedTraffic': instance.usedTraffic,
      'lifetimeUsedTraffic': instance.lifetimeUsedTraffic,
      'createdAt': instance.createdAt.toIso8601String(),
      'onlineAt': instance.onlineAt?.toIso8601String(),
      'expireAt': instance.expireAt?.toIso8601String(),
      'dataLimitResetStrategy': instance.dataLimitResetStrategy,
      'note': instance.note,
      'subUpdatedAt': instance.subUpdatedAt?.toIso8601String(),
      'subLastUserAgent': instance.subLastUserAgent,
      'onHoldExpireDuration': instance.onHoldExpireDuration,
      'onHoldTimeout': instance.onHoldTimeout,
      'autoDeleteInDays': instance.autoDeleteInDays,
      'proxies': instance.proxies,
      'inbounds': instance.inbounds,
      'links': instance.links,
      'subscriptionUrl': instance.subscriptionUrl,
      'excludedInbounds': instance.excludedInbounds,
      'admin': instance.admin,
      'isPremium': instance.isPremium,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'fcmToken': instance.fcmToken,
    };

ProxiesModel _$ProxiesModelFromJson(Map<String, dynamic> json) => ProxiesModel(
      trojan: TrojanModel.fromJson(json['trojan'] as Map<String, dynamic>),
      shadowsocks: ShadowsocksModel.fromJson(
          json['shadowsocks'] as Map<String, dynamic>),
      vmess: VmessModel.fromJson(json['vmess'] as Map<String, dynamic>),
      vless: VlessModel.fromJson(json['vless'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProxiesModelToJson(ProxiesModel instance) =>
    <String, dynamic>{
      'trojan': instance.trojan,
      'shadowsocks': instance.shadowsocks,
      'vmess': instance.vmess,
      'vless': instance.vless,
    };

TrojanModel _$TrojanModelFromJson(Map<String, dynamic> json) => TrojanModel(
      password: json['password'] as String,
      flow: json['flow'] as String,
    );

Map<String, dynamic> _$TrojanModelToJson(TrojanModel instance) =>
    <String, dynamic>{
      'password': instance.password,
      'flow': instance.flow,
    };

ShadowsocksModel _$ShadowsocksModelFromJson(Map<String, dynamic> json) =>
    ShadowsocksModel(
      password: json['password'] as String,
      method: json['method'] as String,
    );

Map<String, dynamic> _$ShadowsocksModelToJson(ShadowsocksModel instance) =>
    <String, dynamic>{
      'password': instance.password,
      'method': instance.method,
    };

VmessModel _$VmessModelFromJson(Map<String, dynamic> json) => VmessModel(
      id: json['id'] as String,
    );

Map<String, dynamic> _$VmessModelToJson(VmessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

VlessModel _$VlessModelFromJson(Map<String, dynamic> json) => VlessModel(
      id: json['id'] as String,
      flow: json['flow'] as String,
    );

Map<String, dynamic> _$VlessModelToJson(VlessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flow': instance.flow,
    };

InboundsModel _$InboundsModelFromJson(Map<String, dynamic> json) =>
    InboundsModel(
      trojan:
          (json['trojan'] as List<dynamic>).map((e) => e as String).toList(),
      shadowsocks: (json['shadowsocks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      vmess: (json['vmess'] as List<dynamic>).map((e) => e as String).toList(),
      vless: (json['vless'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InboundsModelToJson(InboundsModel instance) =>
    <String, dynamic>{
      'trojan': instance.trojan,
      'shadowsocks': instance.shadowsocks,
      'vmess': instance.vmess,
      'vless': instance.vless,
    };

ExcludedInboundsModel _$ExcludedInboundsModelFromJson(
        Map<String, dynamic> json) =>
    ExcludedInboundsModel(
      trojan:
          (json['trojan'] as List<dynamic>).map((e) => e as String).toList(),
      shadowsocks: (json['shadowsocks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      vmess: (json['vmess'] as List<dynamic>).map((e) => e as String).toList(),
      vless: (json['vless'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ExcludedInboundsModelToJson(
        ExcludedInboundsModel instance) =>
    <String, dynamic>{
      'trojan': instance.trojan,
      'shadowsocks': instance.shadowsocks,
      'vmess': instance.vmess,
      'vless': instance.vless,
    };

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      username: json['username'] as String,
      isSudo: json['isSudo'] as bool,
      telegramId: json['telegramId'] as String?,
      discordWebhook: json['discordWebhook'] as String?,
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'isSudo': instance.isSudo,
      'telegramId': instance.telegramId,
      'discordWebhook': instance.discordWebhook,
    };
