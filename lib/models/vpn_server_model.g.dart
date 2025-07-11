// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpn_server_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VpnServerModelAdapter extends TypeAdapter<VpnServerModel> {
  @override
  final int typeId = 30;

  @override
  VpnServerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VpnServerModel(
      id: fields[0] as String,
      name: fields[1] as String,
      country: fields[2] as String,
      countryCode: fields[3] as String,
      city: fields[4] as String,
      protocol: fields[5] as String,
      configUrl: fields[6] as String,
      serverIp: fields[7] as String,
      port: fields[8] as int,
      status: fields[9] as ServerStatus,
      ping: fields[10] as int,
      load: fields[11] as double,
      users: fields[12] as int,
      maxUsers: fields[13] as int,
      isPremium: fields[14] as bool,
      isFavorite: fields[15] as bool,
      lastUpdatedAt: fields[16] as DateTime,
      lastConnectedAt: fields[17] as DateTime?,
      connectionCount: fields[18] as int,
      lastConnectionDuration: fields[19] as Duration?,
      serverSpecs: (fields[20] as Map).cast<String, dynamic>(),
      supportedFeatures: (fields[21] as List).cast<String>(),
      flagEmoji: fields[22] as String?,
      downloadSpeed: fields[23] as double?,
      uploadSpeed: fields[24] as double?,
      provider: fields[25] as String?,
      region: fields[26] as String?,
      isRecommended: fields[27] as bool,
      sortOrder: fields[28] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VpnServerModel obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.countryCode)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.protocol)
      ..writeByte(6)
      ..write(obj.configUrl)
      ..writeByte(7)
      ..write(obj.serverIp)
      ..writeByte(8)
      ..write(obj.port)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.ping)
      ..writeByte(11)
      ..write(obj.load)
      ..writeByte(12)
      ..write(obj.users)
      ..writeByte(13)
      ..write(obj.maxUsers)
      ..writeByte(14)
      ..write(obj.isPremium)
      ..writeByte(15)
      ..write(obj.isFavorite)
      ..writeByte(16)
      ..write(obj.lastUpdatedAt)
      ..writeByte(17)
      ..write(obj.lastConnectedAt)
      ..writeByte(18)
      ..write(obj.connectionCount)
      ..writeByte(19)
      ..write(obj.lastConnectionDuration)
      ..writeByte(20)
      ..write(obj.serverSpecs)
      ..writeByte(21)
      ..write(obj.supportedFeatures)
      ..writeByte(22)
      ..write(obj.flagEmoji)
      ..writeByte(23)
      ..write(obj.downloadSpeed)
      ..writeByte(24)
      ..write(obj.uploadSpeed)
      ..writeByte(25)
      ..write(obj.provider)
      ..writeByte(26)
      ..write(obj.region)
      ..writeByte(27)
      ..write(obj.isRecommended)
      ..writeByte(28)
      ..write(obj.sortOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnServerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServerListModelAdapter extends TypeAdapter<ServerListModel> {
  @override
  final int typeId = 33;

  @override
  ServerListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerListModel(
      servers: (fields[0] as List).cast<VpnServerModel>(),
      lastUpdatedAt: fields[1] as DateTime,
      selectedServerId: fields[2] as String?,
      favoriteServerIds: (fields[3] as List).cast<String>(),
      serverUsageCount: (fields[4] as Map).cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ServerListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.servers)
      ..writeByte(1)
      ..write(obj.lastUpdatedAt)
      ..writeByte(2)
      ..write(obj.selectedServerId)
      ..writeByte(3)
      ..write(obj.favoriteServerIds)
      ..writeByte(4)
      ..write(obj.serverUsageCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServerStatusAdapter extends TypeAdapter<ServerStatus> {
  @override
  final int typeId = 31;

  @override
  ServerStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServerStatus.online;
      case 1:
        return ServerStatus.offline;
      case 2:
        return ServerStatus.maintenance;
      case 3:
        return ServerStatus.overloaded;
      default:
        return ServerStatus.online;
    }
  }

  @override
  void write(BinaryWriter writer, ServerStatus obj) {
    switch (obj) {
      case ServerStatus.online:
        writer.writeByte(0);
        break;
      case ServerStatus.offline:
        writer.writeByte(1);
        break;
      case ServerStatus.maintenance:
        writer.writeByte(2);
        break;
      case ServerStatus.overloaded:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ServerQualityAdapter extends TypeAdapter<ServerQuality> {
  @override
  final int typeId = 32;

  @override
  ServerQuality read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ServerQuality.excellent;
      case 1:
        return ServerQuality.good;
      case 2:
        return ServerQuality.fair;
      case 3:
        return ServerQuality.poor;
      case 4:
        return ServerQuality.unknown;
      default:
        return ServerQuality.excellent;
    }
  }

  @override
  void write(BinaryWriter writer, ServerQuality obj) {
    switch (obj) {
      case ServerQuality.excellent:
        writer.writeByte(0);
        break;
      case ServerQuality.good:
        writer.writeByte(1);
        break;
      case ServerQuality.fair:
        writer.writeByte(2);
        break;
      case ServerQuality.poor:
        writer.writeByte(3);
        break;
      case ServerQuality.unknown:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerQualityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VpnServerModel _$VpnServerModelFromJson(Map<String, dynamic> json) =>
    VpnServerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      city: json['city'] as String,
      protocol: json['protocol'] as String,
      configUrl: json['configUrl'] as String,
      serverIp: json['serverIp'] as String,
      port: (json['port'] as num).toInt(),
      status: $enumDecodeNullable(_$ServerStatusEnumMap, json['status']) ??
          ServerStatus.online,
      ping: (json['ping'] as num?)?.toInt() ?? 0,
      load: (json['load'] as num?)?.toDouble() ?? 0.0,
      users: (json['users'] as num?)?.toInt() ?? 0,
      maxUsers: (json['maxUsers'] as num?)?.toInt() ?? 1000,
      isPremium: json['isPremium'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
      lastConnectedAt: json['lastConnectedAt'] == null
          ? null
          : DateTime.parse(json['lastConnectedAt'] as String),
      connectionCount: (json['connectionCount'] as num?)?.toInt() ?? 0,
      lastConnectionDuration: json['lastConnectionDuration'] == null
          ? null
          : Duration(
              microseconds: (json['lastConnectionDuration'] as num).toInt()),
      serverSpecs: json['serverSpecs'] as Map<String, dynamic>? ?? const {},
      supportedFeatures: (json['supportedFeatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      flagEmoji: json['flagEmoji'] as String?,
      downloadSpeed: (json['downloadSpeed'] as num?)?.toDouble(),
      uploadSpeed: (json['uploadSpeed'] as num?)?.toDouble(),
      provider: json['provider'] as String?,
      region: json['region'] as String?,
      isRecommended: json['isRecommended'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VpnServerModelToJson(VpnServerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'city': instance.city,
      'protocol': instance.protocol,
      'configUrl': instance.configUrl,
      'serverIp': instance.serverIp,
      'port': instance.port,
      'status': _$ServerStatusEnumMap[instance.status]!,
      'ping': instance.ping,
      'load': instance.load,
      'users': instance.users,
      'maxUsers': instance.maxUsers,
      'isPremium': instance.isPremium,
      'isFavorite': instance.isFavorite,
      'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
      'lastConnectedAt': instance.lastConnectedAt?.toIso8601String(),
      'connectionCount': instance.connectionCount,
      'lastConnectionDuration': instance.lastConnectionDuration?.inMicroseconds,
      'serverSpecs': instance.serverSpecs,
      'supportedFeatures': instance.supportedFeatures,
      'flagEmoji': instance.flagEmoji,
      'downloadSpeed': instance.downloadSpeed,
      'uploadSpeed': instance.uploadSpeed,
      'provider': instance.provider,
      'region': instance.region,
      'isRecommended': instance.isRecommended,
      'sortOrder': instance.sortOrder,
    };

const _$ServerStatusEnumMap = {
  ServerStatus.online: 'online',
  ServerStatus.offline: 'offline',
  ServerStatus.maintenance: 'maintenance',
  ServerStatus.overloaded: 'overloaded',
};

ServerListModel _$ServerListModelFromJson(Map<String, dynamic> json) =>
    ServerListModel(
      servers: (json['servers'] as List<dynamic>)
          .map((e) => VpnServerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
      selectedServerId: json['selectedServerId'] as String?,
      favoriteServerIds: (json['favoriteServerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      serverUsageCount:
          (json['serverUsageCount'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
    );

Map<String, dynamic> _$ServerListModelToJson(ServerListModel instance) =>
    <String, dynamic>{
      'servers': instance.servers,
      'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
      'selectedServerId': instance.selectedServerId,
      'favoriteServerIds': instance.favoriteServerIds,
      'serverUsageCount': instance.serverUsageCount,
    };
