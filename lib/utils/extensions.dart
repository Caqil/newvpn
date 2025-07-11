import 'package:flutter/cupertino.dart';

// String Extensions
extension StringExtensions on String {
  // Check if string is empty or null
  bool get isNullOrEmpty => isEmpty;

  // Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  // Capitalize each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  // Check if email is valid
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  // Check if URL is valid
  bool get isValidUrl {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  // Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  // Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  // Check if string contains only numbers
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  // Convert to integer safely
  int? get toIntOrNull {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }

  // Convert to double safely
  double? get toDoubleOrNull {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }

  // Check if string is a valid config URL
  bool get isValidConfigUrl {
    return startsWith('vmess://') ||
        startsWith('vless://') ||
        startsWith('trojan://') ||
        startsWith('ss://');
  }

  // Extract protocol from config URL
  String get extractProtocol {
    if (startsWith('vmess://')) return 'vmess';
    if (startsWith('vless://')) return 'vless';
    if (startsWith('trojan://')) return 'trojan';
    if (startsWith('ss://')) return 'shadowsocks';
    return 'unknown';
  }

  // Mask sensitive data (for logging)
  String get masked {
    if (length <= 8) return '*' * length;
    return '${substring(0, 4)}${'*' * (length - 8)}${substring(length - 4)}';
  }
}

// Nullable String Extensions
extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String get orEmpty => this ?? '';
  String orDefault(String defaultValue) => this ?? defaultValue;
}

// DateTime Extensions
extension DateTimeExtensions on DateTime {
  // Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  // Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  // Get start of day
  DateTime get startOfDay => DateTime(year, month, day);

  // Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  // Format as time string
  String get timeString {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Format as date string
  String get dateString {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }

  // Time ago string
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return dateString;
    }
  }

  // Check if time is within range
  bool isWithinRange(DateTime start, DateTime end) {
    return isAfter(start) && isBefore(end);
  }
}

// Duration Extensions
extension DurationExtensions on Duration {
  // Format duration for timer display
  String get timerFormat {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Human readable format
  String get humanReadable {
    if (inDays > 0) {
      final hours = inHours.remainder(24);
      return hours > 0 ? '${inDays}d ${hours}h' : '${inDays}d';
    } else if (inHours > 0) {
      final minutes = inMinutes.remainder(60);
      return minutes > 0 ? '${inHours}h ${minutes}m' : '${inHours}h';
    } else if (inMinutes > 0) {
      return '${inMinutes}m';
    } else {
      return '${inSeconds}s';
    }
  }

  // Check if duration is zero
  bool get isZero => inMicroseconds == 0;

  // Check if duration is positive
  bool get isPositive => inMicroseconds > 0;

  // Check if duration is negative
  bool get isNegative => inMicroseconds < 0;
}

// BuildContext Extensions
extension BuildContextExtensions on BuildContext {
  // Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  // Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  // Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  // Check if screen is small
  bool get isSmallScreen => screenWidth < 600;

  // Check if screen is large
  bool get isLargeScreen => screenWidth >= 1024;

  // Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  // Get keyboard height
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  // Check if keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;

  // Get text scale factor
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  // Get device pixel ratio
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  // Show Cupertino dialog
  Future<T?> showCupertinoDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showCupertinoModalPopup<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }

  // Show Cupertino action sheet
  Future<T?> showCupertinoActionSheet<T>({
    required List<Widget> actions,
    Widget? cancelButton,
    Widget? title,
    Widget? message,
  }) {
    return showCupertinoModalPopup<T>(
      context: this,
      builder: (context) => CupertinoActionSheet(
        title: title,
        message: message,
        actions: actions,
        cancelButton: cancelButton,
      ),
    );
  }
}

// List Extensions
extension ListExtensions<T> on List<T> {
  // Get first element or null
  T? get firstOrNull => isEmpty ? null : first;

  // Get last element or null
  T? get lastOrNull => isEmpty ? null : last;

  // Get element at index or null
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  // Partition list into chunks
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size).clamp(0, length)));
    }
    return chunks;
  }

  // Remove duplicates
  List<T> get unique => {...this}.toList();

  // Check if list is not empty
  bool get isNotEmpty => !isEmpty;
}

// Map Extensions
extension MapExtensions<K, V> on Map<K, V> {
  // Get value or default
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  // Check if map is not empty
  bool get isNotEmpty => !isEmpty;

  // Update value if key exists
  void updateIfExists(K key, V Function(V) update) {
    if (containsKey(key)) {
      this[key] = update(this[key] as V);
    }
  }
}

// Double Extensions
extension DoubleExtensions on double {
  // Format bytes
  String get formatBytes {
    if (this < 1024) return '${toStringAsFixed(0)} B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024)
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Format speed
  String get formatSpeed => '${formatBytes}/s';

  // Format percentage
  String get formatPercentage => '${toStringAsFixed(1)}%';

  // Clamp to percentage range
  double get asPercentage => clamp(0.0, 100.0) as double;

  // Check if number is within range
  bool isInRange(double min, double max) => this >= min && this <= max;
}

// Int Extensions
extension IntExtensions on int {
  // Format as bytes
  String get formatBytes => toDouble().formatBytes;

  // Format as duration
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);

  // Check if number is positive
  bool get isPositive => this > 0;

  // Check if number is negative
  bool get isNegative => this < 0;

  // Check if number is zero
  bool get isZero => this == 0;

  // Clamp to range
  int clampTo(int min, int max) => clamp(min, max) as int;
}

// Color Extensions
extension ColorExtensions on Color {
  // Get contrasting color (black or white)
  Color get contrastingColor {
    final luminance = computeLuminance();
    return luminance > 0.5 ? CupertinoColors.black : CupertinoColors.white;
  }

  // Darken color
  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  // Lighten color
  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  // Add opacity
  Color withOpacity(double opacity) {
    return Color.fromRGBO(red, green, blue, opacity.clamp(0.0, 1.0));
  }
}
