import 'dart:math' as math;

class Formatters {
  // Format bytes with units
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Format bytes with speed units
  static String formatSpeed(double bytesPerSecond) {
    return '${formatBytes(bytesPerSecond.round())}/s';
  }

  // Format duration for VPN timer
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Format duration in human readable format
  static String formatDurationHuman(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);

    if (days > 0) {
      if (hours > 0) {
        return '${days}d ${hours}h';
      }
      return '${days}d';
    } else if (hours > 0) {
      if (minutes > 0) {
        return '${hours}h ${minutes}m';
      }
      return '${hours}h';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  // Format percentage
  static String formatPercentage(double value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  // Format ping time
  static String formatPing(int pingMs) {
    if (pingMs == 0) return 'N/A';
    return '${pingMs}ms';
  }

  // Format server load
  static String formatServerLoad(double load) {
    final percentage = (load * 100).round();
    if (percentage < 50) return 'Low ($percentage%)';
    if (percentage < 80) return 'Medium ($percentage%)';
    return 'High ($percentage%)';
  }

  // Format price with currency
  static String formatPrice(double price, String currency) {
    if (price == 0) return 'Free';

    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$${price.toStringAsFixed(2)}';
      case 'EUR':
        return '€${price.toStringAsFixed(2)}';
      case 'GBP':
        return '£${price.toStringAsFixed(2)}';
      case 'JPY':
        return '¥${price.toStringAsFixed(0)}';
      default:
        return '${price.toStringAsFixed(2)} $currency';
    }
  }

  // Format subscription duration
  static String formatSubscriptionDuration(String type) {
    switch (type.toLowerCase()) {
      case 'monthly':
        return 'per month';
      case 'yearly':
        return 'per year';
      case 'lifetime':
        return 'one-time';
      default:
        return type;
    }
  }

  // Format date for display
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) {
      return 'Today';
    } else if (dateDay == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return _getWeekdayName(date.weekday);
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  // Format time for display
  static String formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Format date and time
  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} ${formatTime(dateTime)}';
  }

  // Format relative time (time ago)
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '${minutes}m ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '${hours}h ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '${days}d ago';
    } else {
      return formatDate(dateTime);
    }
  }

  // Format remaining time for subscription
  static String formatRemainingTime(DateTime expiryDate) {
    final now = DateTime.now();
    if (expiryDate.isBefore(now)) {
      return 'Expired';
    }

    final remaining = expiryDate.difference(now);

    if (remaining.inDays > 30) {
      final months = (remaining.inDays / 30).floor();
      return '${months} month${months == 1 ? '' : 's'} remaining';
    } else if (remaining.inDays > 0) {
      return '${remaining.inDays} day${remaining.inDays == 1 ? '' : 's'} remaining';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours} hour${remaining.inHours == 1 ? '' : 's'} remaining';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes} minute${remaining.inMinutes == 1 ? '' : 's'} remaining';
    } else {
      return 'Expires soon';
    }
  }

  // Format connection quality based on ping
  static String formatConnectionQuality(int ping) {
    if (ping == 0) return 'Unknown';
    if (ping < 50) return 'Excellent';
    if (ping < 100) return 'Good';
    if (ping < 200) return 'Fair';
    return 'Poor';
  }

  // Format protocol name
  static String formatProtocol(String protocol) {
    switch (protocol.toLowerCase()) {
      case 'vmess':
        return 'VMess';
      case 'vless':
        return 'VLESS';
      case 'trojan':
        return 'Trojan';
      case 'shadowsocks':
      case 'ss':
        return 'Shadowsocks';
      default:
        return protocol.toUpperCase();
    }
  }

  // Format server name
  static String formatServerName(String name, String country) {
    if (name.isEmpty) return country;
    if (name.toLowerCase().contains(country.toLowerCase())) {
      return name;
    }
    return '$name - $country';
  }

  // Format usage statistics
  static String formatUsageStats(int downloaded, int uploaded) {
    final total = downloaded + uploaded;
    if (total == 0) return 'No data';

    return '↓ ${formatBytes(downloaded)} ↑ ${formatBytes(uploaded)}';
  }

  // Format user count for server
  static String formatUserCount(int users, int maxUsers) {
    return '$users/$maxUsers users';
  }

  // Format device name
  static String formatDeviceName(String brand, String model) {
    if (brand.isEmpty && model.isEmpty) return 'Unknown Device';
    if (brand.isEmpty) return model;
    if (model.isEmpty) return brand;
    if (model.toLowerCase().contains(brand.toLowerCase())) {
      return model;
    }
    return '$brand $model';
  }

  // Format app version
  static String formatAppVersion(String version, String buildNumber) {
    return '$version ($buildNumber)';
  }

  // Format error message for user display
  static String formatErrorMessage(String error) {
    // Remove technical details and make user-friendly
    if (error.toLowerCase().contains('timeout')) {
      return 'Connection timeout. Please try again.';
    }
    if (error.toLowerCase().contains('network')) {
      return 'Network error. Check your internet connection.';
    }
    if (error.toLowerCase().contains('auth')) {
      return 'Authentication failed. Please check your credentials.';
    }
    if (error.toLowerCase().contains('server')) {
      return 'Server error. Please try again later.';
    }

    // Generic error message
    return 'An error occurred. Please try again.';
  }

  // Format file size
  static String formatFileSize(int sizeInBytes) {
    return formatBytes(sizeInBytes);
  }

  // Format distance
  static String formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()}m';
    } else if (distanceKm < 100) {
      return '${distanceKm.toStringAsFixed(1)}km';
    } else {
      return '${distanceKm.round()}km';
    }
  }

  // Format large numbers
  static String formatLargeNumber(int number) {
    if (number < 1000) return number.toString();
    if (number < 1000000) return '${(number / 1000).toStringAsFixed(1)}K';
    if (number < 1000000000) return '${(number / 1000000).toStringAsFixed(1)}M';
    return '${(number / 1000000000).toStringAsFixed(1)}B';
  }

  // Format session count
  static String formatSessionCount(int count) {
    if (count == 0) return 'No sessions';
    if (count == 1) return '1 session';
    return '$count sessions';
  }

  // Format trial period
  static String formatTrialPeriod(int days) {
    if (days == 0) return 'No trial';
    if (days == 1) return '1 day trial';
    if (days == 7) return '1 week trial';
    if (days == 14) return '2 weeks trial';
    if (days == 30) return '1 month trial';
    return '$days days trial';
  }

  // Helper method to get weekday name
  static String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }

  // Format credit card number (masked)
  static String formatCreditCard(String cardNumber) {
    if (cardNumber.length < 4) return cardNumber;
    final last4 = cardNumber.substring(cardNumber.length - 4);
    return '**** **** **** $last4';
  }

  // Format phone number
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }

    return phoneNumber; // Return original if format not recognized
  }

  // Format IP address with port
  static String formatServerAddress(String ip, int port) {
    return '$ip:$port';
  }

  // Format boolean as Yes/No
  static String formatBoolean(bool value) {
    return value ? 'Yes' : 'No';
  }

  // Format temperature
  static String formatTemperature(double celsius) {
    return '${celsius.round()}°C';
  }

  // Format battery level
  static String formatBatteryLevel(int percentage) {
    return '$percentage%';
  }
}
