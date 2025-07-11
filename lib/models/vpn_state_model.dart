import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vpn_state_model.g.dart';

@HiveType(typeId: 40)
@JsonSerializable()
class VpnConnectionModel {
  @HiveField(0)
  final VpnStatus status;

  @HiveField(1)
  final String? serverId;

  @HiveField(2)
  final String? serverName;

  @HiveField(3)
  final String? serverCountry;

  @HiveField(4)
  final DateTime? connectedAt;

  @HiveField(5)
  final DateTime? disconnectedAt;

  @HiveField(6)
  final Duration? connectionDuration;

  @HiveField(7)
  final String? errorMessage;

  @HiveField(8)
  final VpnStatistics? statistics;

  @HiveField(9)
  final String? localIp;

  @HiveField(10)
  final String? publicIp;

  @HiveField(11)
  final String? protocol;

  @HiveField(12)
  final int? ping;

  @HiveField(13)
  final double? downloadSpeed;

  @HiveField(14)
  final double? uploadSpeed;

  @HiveField(15)
  final bool isAutoConnectEnabled;

  @HiveField(16)
  final bool isKillSwitchEnabled;

  @HiveField(17)
  final int reconnectAttempts;

  @HiveField(18)
  final DateTime? lastReconnectAt;

  @HiveField(19)
  final Map<String, dynamic> connectionMetadata;

  const VpnConnectionModel({
    required this.status,
    this.serverId,
    this.serverName,
    this.serverCountry,
    this.connectedAt,
    this.disconnectedAt,
    this.connectionDuration,
    this.errorMessage,
    this.statistics,
    this.localIp,
    this.publicIp,
    this.protocol,
    this.ping,
    this.downloadSpeed,
    this.uploadSpeed,
    this.isAutoConnectEnabled = false,
    this.isKillSwitchEnabled = false,
    this.reconnectAttempts = 0,
    this.lastReconnectAt,
    this.connectionMetadata = const {},
  });

  factory VpnConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$VpnConnectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$VpnConnectionModelToJson(this);

  VpnConnectionModel copyWith({
    VpnStatus? status,
    String? serverId,
    String? serverName,
    String? serverCountry,
    DateTime? connectedAt,
    DateTime? disconnectedAt,
    Duration? connectionDuration,
    String? errorMessage,
    VpnStatistics? statistics,
    String? localIp,
    String? publicIp,
    String? protocol,
    int? ping,
    double? downloadSpeed,
    double? uploadSpeed,
    bool? isAutoConnectEnabled,
    bool? isKillSwitchEnabled,
    int? reconnectAttempts,
    DateTime? lastReconnectAt,
    Map<String, dynamic>? connectionMetadata,
  }) {
    return VpnConnectionModel(
      status: status ?? this.status,
      serverId: serverId ?? this.serverId,
      serverName: serverName ?? this.serverName,
      serverCountry: serverCountry ?? this.serverCountry,
      connectedAt: connectedAt ?? this.connectedAt,
      disconnectedAt: disconnectedAt ?? this.disconnectedAt,
      connectionDuration: connectionDuration ?? this.connectionDuration,
      errorMessage: errorMessage ?? this.errorMessage,
      statistics: statistics ?? this.statistics,
      localIp: localIp ?? this.localIp,
      publicIp: publicIp ?? this.publicIp,
      protocol: protocol ?? this.protocol,
      ping: ping ?? this.ping,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      isAutoConnectEnabled: isAutoConnectEnabled ?? this.isAutoConnectEnabled,
      isKillSwitchEnabled: isKillSwitchEnabled ?? this.isKillSwitchEnabled,
      reconnectAttempts: reconnectAttempts ?? this.reconnectAttempts,
      lastReconnectAt: lastReconnectAt ?? this.lastReconnectAt,
      connectionMetadata: connectionMetadata ?? this.connectionMetadata,
    );
  }

  // Helper methods
  bool get isConnected => status == VpnStatus.connected;
  bool get isConnecting => status == VpnStatus.connecting;
  bool get isDisconnected => status == VpnStatus.disconnected;
  bool get isDisconnecting => status == VpnStatus.disconnecting;
  bool get hasError => status == VpnStatus.error;
  bool get isActive => isConnected || isConnecting;

  String get statusText {
    switch (status) {
      case VpnStatus.connected:
        return 'Connected';
      case VpnStatus.connecting:
        return 'Connecting';
      case VpnStatus.disconnected:
        return 'Disconnected';
      case VpnStatus.disconnecting:
        return 'Disconnecting';
      case VpnStatus.error:
        return 'Error';
    }
  }

