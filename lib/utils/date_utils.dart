class DateUtils {
  // Format date for display
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
    final seconds = duration.inSeconds.remainder(60);

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
      return '${seconds}s';
    }
  }

  // Format remaining time for subscription
  static String formatRemainingTime(DateTime expiryDate) {
    final now = DateTime.now();
    if (expiryDate.isBefore(now)) {
      return 'Expired';
    }

    final remaining = expiryDate.difference(now);

    if (remaining.inDays > 0) {
      return '${remaining.inDays} days remaining';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours} hours remaining';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes} minutes remaining';
    } else {
      return 'Expires soon';
    }
  }

  // Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  // Check if date is this week
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  // Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  // Get start of week (Monday)
  static DateTime startOfWeek(DateTime date) {
    final daysSinceMonday = date.weekday - 1;
    return startOfDay(date.subtract(Duration(days: daysSinceMonday)));
  }

  // Get end of week (Sunday)
  static DateTime endOfWeek(DateTime date) {
    final daysUntilSunday = 7 - date.weekday;
    return endOfDay(date.add(Duration(days: daysUntilSunday)));
  }

  // Get next reset time for daily timer (tomorrow at 00:00)
  static DateTime getNextDailyReset() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  }

  // Get time until next reset
  static Duration getTimeUntilReset() {
    return getNextDailyReset().difference(DateTime.now());
  }

  // Format relative time (e.g., "2 hours ago", "just now")
  static String getRelativeTime(DateTime dateTime) {
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
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  // Parse ISO string safely
  static DateTime? parseISOString(String? isoString) {
    if (isoString == null || isoString.isEmpty) return null;
    try {
      return DateTime.parse(isoString);
    } catch (e) {
      return null;
    }
  }

  // Check if subscription is expiring soon (within 7 days)
  static bool isExpiringSoon(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now);
    return difference.inDays <= 7 && difference.inDays > 0;
  }

  // Check if timer should reset (new day)
  static bool shouldResetTimer(DateTime lastResetDate) {
    final now = DateTime.now();
    final lastReset = startOfDay(lastResetDate);
    final today = startOfDay(now);

    return today.isAfter(lastReset);
  }

  // Get session duration between two times
  static Duration getSessionDuration(DateTime startTime, DateTime? endTime) {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  // Format connection time for display
  static String formatConnectionTime(DateTime connectedAt) {
    final duration = DateTime.now().difference(connectedAt);
    return formatDuration(duration);
  }

  // Get age of something (days since creation)
  static int getAgeInDays(DateTime createdAt) {
    return DateTime.now().difference(createdAt).inDays;
  }

  // Check if within time range (for parental controls)
  static bool isWithinTimeRange(
    DateTime time,
    DateTime startTime,
    DateTime endTime,
  ) {
    final timeOfDay = time.hour * 60 + time.minute;
    final startOfDay = startTime.hour * 60 + startTime.minute;
    final endOfDay = endTime.hour * 60 + endTime.minute;

    // Handle overnight ranges (e.g., 22:00 to 06:00)
    if (startOfDay > endOfDay) {
      return timeOfDay >= startOfDay || timeOfDay <= endOfDay;
    }

    return timeOfDay >= startOfDay && timeOfDay <= endOfDay;
  }

  // Get subscription renewal date
  static DateTime getSubscriptionRenewalDate(
    DateTime purchaseDate,
    String subscriptionType,
  ) {
    switch (subscriptionType.toLowerCase()) {
      case 'monthly':
        return DateTime(
          purchaseDate.year,
          purchaseDate.month + 1,
          purchaseDate.day,
          purchaseDate.hour,
          purchaseDate.minute,
          purchaseDate.second,
        );
      case 'yearly':
        return DateTime(
          purchaseDate.year + 1,
          purchaseDate.month,
          purchaseDate.day,
          purchaseDate.hour,
          purchaseDate.minute,
          purchaseDate.second,
        );
      default:
        return purchaseDate; // Lifetime or unknown
    }
  }

  // Check if it's a new user (registered less than 7 days ago)
  static bool isNewUser(DateTime registrationDate) {
    return getAgeInDays(registrationDate) < 7;
  }

  // Get Unix timestamp
  static int getUnixTimestamp([DateTime? dateTime]) {
    return (dateTime ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000;
  }

  // Convert Unix timestamp to DateTime
  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}
