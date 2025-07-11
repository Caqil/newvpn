// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpn_state_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VpnConnectionModelAdapter extends TypeAdapter<VpnConnectionModel> {
  @override
  final int typeId = 40;

  @override
  VpnConnectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VpnConnectionModel(
      status: fields[0] as VpnStatus,
      serverId: fields[1] as String?,
      serverName: fields[2] as String?,
      serverCountry: fields[3] as String?,
      connectedAt: fields[4] as DateTime?,
      disconnectedAt: fields[5] as DateTime?,
      connectionDuration: fields[6] as Duration?,
      errorMessage: fields[7] as String?,
      statistics: fields[8] as VpnStatistics?,
      localIp: fields[9] as String?,
      publicIp: fields[10] as String?,
      protocol: fields[11] as String?,
      ping: fields[12] as int?,
      downloadSpeed: fields[13] as double?,
      uploadSpeed: fields[14] as double?,
      isAutoConnectEnabled: fields[15] as bool,
      isKillSwitchEnabled: fields[16] as bool,
      reconnectAttempts: fields[17] as int,
      lastReconnectAt: fields[18] as DateTime?,
      connectionMetadata: (fields[19] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, VpnConnectionModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.serverId)
      ..writeByte(2)
      ..write(obj.serverName)
      ..writeByte(3)
      ..write(obj.serverCountry)
      ..writeByte(4)
      ..write(obj.connectedAt)
      ..writeByte(5)
      ..write(obj.disconnectedAt)
      ..writeByte(6)
      ..write(obj.connectionDuration)
      ..writeByte(7)
      ..write(obj.errorMessage)
      ..writeByte(8)
      ..write(obj.statistics)
      ..writeByte(9)
      ..write(obj.localIp)
      ..writeByte(10)
      ..write(obj.publicIp)
      ..writeByte(11)
      ..write(obj.protocol)
      ..writeByte(12)
      ..write(obj.ping)
      ..writeByte(13)
      ..write(obj.downloadSpeed)
      ..writeByte(14)
      ..write(obj.uploadSpeed)
      ..writeByte(15)
      ..write(obj.isAutoConnectEnabled)
      ..writeByte(16)
      ..write(obj.isKillSwitchEnabled)
      ..writeByte(17)
      ..write(obj.reconnectAttempts)
      ..writeByte(18)
      ..write(obj.lastReconnectAt)
      ..writeByte(19)
      ..write(obj.connectionMetadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnConnectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VpnStatisticsAdapter extends TypeAdapter<VpnStatistics> {
  @override
  final int typeId = 42;

  @override
  VpnStatistics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VpnStatistics(
      totalBytesDownloaded: fields[0] as int,
      totalBytesUploaded: fields[1] as int,
      currentDownloadSpeed: fields[2] as double,
      currentUploadSpeed: fields[3] as double,
      maxDownloadSpeed: fields[4] as double,
      maxUploadSpeed: fields[5] as double,
      packetsReceived: fields[6] as int,
      packetsSent: fields[7] as int,
      packetsLost: fields[8] as int,
      lastUpdatedAt: fields[9] as DateTime,
      sessionDuration: fields[10] as Duration,
      connectionDrops: fields[11] as int,
      averagePing: fields[12] as double,
      additionalMetrics: (fields[13] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, VpnStatistics obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.totalBytesDownloaded)
      ..writeByte(1)
      ..write(obj.totalBytesUploaded)
      ..writeByte(2)
      ..write(obj.currentDownloadSpeed)
      ..writeByte(3)
      ..write(obj.currentUploadSpeed)
      ..writeByte(4)
      ..write(obj.maxDownloadSpeed)
      ..writeByte(5)
      ..write(obj.maxUploadSpeed)
      ..writeByte(6)
      ..write(obj.packetsReceived)
      ..writeByte(7)
      ..write(obj.packetsSent)
      ..writeByte(8)
      ..write(obj.packetsLost)
      ..writeByte(9)
      ..write(obj.lastUpdatedAt)
      ..writeByte(10)
      ..write(obj.sessionDuration)
      ..writeByte(11)
      ..write(obj.connectionDrops)
      ..writeByte(12)
      ..write(obj.averagePing)
      ..writeByte(13)
      ..write(obj.additionalMetrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnStatisticsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VpnConfigModelAdapter extends TypeAdapter<VpnConfigModel> {
  @override
  final int typeId = 43;

  @override
  VpnConfigModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VpnConfigModel(
      configUrl: fields[0] as String,
      protocol: fields[1] as String,
      serverAddress: fields[2] as String,
      port: fields[3] as int,
      protocolConfig: (fields[4] as Map).cast<String, dynamic>(),
      createdAt: fields[5] as DateTime,
      lastUsedAt: fields[6] as DateTime?,
      isActive: fields[7] as bool,
      serverName: fields[8] as String?,
      serverLocation: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VpnConfigModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.configUrl)
      ..writeByte(1)
      ..write(obj.protocol)
      ..writeByte(2)
      ..write(obj.serverAddress)
      ..writeByte(3)
      ..write(obj.port)
      ..writeByte(4)
      ..write(obj.protocolConfig)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.lastUsedAt)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(8)
      ..write(obj.serverName)
      ..writeByte(9)
      ..write(obj.serverLocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnConfigModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VpnStatusAdapter extends TypeAdapter<VpnStatus> {
  @override
  final int typeId = 41;

  @override
  VpnStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VpnStatus.disconnected;
      case 1:
        return VpnStatus.connecting;
      case 2:
        return VpnStatus.connected;
      case 3:
        return VpnStatus.disconnecting;
      case 4:
        return VpnStatus.error;
      default:
        return VpnStatus.disconnected;
    }
  }

  @override
  void write(BinaryWriter writer, VpnStatus obj) {
    switch (obj) {
      case VpnStatus.disconnected:
        writer.writeByte(0);
        break;
      case VpnStatus.connecting:
        writer.writeByte(1);
        break;
      case VpnStatus.connected:
        writer.writeByte(2);
        break;
      case VpnStatus.disconnecting:
        writer.writeByte(3);
        break;
      case VpnStatus.error:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VpnConnectionModel _$VpnConnectionModelFromJson(Map<String, dynamic> json) =>
    VpnConnectionModel(
      status: $enumDecode(_$VpnStatusEnumMap, json['status']),
      serverId: json['serverId'] as String?,
      serverName: json['serverName'] as String?,
      serverCountry: json['serverCountry'] as String?,
      connectedAt: json['connectedAt'] == null
          ? null
          : DateTime.parse(json['connectedAt'] as String),
      disconnectedAt: json['disconnectedAt'] == null
          ? null
          : DateTime.parse(json['disconnectedAt'] as String),
      connectionDuration: json['connectionDuration'] == null
          ? null
          : Duration(microseconds: (json['connectionDuration'] as num).toInt()),
      errorMessage: json['errorMessage'] as String?,
      statistics: json['statistics'] == null
          ? null
          : VpnStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
      localIp: json['localIp'] as String?,
      publicIp: json['publicIp'] as String?,
      protocol: json['protocol'] as String?,
      ping: (json['ping'] as num?)?.toInt(),
      downloadSpeed: (json['downloadSpeed'] as num?)?.toDouble(),
      uploadSpeed: (json['uploadSpeed'] as num?)?.toDouble(),
      isAutoConnectEnabled: json['isAutoConnectEnabled'] as bool? ?? false,
      isKillSwitchEnabled: json['isKillSwitchEnabled'] as bool? ?? false,
      reconnectAttempts: (json['reconnectAttempts'] as num?)?.toInt() ?? 0,
      lastReconnectAt: json['lastReconnectAt'] == null
          ? null
          : DateTime.parse(json['lastReconnectAt'] as String),
      connectionMetadata:
          json['connectionMetadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$VpnConnectionModelToJson(VpnConnectionModel instance) =>
    <String, dynamic>{
      'status': _$VpnStatusEnumMap[instance.status]!,
      'serverId': instance.serverId,
      'serverName': instance.serverName,
      'serverCountry': instance.serverCountry,
      'connectedAt': instance.connectedAt?.toIso8601String(),
      'disconnectedAt': instance.disconnectedAt?.toIso8601String(),
      'connectionDuration': instance.connectionDuration?.inMicroseconds,
      'errorMessage': instance.errorMessage,
      'statistics': instance.statistics,
      'localIp': instance.localIp,
      'publicIp': instance.publicIp,
      'protocol': instance.protocol,
      'ping': instance.ping,
      'downloadSpeed': instance.downloadSpeed,
      'uploadSpeed': instance.uploadSpeed,
      'isAutoConnectEnabled': instance.isAutoConnectEnabled,
      'isKillSwitchEnabled': instance.isKillSwitchEnabled,
      'reconnectAttempts': instance.reconnectAttempts,
      'lastReconnectAt': instance.lastReconnectAt?.toIso8601String(),
      'connectionMetadata': instance.connectionMetadata,
    };

const _$VpnStatusEnumMap = {
  VpnStatus.disconnected: 'disconnected',
  VpnStatus.connecting: 'connecting',
  VpnStatus.connected: 'connected',
  VpnStatus.disconnecting: 'disconnecting',
  VpnStatus.error: 'error',
};

VpnStatistics _$VpnStatisticsFromJson(Map<String, dynamic> json) =>
    VpnStatistics(
      totalBytesDownloaded:
          (json['totalBytesDownloaded'] as num?)?.toInt() ?? 0,
      totalBytesUploaded: (json['totalBytesUploaded'] as num?)?.toInt() ?? 0,
      currentDownloadSpeed:
          (json['currentDownloadSpeed'] as num?)?.toDouble() ?? 0.0,
      currentUploadSpeed:
          (json['currentUploadSpeed'] as num?)?.toDouble() ?? 0.0,
      maxDownloadSpeed: (json['maxDownloadSpeed'] as num?)?.toDouble() ?? 0.0,
      maxUploadSpeed: (json['maxUploadSpeed'] as num?)?.toDouble() ?? 0.0,
      packetsReceived: (json['packetsReceived'] as num?)?.toInt() ?? 0,
      packetsSent: (json['packetsSent'] as num?)?.toInt() ?? 0,
      packetsLost: (json['packetsLost'] as num?)?.toInt() ?? 0,
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
      sessionDuration: json['sessionDuration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['sessionDuration'] as num).toInt()),
      connectionDrops: (json['connectionDrops'] as num?)?.toInt() ?? 0,
      averagePing: (json['averagePing'] as num?)?.toDouble() ?? 0.0,
      additionalMetrics:
          json['additionalMetrics'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$VpnStatisticsToJson(VpnStatistics instance) =>
    <String, dynamic>{
      'totalBytesDownloaded': instance.totalBytesDownloaded,
      'totalBytesUploaded': instance.totalBytesUploaded,
      'currentDownloadSpeed': instance.currentDownloadSpeed,
      'currentUploadSpeed': instance.currentUploadSpeed,
      'maxDownloadSpeed': instance.maxDownloadSpeed,
      'maxUploadSpeed': instance.maxUploadSpeed,
      'packetsReceived': instance.packetsReceived,
      'packetsSent': instance.packetsSent,
      'packetsLost': instance.packetsLost,
      'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
      'sessionDuration': instance.sessionDuration.inMicroseconds,
      'connectionDrops': instance.connectionDrops,
      'averagePing': instance.averagePing,
      'additionalMetrics': instance.additionalMetrics,
    };

VpnConfigModel _$VpnConfigModelFromJson(Map<String, dynamic> json) =>
    VpnConfigModel(
      configUrl: json['configUrl'] as String,
      protocol: json['protocol'] as String,
      serverAddress: json['serverAddress'] as String,
      port: (json['port'] as num).toInt(),
      protocolConfig:
          json['protocolConfig'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      isActive: json['isActive'] as bool? ?? false,
      serverName: json['serverName'] as String?,
      serverLocation: json['serverLocation'] as String?,
    );

Map<String, dynamic> _$VpnConfigModelToJson(VpnConfigModel instance) =>
    <String, dynamic>{
      'configUrl': instance.configUrl,
      'protocol': instance.protocol,
      'serverAddress': instance.serverAddress,
      'port': instance.port,
      'protocolConfig': instance.protocolConfig,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'isActive': instance.isActive,
      'serverName': instance.serverName,
      'serverLocation': instance.serverLocation,
    };