  String get displayServerName => serverName ?? 'Unknown Server';
  String get displayServerLocation => serverCountry ?? 'Unknown Location';
  String get displayProtocol => protocol?.toUpperCase() ?? 'Unknown';

  Duration get currentDuration {
    if (!isConnected || connectedAt == null) return Duration.zero;
    return DateTime.now().difference(connectedAt!);
  }

  String get formattedDuration {
    final duration = connectionDuration ?? currentDuration;
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedSpeed {
    if (downloadSpeed == null || uploadSpeed == null) return 'N/A';
    return '↓ ${_formatBytes(downloadSpeed!)} ↑ ${_formatBytes(uploadSpeed!)}';
  }

  String get connectionQuality {
    if (ping == null) return 'Unknown';
    if (ping! < 50) return 'Excellent';
    if (ping! < 100) return 'Good';
    if (ping! < 200) return 'Fair';
    return 'Poor';
  }

  bool get shouldReconnect =>
      reconnectAttempts < 3 &&
      hasError &&
      (lastReconnectAt == null ||
          DateTime.now().difference(lastReconnectAt!).inSeconds > 30);

  static String _formatBytes(double bytes) {
    if (bytes < 1024) return '${bytes.toStringAsFixed(0)} B/s';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB/s';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB/s';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB/s';
  }

  @override
  String toString() =>
      'VpnConnectionModel(status: $status, server: $serverName, duration: $formattedDuration)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnConnectionModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          serverId == other.serverId &&
          connectedAt == other.connectedAt;

  @override
  int get hashCode =>
      status.hashCode ^ serverId.hashCode ^ connectedAt.hashCode;
}

@HiveType(typeId: 41)
enum VpnStatus {
  @HiveField(0)
  disconnected,
  @HiveField(1)
  connecting,
  @HiveField(2)
  connected,
  @HiveField(3)
  disconnecting,
  @HiveField(4)
  error,
}

@HiveType(typeId: 42)
@JsonSerializable()
class VpnStatistics {
  @HiveField(0)
  final int totalBytesDownloaded;

  @HiveField(1)
  final int totalBytesUploaded;

  @HiveField(2)
  final double currentDownloadSpeed;

  @HiveField(3)
  final double currentUploadSpeed;

  @HiveField(4)
  final double maxDownloadSpeed;

  @HiveField(5)
  final double maxUploadSpeed;

  @HiveField(6)
  final int packetsReceived;

  @HiveField(7)
  final int packetsSent;

  @HiveField(8)
  final int packetsLost;

  @HiveField(9)
  final DateTime lastUpdatedAt;

  @HiveField(10)
  final Duration sessionDuration;

  @HiveField(11)
  final int connectionDrops;

  @HiveField(12)
  final double averagePing;

  @HiveField(13)
  final Map<String, dynamic> additionalMetrics;

  const VpnStatistics({
    this.totalBytesDownloaded = 0,
    this.totalBytesUploaded = 0,
    this.currentDownloadSpeed = 0.0,
    this.currentUploadSpeed = 0.0,
    this.maxDownloadSpeed = 0.0,
    this.maxUploadSpeed = 0.0,
    this.packetsReceived = 0,
    this.packetsSent = 0,
    this.packetsLost = 0,
    required this.lastUpdatedAt,
    this.sessionDuration = Duration.zero,
    this.connectionDrops = 0,
    this.averagePing = 0.0,
    this.additionalMetrics = const {},
  });

  factory VpnStatistics.fromJson(Map<String, dynamic> json) =>
      _$VpnStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$VpnStatisticsToJson(this);

  VpnStatistics copyWith({
    int? totalBytesDownloaded,
    int? totalBytesUploaded,
    double? currentDownloadSpeed,
    double? currentUploadSpeed,
    double? maxDownloadSpeed,
    double? maxUploadSpeed,
    int? packetsReceived,
    int? packetsSent,
    int? packetsLost,
    DateTime? lastUpdatedAt,
    Duration? sessionDuration,
    int? connectionDrops,
    double? averagePing,
    Map<String, dynamic>? additionalMetrics,
  }) {
    return VpnStatistics(
      totalBytesDownloaded: totalBytesDownloaded ?? this.totalBytesDownloaded,
      totalBytesUploaded: totalBytesUploaded ?? this.totalBytesUploaded,
      currentDownloadSpeed: currentDownloadSpeed ?? this.currentDownloadSpeed,
      currentUploadSpeed: currentUploadSpeed ?? this.currentUploadSpeed,
      maxDownloadSpeed: maxDownloadSpeed ?? this.maxDownloadSpeed,
      maxUploadSpeed: maxUploadSpeed ?? this.maxUploadSpeed,
      packetsReceived: packetsReceived ?? this.packetsReceived,
      packetsSent: packetsSent ?? this.packetsSent,
      packetsLost: packetsLost ?? this.packetsLost,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      connectionDrops: connectionDrops ?? this.connectionDrops,
      averagePing: averagePing ?? this.averagePing,
      additionalMetrics: additionalMetrics ?? this.additionalMetrics,
    );
  }

