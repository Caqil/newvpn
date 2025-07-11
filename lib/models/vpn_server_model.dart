import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vpn_server_model.g.dart';

@HiveType(typeId: 30)
@JsonSerializable()
class VpnServerModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String country;

  @HiveField(3)
  final String countryCode;

  @HiveField(4)
  final String city;

  @HiveField(5)
  final String protocol;

  @HiveField(6)
  final String configUrl;

  @HiveField(7)
  final String serverIp;

  @HiveField(8)
  final int port;

  @HiveField(9)
  final ServerStatus status;

  @HiveField(10)
  final int ping;

  @HiveField(11)
  final double load;

  @HiveField(12)
  final int users;

  @HiveField(13)
  final int maxUsers;

  @HiveField(14)
  final bool isPremium;

  @HiveField(15)
  final bool isFavorite;

  @HiveField(16)
  final DateTime lastUpdatedAt;

  @HiveField(17)
  final DateTime? lastConnectedAt;

  @HiveField(18)
  final int connectionCount;

  @HiveField(19)
  final Duration? lastConnectionDuration;

  @HiveField(20)
  final Map<String, dynamic> serverSpecs;

  @HiveField(21)
  final List<String> supportedFeatures;

  @HiveField(22)
  final String? flagEmoji;

  @HiveField(23)
  final double? downloadSpeed;

  @HiveField(24)
  final double? uploadSpeed;

  @HiveField(25)
  final String? provider;

  @HiveField(26)
  final String? region;

  @HiveField(27)
  final bool isRecommended;

  @HiveField(28)
  final int sortOrder;

  const VpnServerModel({
    required this.id,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.city,
    required this.protocol,
    required this.configUrl,
    required this.serverIp,
    required this.port,
    this.status = ServerStatus.online,
    this.ping = 0,
    this.load = 0.0,
    this.users = 0,
    this.maxUsers = 1000,
    this.isPremium = false,
    this.isFavorite = false,
    required this.lastUpdatedAt,
    this.lastConnectedAt,
    this.connectionCount = 0,
    this.lastConnectionDuration,
    this.serverSpecs = const {},
    this.supportedFeatures = const [],
    this.flagEmoji,
    this.downloadSpeed,
    this.uploadSpeed,
    this.provider,
    this.region,
    this.isRecommended = false,
    this.sortOrder = 0,
  });

  factory VpnServerModel.fromJson(Map<String, dynamic> json) =>
      _$VpnServerModelFromJson(json);
  Map<String, dynamic> toJson() => _$VpnServerModelToJson(this);

  // Create from API links response
  factory VpnServerModel.fromConfigUrl(String configUrl, {int index = 0}) {
    final uri = Uri.parse(configUrl);
    String name = 'VPN Server';
    String country = 'Unknown';
    String countryCode = 'XX';
    String city = 'Unknown';
    String protocol = 'unknown';

    // Extract server info from URL fragment
    if (configUrl.contains('#')) {
      final fragment = Uri.decodeComponent(configUrl.split('#').last);
      name = fragment.isNotEmpty ? fragment : name;
    }

    // Determine protocol from URL scheme or path
    if (configUrl.startsWith('vmess://')) {
      protocol = 'vmess';
    } else if (configUrl.startsWith('vless://')) {
      protocol = 'vless';
    } else if (configUrl.startsWith('trojan://')) {
      protocol = 'trojan';
    } else if (configUrl.startsWith('ss://')) {
      protocol = 'shadowsocks';
    }

    // Extract country/location from server name
    final locationInfo = _extractLocationFromName(name);
    country = locationInfo['country'] ?? country;
    countryCode = locationInfo['countryCode'] ?? countryCode;
    city = locationInfo['city'] ?? city;

    return VpnServerModel(
      id: configUrl.hashCode.abs().toString(),
      name: name,
      country: country,
      countryCode: countryCode,
      city: city,
      protocol: protocol,
      configUrl: configUrl,
      serverIp: uri.host,
      port: uri.port > 0 ? uri.port : _getDefaultPort(protocol),
      lastUpdatedAt: DateTime.now(),
      flagEmoji: _getFlagEmoji(countryCode),
      sortOrder: index,
    );
  }

  VpnServerModel copyWith({
    String? id,
    String? name,
    String? country,
    String? countryCode,
    String? city,
    String? protocol,
    String? configUrl,
    String? serverIp,
    int? port,
    ServerStatus? status,
    int? ping,
    double? load,
    int? users,
    int? maxUsers,
    bool? isPremium,
    bool? isFavorite,
    DateTime? lastUpdatedAt,
    DateTime? lastConnectedAt,
    int? connectionCount,
    Duration? lastConnectionDuration,
    Map<String, dynamic>? serverSpecs,
    List<String>? supportedFeatures,
    String? flagEmoji,
    double? downloadSpeed,
    double? uploadSpeed,
    String? provider,
    String? region,
    bool? isRecommended,
    int? sortOrder,
  }) {
    return VpnServerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      city: city ?? this.city,
      protocol: protocol ?? this.protocol,
      configUrl: configUrl ?? this.configUrl,
      serverIp: serverIp ?? this.serverIp,
      port: port ?? this.port,
      status: status ?? this.status,
      ping: ping ?? this.ping,
      load: load ?? this.load,
      users: users ?? this.users,
      maxUsers: maxUsers ?? this.maxUsers,
      isPremium: isPremium ?? this.isPremium,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      lastConnectedAt: lastConnectedAt ?? this.lastConnectedAt,
      connectionCount: connectionCount ?? this.connectionCount,
      lastConnectionDuration:
          lastConnectionDuration ?? this.lastConnectionDuration,
      serverSpecs: serverSpecs ?? this.serverSpecs,
      supportedFeatures: supportedFeatures ?? this.supportedFeatures,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      provider: provider ?? this.provider,
      region: region ?? this.region,
      isRecommended: isRecommended ?? this.isRecommended,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  // Helper methods
  bool get isOnline => status == ServerStatus.online;
  bool get isAvailable => isOnline && load < 0.9 && users < maxUsers;
  bool get isAccessible => !isPremium; // For free users

  String get displayName => '$city, $country';
  String get fullDisplayName => '$name - $displayName';
  String get protocolDisplayName => protocol.toUpperCase();

  ServerQuality get quality {
    if (ping == 0) return ServerQuality.unknown;
    if (ping < 50) return ServerQuality.excellent;
    if (ping < 100) return ServerQuality.good;
    if (ping < 200) return ServerQuality.fair;
    return ServerQuality.poor;
  }

  String get qualityText {
    switch (quality) {
      case ServerQuality.excellent:
        return 'Excellent';
      case ServerQuality.good:
        return 'Good';
      case ServerQuality.fair:
        return 'Fair';
      case ServerQuality.poor:
        return 'Poor';
      case ServerQuality.unknown:
        return 'Unknown';
    }
  }

  String get loadDisplayText {
    final percentage = (load * 100).round();
    if (percentage < 50) return 'Low';
    if (percentage < 80) return 'Medium';
    return 'High';
  }

  String get usersDisplayText => '$users/$maxUsers users';

  bool get hasRecentConnection =>
      lastConnectedAt != null &&
      DateTime.now().difference(lastConnectedAt!).inDays < 7;

  Duration get timeSinceLastUpdate => DateTime.now().difference(lastUpdatedAt);
  bool get needsUpdate => timeSinceLastUpdate.inMinutes > 30;

  // Location helpers
  static Map<String, String> _extractLocationFromName(String name) {
    final lower = name.toLowerCase();

    final countryMap = {
      'usa': {'country': 'United States', 'code': 'US', 'city': 'New York'},
      'us ': {'country': 'United States', 'code': 'US', 'city': 'New York'},
      'uk': {'country': 'United Kingdom', 'code': 'GB', 'city': 'London'},
      'germany': {'country': 'Germany', 'code': 'DE', 'city': 'Berlin'},
      'france': {'country': 'France', 'code': 'FR', 'city': 'Paris'},
      'japan': {'country': 'Japan', 'code': 'JP', 'city': 'Tokyo'},
      'singapore': {'country': 'Singapore', 'code': 'SG', 'city': 'Singapore'},
      'canada': {'country': 'Canada', 'code': 'CA', 'city': 'Toronto'},
      'australia': {'country': 'Australia', 'code': 'AU', 'city': 'Sydney'},
      'netherlands': {
        'country': 'Netherlands',
        'code': 'NL',
        'city': 'Amsterdam',
      },
      'sweden': {'country': 'Sweden', 'code': 'SE', 'city': 'Stockholm'},
      'norway': {'country': 'Norway', 'code': 'NO', 'city': 'Oslo'},
      'switzerland': {'country': 'Switzerland', 'code': 'CH', 'city': 'Zurich'},
      'spain': {'country': 'Spain', 'code': 'ES', 'city': 'Madrid'},
      'italy': {'country': 'Italy', 'code': 'IT', 'city': 'Rome'},
      'russia': {'country': 'Russia', 'code': 'RU', 'city': 'Moscow'},
      'korea': {'country': 'South Korea', 'code': 'KR', 'city': 'Seoul'},
      'china': {'country': 'China', 'code': 'CN', 'city': 'Beijing'},
      'india': {'country': 'India', 'code': 'IN', 'city': 'Mumbai'},
      'brazil': {'country': 'Brazil', 'code': 'BR', 'city': 'São Paulo'},
      'mexico': {'country': 'Mexico', 'code': 'MX', 'city': 'Mexico City'},
      'turkey': {'country': 'Turkey', 'code': 'TR', 'city': 'Istanbul'},
    };

    for (final entry in countryMap.entries) {
      if (lower.contains(entry.key)) {
        return {
          'country': entry.value['country']!,
          'countryCode': entry.value['code']!,
          'city': entry.value['city']!,
        };
      }
    }

    return {'country': 'Unknown', 'countryCode': 'XX', 'city': 'Unknown'};
  }

  static String _getFlagEmoji(String countryCode) {
    final flags = {
      'US': '🇺🇸',
      'GB': '🇬🇧',
      'DE': '🇩🇪',
      'FR': '🇫🇷',
      'JP': '🇯🇵',
      'SG': '🇸🇬',
      'CA': '🇨🇦',
      'AU': '🇦🇺',
      'NL': '🇳🇱',
      'SE': '🇸🇪',
      'NO': '🇳🇴',
      'CH': '🇨🇭',
      'ES': '🇪🇸',
      'IT': '🇮🇹',
      'RU': '🇷🇺',
      'KR': '🇰🇷',
      'CN': '🇨🇳',
      'IN': '🇮🇳',
      'BR': '🇧🇷',
      'MX': '🇲🇽',
      'TR': '🇹🇷',
    };
    return flags[countryCode] ?? '🌍';
  }

  static int _getDefaultPort(String protocol) {
    switch (protocol.toLowerCase()) {
      case 'vmess':
        return 443;
      case 'vless':
        return 443;
      case 'trojan':
        return 443;
      case 'shadowsocks':
        return 1080;
      default:
        return 443;
    }
  }

  @override
  String toString() =>
      'VpnServerModel(name: $name, country: $country, protocol: $protocol)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnServerModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@HiveType(typeId: 31)
enum ServerStatus {
  @HiveField(0)
  online,
  @HiveField(1)
  offline,
  @HiveField(2)
  maintenance,
  @HiveField(3)
  overloaded,
}

@HiveType(typeId: 32)
enum ServerQuality {
  @HiveField(0)
  excellent,
  @HiveField(1)
  good,
  @HiveField(2)
  fair,
  @HiveField(3)
  poor,
  @HiveField(4)
  unknown,
}

@HiveType(typeId: 33)
@JsonSerializable()
class ServerListModel {
  @HiveField(0)
  final List<VpnServerModel> servers;

  @HiveField(1)
  final DateTime lastUpdatedAt;

  @HiveField(2)
  final String? selectedServerId;

  @HiveField(3)
  final List<String> favoriteServerIds;

  @HiveField(4)
  final Map<String, int> serverUsageCount;

  const ServerListModel({
    required this.servers,
    required this.lastUpdatedAt,
    this.selectedServerId,
    this.favoriteServerIds = const [],
    this.serverUsageCount = const {},
  });

  factory ServerListModel.fromJson(Map<String, dynamic> json) =>
      _$ServerListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServerListModelToJson(this);

  // Create from API links response
  factory ServerListModel.fromApiLinks(List<String> links) {
    final servers = links
        .where((link) => link != 'False') // Filter out 'False' entries
        .map(
          (link) =>
              VpnServerModel.fromConfigUrl(link, index: links.indexOf(link)),
        )
        .toList();

    return ServerListModel(servers: servers, lastUpdatedAt: DateTime.now());
  }

  ServerListModel copyWith({
    List<VpnServerModel>? servers,
    DateTime? lastUpdatedAt,
    String? selectedServerId,
    List<String>? favoriteServerIds,
    Map<String, int>? serverUsageCount,
  }) {
    return ServerListModel(
      servers: servers ?? this.servers,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      selectedServerId: selectedServerId ?? this.selectedServerId,
      favoriteServerIds: favoriteServerIds ?? this.favoriteServerIds,
      serverUsageCount: serverUsageCount ?? this.serverUsageCount,
    );
  }

  // Helper methods
  List<VpnServerModel> get availableServers =>
      servers.where((s) => s.isAvailable).toList();
  List<VpnServerModel> get freeServers =>
      servers.where((s) => !s.isPremium).toList();
  List<VpnServerModel> get premiumServers =>
      servers.where((s) => s.isPremium).toList();
  List<VpnServerModel> get favoriteServers =>
      servers.where((s) => favoriteServerIds.contains(s.id)).toList();
  List<VpnServerModel> get recommendedServers =>
      servers.where((s) => s.isRecommended).toList();

  VpnServerModel? get selectedServer => selectedServerId != null
      ? servers.firstWhere(
          (s) => s.id == selectedServerId,
          orElse: () => servers.first,
        )
      : null;

  List<String> get availableCountries =>
      servers.map((s) => s.country).toSet().toList()..sort();

  List<String> get availableProtocols =>
      servers.map((s) => s.protocol).toSet().toList()..sort();

  VpnServerModel? getBestServer({bool premiumOnly = false}) {
    final candidates = premiumOnly ? premiumServers : freeServers;
    if (candidates.isEmpty) return null;

    return candidates
        .where((s) => s.isAvailable)
        .reduce((a, b) => a.ping < b.ping && a.load < b.load ? a : b);
  }

  List<VpnServerModel> getServersByCountry(String country) =>
      servers.where((s) => s.country == country).toList();

  List<VpnServerModel> getServersByProtocol(String protocol) =>
      servers.where((s) => s.protocol == protocol).toList();

  Duration get timeSinceLastUpdate => DateTime.now().difference(lastUpdatedAt);
  bool get needsUpdate => timeSinceLastUpdate.inMinutes > 30;

  @override
  String toString() =>
      'ServerListModel(servers: ${servers.length}, updated: $lastUpdatedAt)';
}
