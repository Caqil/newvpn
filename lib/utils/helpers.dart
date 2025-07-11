import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Helpers {
  // Generate random string for IDs
  static String generateRandomId([int length = 16]) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }
  
  // Generate secure hash
  static String generateHash(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  // Encode base64
  static String encodeBase64(String input) {
    final bytes = utf8.encode(input);
    return base64.encode(bytes);
  }
  
  // Decode base64
  static String decodeBase64(String encoded) {
    try {
      final bytes = base64.decode(encoded);
      return utf8.decode(bytes);
    } catch (e) {
      return '';
    }
  }
  
  // Parse VPN config URL
  static Map<String, dynamic> parseVpnConfig(String configUrl) {
    try {
      if (configUrl.startsWith('vmess://')) {
        return _parseVmessConfig(configUrl);
      } else if (configUrl.startsWith('vless://')) {
        return _parseVlessConfig(configUrl);
      } else if (configUrl.startsWith('trojan://')) {
        return _parseTrojanConfig(configUrl);
      } else if (configUrl.startsWith('ss://')) {
        return _parseShadowsocksConfig(configUrl);
      }
      return {};
    } catch (e) {
      return {};
    }
  }
  
  // Parse VMess config
  static Map<String, dynamic> _parseVmessConfig(String configUrl) {
    try {
      final encoded = configUrl.substring(8); // Remove 'vmess://'
      final decoded = decodeBase64(encoded);
      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
  
  // Parse VLESS config
  static Map<String, dynamic> _parseVlessConfig(String configUrl) {
    try {
      final uri = Uri.parse(configUrl);
      return {
        'id': uri.userInfo,
        'add': uri.host,
        'port': uri.port,
        'ps': Uri.decodeComponent(uri.fragment),
        'net': uri.queryParameters['type'] ?? 'tcp',
        'security': uri.queryParameters['security'] ?? 'none',
        'sni': uri.queryParameters['sni'] ?? '',
        'fp': uri.queryParameters['fp'] ?? '',
        'pbk': uri.queryParameters['pbk'] ?? '',
      };
    } catch (e) {
      return {};
    }
  }
  
  // Parse Trojan config
  static Map<String, dynamic> _parseTrojanConfig(String configUrl) {
    try {
      final uri = Uri.parse(configUrl);
      return {
        'password': uri.userInfo,
        'add': uri.host,
        'port': uri.port,
        'ps': Uri.decodeComponent(uri.fragment),
        'security': uri.queryParameters['security'] ?? 'tls',
        'sni': uri.queryParameters['sni'] ?? '',
        'type': uri.queryParameters['type'] ?? 'tcp',
      };
    } catch (e) {
      return {};
    }
  }
  
  // Parse Shadowsocks config
  static Map<String, dynamic> _parseShadowsocksConfig(String configUrl) {
    try {
      final uri = Uri.parse(configUrl);
      final userInfo = decodeBase64(uri.userInfo);
      final parts = userInfo.split(':');
      
      return {
        'method': parts.isNotEmpty ? parts[0] : '',
        'password': parts.length > 1 ? parts[1] : '',
        'add': uri.host,
        'port': uri.port,
        'ps': Uri.decodeComponent(uri.fragment),
      };
    } catch (e) {
      return {};
    }
  }
  
  // Extract server info from config
  static Map<String, String> extractServerInfo(String configUrl) {
    String name = 'VPN Server';
    String country = 'Unknown';
    String city = 'Unknown';
    
    // Extract from fragment
    if (configUrl.contains('#')) {
      final fragment = Uri.decodeComponent(configUrl.split('#').last);
      name = fragment.isNotEmpty ? fragment : name;
    }
    
    // Extract country and city from name
    final locationInfo = _extractLocationFromName(name);
    country = locationInfo['country'] ?? country;
    city = locationInfo['city'] ?? city;
    
    return {
      'name': name,
      'country': country,
      'city': city,
    };
  }
  
  // Extract location from server name
  static Map<String, String> _extractLocationFromName(String name) {
    final lower = name.toLowerCase();
    
    final locationMap = {
      'usa': {'country': 'United States', 'city': 'New York'},
      'us ': {'country': 'United States', 'city': 'New York'},
      'uk': {'country': 'United Kingdom', 'city': 'London'},
      'germany': {'country': 'Germany', 'city': 'Berlin'},
      'france': {'country': 'France', 'city': 'Paris'},
      'japan': {'country': 'Japan', 'city': 'Tokyo'},
      'singapore': {'country': 'Singapore', 'city': 'Singapore'},
      'canada': {'country': 'Canada', 'city': 'Toronto'},
      'australia': {'country': 'Australia', 'city': 'Sydney'},
      'netherlands': {'country': 'Netherlands', 'city': 'Amsterdam'},
      'sweden': {'country': 'Sweden', 'city': 'Stockholm'},
      'norway': {'country': 'Norway', 'city': 'Oslo'},
      'switzerland': {'country': 'Switzerland', 'city': 'Zurich'},
      'spain': {'country': 'Spain', 'city': 'Madrid'},
      'italy': {'country': 'Italy', 'city': 'Rome'},
      'russia': {'country': 'Russia', 'city': 'Moscow'},
      'korea': {'country': 'South Korea', 'city': 'Seoul'},
      'china': {'country': 'China', 'city': 'Beijing'},
      'india': {'country': 'India', 'city': 'Mumbai'},
      'brazil': {'country': 'Brazil', 'city': 'São Paulo'},
      'mexico': {'country': 'Mexico', 'city': 'Mexico City'},
      'turkey': {'country': 'Turkey', 'city': 'Istanbul'},
    };
    
    for (final entry in locationMap.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }
    
    return {'country': 'Unknown', 'city': 'Unknown'};
  }
  
  // Get country flag emoji
  static String getCountryFlag(String countryCode) {
    final flags = {
      'US': '🇺🇸', 'GB': '🇬🇧', 'DE': '🇩🇪', 'FR': '🇫🇷', 'JP': '🇯🇵',
      'SG': '🇸🇬', 'CA': '🇨🇦', 'AU': '🇦🇺', 'NL': '🇳🇱', 'SE': '🇸🇪',
      'NO': '🇳🇴', 'CH': '🇨🇭', 'ES': '🇪🇸', 'IT': '🇮🇹', 'RU': '🇷🇺',
      'KR': '🇰🇷', 'CN': '🇨🇳', 'IN': '🇮🇳', 'BR': '🇧🇷', 'MX': '🇲🇽',
      'TR': '🇹🇷',
    };
    return flags[countryCode.toUpperCase()] ?? '🌍';
  }
  
  // Calculate ping color based on value
  static Color getPingColor(int ping) {
    if (ping == 0) return CupertinoColors.systemGrey;
    if (ping < 50) return CupertinoColors.systemGreen;
    if (ping < 100) return CupertinoColors.systemYellow;
    if (ping < 200) return CupertinoColors.systemOrange;
    return CupertinoColors.systemRed;
  }
  
  // Calculate server load color
  static Color getLoadColor(double load) {
    if (load < 0.5) return CupertinoColors.systemGreen;
    if (load < 0.8) return CupertinoColors.systemYellow;
    return CupertinoColors.systemRed;
  }
  
  // Get VPN status color
  static Color getVpnStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return CupertinoColors.systemGreen;
      case 'connecting':
      case 'disconnecting':
        return CupertinoColors.systemOrange;
      case 'disconnected':
        return CupertinoColors.systemGrey;
      case 'error':
        return CupertinoColors.systemRed;
      default:
        return CupertinoColors.systemGrey;
    }
  }
  
  // Get subscription status color
  static Color getSubscriptionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return CupertinoColors.systemGreen;
      case 'expired':
      case 'cancelled':
        return CupertinoColors.systemRed;
      case 'pending':
        return CupertinoColors.systemOrange;
      default:
        return CupertinoColors.systemGrey;
    }
  }
  
  // Copy text to clipboard
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
  
  // Vibrate device
  static void vibrate() {
    HapticFeedback.lightImpact();
  }
  
  // Strong vibration
  static void vibrateStrong() {
    HapticFeedback.heavyImpact();
  }
  
  // Selection vibration
  static void vibrateSelection() {
    HapticFeedback.selectionClick();
  }
  
  // Calculate distance between two coordinates
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }
  
  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
  
  // Check if email is valid
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }
  
  // Check if URL is valid
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
  
  // Sanitize filename
  static String sanitizeFilename(String filename) {
    return filename.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }
  
  // Generate device fingerprint
  static String generateDeviceFingerprint(Map<String, dynamic> deviceInfo) {
    final data = [
      deviceInfo['device_model'] ?? '',
      deviceInfo['device_brand'] ?? '',
      deviceInfo['platform'] ?? '',
      deviceInfo['platform_version'] ?? '',
    ].join('|');
    
    return generateHash(data).substring(0, 16);
  }
  
  // Check if app needs update
  static bool needsUpdate(String currentVersion, String latestVersion) {
    final current = _parseVersion(currentVersion);
    final latest = _parseVersion(latestVersion);
    
    for (int i = 0; i < 3; i++) {
      if (latest[i] > current[i]) return true;
      if (latest[i] < current[i]) return false;
    }
    return false;
  }
  
  static List<int> _parseVersion(String version) {
    final parts = version.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    while (parts.length < 3) parts.add(0);
    return parts.take(3).toList();
  }
  
  // Format duration for display
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  // Get quality text from ping
  static String getQualityFromPing(int ping) {
    if (ping == 0) return 'Unknown';
    if (ping < 50) return 'Excellent';
    if (ping < 100) return 'Good';
    if (ping < 200) return 'Fair';
    return 'Poor';
  }
  
  // Convert bytes to human readable format
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  
  // Check if time is within business hours
  static bool isBusinessHours([DateTime? time]) {
    final now = time ?? DateTime.now();
    final hour = now.hour;
    return hour >= 9 && hour < 17; // 9 AM to 5 PM
  }
  
  // Get random item from list
  static T getRandomItem<T>(List<T> list) {
    if (list.isEmpty) throw ArgumentError('List cannot be empty');
    return list[Random().nextInt(list.length)];
  }
  
  // Retry function with exponential backoff
  static Future<T> retryWithBackoff<T>(
    Future<T> Function() operation, {
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
  }) async {
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        return await operation();
      } catch (e) {
        if (attempt == maxAttempts - 1) rethrow;
        
        final delay = Duration(
          milliseconds: initialDelay.inMilliseconds * pow(2, attempt).toInt(),
        );
        await Future.delayed(delay);
      }
    }
    throw StateError('This should never be reached');
  }
  
  // Debounce function calls
  static void Function() debounce(
    void Function() function,
    Duration delay,
  ) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(delay, function);
    };
  }
  
  // Throttle function calls
  static void Function() throttle(
    void Function() function,
    Duration duration,
  ) {
    bool isThrottled = false;
    return () {
      if (!isThrottled) {
        function();
        isThrottled = true;
        Timer(duration, () => isThrottled = false);
      }
    };
  }
  
  // Create gradient from colors
  static LinearGradient createGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }
  
  // Get contrast color (black or white)
  static Color getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? CupertinoColors.black : CupertinoColors.white;
  }
  
  // Check if dark mode
  static bool isDarkMode(BuildContext context) {
    return CupertinoTheme.of(context).brightness == Brightness.dark;
  }
  
  // Safe cast to type
  static T? safeCast<T>(dynamic value) {
    try {
      return value as T?;
    } catch (e) {
      return null;
    }
  }
  
  // Clamp value between min and max
  static T clamp<T extends num>(T value, T min, T max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
  
  // Check if list is not empty
  static bool isNotEmpty<T>(List<T>? list) {
    return list != null && list.isNotEmpty;
  }
  
  // Check if string is not empty
  static bool isNotEmptyString(String? str) {
    return str != null && str.isNotEmpty;
  }
  
  // Get file extension
  static String getFileExtension(String filename) {
    final index = filename.lastIndexOf('.');
    return index != -1 ? filename.substring(index + 1) : '';
  }
  
  // Remove file extension
  static String removeFileExtension(String filename) {
    final index = filename.lastIndexOf('.');
    return index != -1 ? filename.substring(0, index) : filename;
  }
  
  // Generate UUID v4
  static String generateUUID() {
    final random = Random();
    final bytes = List<int>.generate(16, (i) => random.nextInt(256));
    
    // Set version (4) and variant bits
    bytes[6] = (bytes[6] & 0x0F) | 0x40;
    bytes[8] = (bytes[8] & 0x3F) | 0x80;
    
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
  }
}