  // Helper methods
  int get totalBytes => totalBytesDownloaded + totalBytesUploaded;

  String get formattedTotalDownload =>
      _formatBytes(totalBytesDownloaded.toDouble());
  String get formattedTotalUpload =>
      _formatBytes(totalBytesUploaded.toDouble());
  String get formattedTotalData => _formatBytes(totalBytes.toDouble());

  String get formattedCurrentDownloadSpeed =>
      '${_formatBytes(currentDownloadSpeed)}/s';
  String get formattedCurrentUploadSpeed =>
      '${_formatBytes(currentUploadSpeed)}/s';

  String get formattedMaxDownloadSpeed => '${_formatBytes(maxDownloadSpeed)}/s';
  String get formattedMaxUploadSpeed => '${_formatBytes(maxUploadSpeed)}/s';

  double get packetLossPercentage {
    final totalPackets = packetsReceived + packetsLost;
    if (totalPackets == 0) return 0.0;
    return (packetsLost / totalPackets) * 100;
  }

  String get formattedPacketLoss =>
      '${packetLossPercentage.toStringAsFixed(1)}%';

  String get connectionStability {
    if (connectionDrops == 0) return 'Excellent';
    if (connectionDrops <= 2) return 'Good';
    if (connectionDrops <= 5) return 'Fair';
    return 'Poor';
  }

  static String _formatBytes(double bytes) {
    if (bytes < 1024) return '${bytes.toStringAsFixed(0)} B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  @override
  String toString() =>
      'VpnStatistics(total: $formattedTotalData, speed: ↓${formattedCurrentDownloadSpeed} ↑${formattedCurrentUploadSpeed})';
}

@HiveType(typeId: 43)
@JsonSerializable()
class VpnConfigModel {
  @HiveField(0)
  final String configUrl;

  @HiveField(1)
  final String protocol;

  @HiveField(2)
  final String serverAddress;

  @HiveField(3)
  final int port;

  @HiveField(4)
  final Map<String, dynamic> protocolConfig;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? lastUsedAt;

  @HiveField(7)
  final bool isActive;

  @HiveField(8)
  final String? serverName;

  @HiveField(9)
  final String? serverLocation;

  const VpnConfigModel({
    required this.configUrl,
    required this.protocol,
    required this.serverAddress,
    required this.port,
    this.protocolConfig = const {},
    required this.createdAt,
    this.lastUsedAt,
    this.isActive = false,
    this.serverName,
    this.serverLocation,
  });

  factory VpnConfigModel.fromJson(Map<String, dynamic> json) =>
      _$VpnConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$VpnConfigModelToJson(this);

  VpnConfigModel copyWith({
    String? configUrl,
    String? protocol,
    String? serverAddress,
    int? port,
    Map<String, dynamic>? protocolConfig,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    bool? isActive,
    String? serverName,
    String? serverLocation,
  }) {
    return VpnConfigModel(
      configUrl: configUrl ?? this.configUrl,
      protocol: protocol ?? this.protocol,
      serverAddress: serverAddress ?? this.serverAddress,
      port: port ?? this.port,
      protocolConfig: protocolConfig ?? this.protocolConfig,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      isActive: isActive ?? this.isActive,
      serverName: serverName ?? this.serverName,
      serverLocation: serverLocation ?? this.serverLocation,
    );
  }

  // Helper methods
  String get displayName => serverName ?? '$serverAddress:$port';
  String get displayLocation => serverLocation ?? 'Unknown Location';
  String get protocolDisplayName => protocol.toUpperCase();

  Duration get timeSinceCreated => DateTime.now().difference(createdAt);
  Duration? get timeSinceLastUsed =>
      lastUsedAt?.let((date) => DateTime.now().difference(date));

  bool get isRecentlyUsed =>
      lastUsedAt != null && DateTime.now().difference(lastUsedAt!).inDays < 7;

  @override
  String toString() =>
      'VpnConfigModel(protocol: $protocol, server: $serverAddress:$port)';
}

// Extension for null-safe operations
extension NullableDateTime on DateTime? {
  T? let<T>(T Function(DateTime) transform) {
    final self = this;
    return self != null ? transform(self) : null;
  }
}
