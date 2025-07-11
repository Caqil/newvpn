import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usage_timer_model.g.dart';

@HiveType(typeId: 50)
@JsonSerializable()
class UsageTimerModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final Duration totalUsedTime;

  @HiveField(2)
  final Duration dailyLimit;

  @HiveField(3)
  final Duration remainingTime;

  @HiveField(4)
  final DateTime lastResetAt;

  @HiveField(5)
  final DateTime? currentSessionStartedAt;

  @HiveField(6)
  final Duration currentSessionDuration;

  @HiveField(7)
  final bool isTimerActive;

  @HiveField(8)
  final bool isPremiumUser;

  @HiveField(9)
  final List<UsageSessionModel> sessions;

  @HiveField(10)
  final TimerStatus status;

  @HiveField(11)
  final DateTime? limitExceededAt;

  @HiveField(12)
  final int warningNotificationsSent;

  @HiveField(13)
  final DateTime? lastWarningAt;

  @HiveField(14)
  final bool autoDisconnectEnabled;

  @HiveField(15)
  final Duration warningThreshold;

  @HiveField(16)
  final Map<String, dynamic> settings;

  const UsageTimerModel({
    required this.userId,
    this.totalUsedTime = Duration.zero,
    this.dailyLimit = const Duration(hours: 1),
    this.remainingTime = const Duration(hours: 1),
    required this.lastResetAt,
    this.currentSessionStartedAt,
    this.currentSessionDuration = Duration.zero,
    this.isTimerActive = false,
    this.isPremiumUser = false,
    this.sessions = const [],
    this.status = TimerStatus.available,
    this.limitExceededAt,
    this.warningNotificationsSent = 0,
    this.lastWarningAt,
    this.autoDisconnectEnabled = true,
    this.warningThreshold = const Duration(minutes: 10),
    this.settings = const {},
  });

  factory UsageTimerModel.fromJson(Map<String, dynamic> json) =>
      _$UsageTimerModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsageTimerModelToJson(this);

  UsageTimerModel copyWith({
    String? userId,
    Duration? totalUsedTime,
    Duration? dailyLimit,
    Duration? remainingTime,
    DateTime? lastResetAt,
    DateTime? currentSessionStartedAt,
    Duration? currentSessionDuration,
    bool? isTimerActive,
    bool? isPremiumUser,
    List<UsageSessionModel>? sessions,
    TimerStatus? status,
    DateTime? limitExceededAt,
    int? warningNotificationsSent,
    DateTime? lastWarningAt,
    bool? autoDisconnectEnabled,
    Duration? warningThreshold,
    Map<String, dynamic>? settings,
  }) {
    return UsageTimerModel(
      userId: userId ?? this.userId,
      totalUsedTime: totalUsedTime ?? this.totalUsedTime,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      remainingTime: remainingTime ?? this.remainingTime,
      lastResetAt: lastResetAt ?? this.lastResetAt,
      currentSessionStartedAt:
          currentSessionStartedAt ?? this.currentSessionStartedAt,
      currentSessionDuration:
          currentSessionDuration ?? this.currentSessionDuration,
      isTimerActive: isTimerActive ?? this.isTimerActive,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
      sessions: sessions ?? this.sessions,
      status: status ?? this.status,
      limitExceededAt: limitExceededAt ?? this.limitExceededAt,
      warningNotificationsSent:
          warningNotificationsSent ?? this.warningNotificationsSent,
      lastWarningAt: lastWarningAt ?? this.lastWarningAt,
      autoDisconnectEnabled:
          autoDisconnectEnabled ?? this.autoDisconnectEnabled,
      warningThreshold: warningThreshold ?? this.warningThreshold,
      settings: settings ?? this.settings,
    );
  }

  // Helper methods
  bool get hasUnlimitedTime => isPremiumUser;
  bool get isLimitReached =>
      !hasUnlimitedTime && remainingTime <= Duration.zero;
  bool get isNearLimit =>
      !hasUnlimitedTime && remainingTime <= warningThreshold;
  bool get needsReset => DateTime.now().difference(lastResetAt).inDays >= 1;

  Duration get actualRemainingTime {
    if (hasUnlimitedTime)
      return const Duration(days: 365); // Effectively unlimited
    if (isTimerActive && currentSessionStartedAt != null) {
      final currentUsage = DateTime.now().difference(currentSessionStartedAt!);
      final totalCurrentUsage = totalUsedTime + currentUsage;
      return dailyLimit - totalCurrentUsage;
    }
    return remainingTime;
  }

  Duration get currentSessionTime {
    if (!isTimerActive || currentSessionStartedAt == null) {
      return currentSessionDuration;
    }
    return currentSessionDuration +
        DateTime.now().difference(currentSessionStartedAt!);
  }

  double get usagePercentage {
    if (hasUnlimitedTime) return 0.0;
    return (totalUsedTime.inSeconds / dailyLimit.inSeconds) * 100;
  }

  String get formattedTotalUsedTime => _formatDuration(totalUsedTime);
  String get formattedRemainingTime => _formatDuration(actualRemainingTime);
  String get formattedCurrentSession => _formatDuration(currentSessionTime);
  String get formattedDailyLimit => _formatDuration(dailyLimit);

  String get statusText {
    switch (status) {
      case TimerStatus.available:
        return 'Available';
      case TimerStatus.running:
        return 'Running';
      case TimerStatus.warning:
        return 'Warning';
      case TimerStatus.limitReached:
        return 'Limit Reached';
      case TimerStatus.paused:
        return 'Paused';
      case TimerStatus.unlimited:
        return 'Unlimited';
    }
  }

  bool get shouldShowWarning =>
      !hasUnlimitedTime &&
      isNearLimit &&
      (lastWarningAt == null ||
          DateTime.now().difference(lastWarningAt!).inMinutes >= 5);

  bool get shouldAutoDisconnect =>
      autoDisconnectEnabled && isLimitReached && isTimerActive;

  DateTime get nextResetTime {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  }

  Duration get timeUntilReset => nextResetTime.difference(DateTime.now());

  // Session management
  UsageSessionModel? get currentSession {
    if (!isTimerActive || currentSessionStartedAt == null) return null;
    return UsageSessionModel(
      startTime: currentSessionStartedAt!,
      duration: currentSessionTime,
      isActive: true,
    );
  }

  List<UsageSessionModel> get todaySessions {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    return sessions
        .where(
          (session) =>
              session.startTime.isAfter(startOfDay) ||
              session.startTime.isAtSameMomentAs(startOfDay),
        )
        .toList();
  }

  List<UsageSessionModel> get thisWeekSessions {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekDay = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    return sessions
        .where((session) => session.startTime.isAfter(startOfWeekDay))
        .toList();
  }

  Duration get totalTimeToday {
    return todaySessions.fold<Duration>(
          Duration.zero,
          (total, session) => total + session.duration,
        ) +
        (isTimerActive ? currentSessionTime : Duration.zero);
  }

  Duration get totalTimeThisWeek {
    return thisWeekSessions.fold<Duration>(
      Duration.zero,
      (total, session) => total + session.duration,
    );
  }

  Duration get averageSessionDuration {
    if (sessions.isEmpty) return Duration.zero;
    final totalDuration = sessions.fold<Duration>(
      Duration.zero,
      (total, session) => total + session.duration,
    );
    return Duration(seconds: totalDuration.inSeconds ~/ sessions.length);
  }

  // Statistics
  Map<String, dynamic> get statistics => {
    'total_sessions': sessions.length,
    'total_time_used': totalUsedTime.inSeconds,
    'average_session_duration': averageSessionDuration.inSeconds,
    'usage_percentage': usagePercentage,
    'sessions_today': todaySessions.length,
    'time_today': totalTimeToday.inSeconds,
    'time_this_week': totalTimeThisWeek.inSeconds,
    'is_premium': isPremiumUser,
    'status': status.name,
    'days_since_last_reset': DateTime.now().difference(lastResetAt).inDays,
  };

  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  @override
  String toString() =>
      'UsageTimerModel(user: $userId, used: $formattedTotalUsedTime, remaining: $formattedRemainingTime, status: $status)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsageTimerModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          lastResetAt == other.lastResetAt;

  @override
  int get hashCode => userId.hashCode ^ lastResetAt.hashCode;
}

@HiveType(typeId: 51)
enum TimerStatus {
  @HiveField(0)
  available,
  @HiveField(1)
  running,
  @HiveField(2)
  warning,
  @HiveField(3)
  limitReached,
  @HiveField(4)
  paused,
  @HiveField(5)
  unlimited,
}

@HiveType(typeId: 52)
@JsonSerializable()
class UsageSessionModel {
  @HiveField(0)
  final DateTime startTime;

  @HiveField(1)
  final DateTime? endTime;

  @HiveField(2)
  final Duration duration;

  @HiveField(3)
  final bool isActive;

  @HiveField(4)
  final String? serverId;

  @HiveField(5)
  final String? serverName;

  @HiveField(6)
  final String? serverCountry;

  @HiveField(7)
  final String? protocol;

  @HiveField(8)
  final int? dataUsed;

  @HiveField(9)
  final SessionEndReason? endReason;

  @HiveField(10)
  final Map<String, dynamic> metadata;

  const UsageSessionModel({
    required this.startTime,
    this.endTime,
    this.duration = Duration.zero,
    this.isActive = false,
    this.serverId,
    this.serverName,
    this.serverCountry,
    this.protocol,
    this.dataUsed,
    this.endReason,
    this.metadata = const {},
  });

  factory UsageSessionModel.fromJson(Map<String, dynamic> json) =>
      _$UsageSessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsageSessionModelToJson(this);

  UsageSessionModel copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Duration? duration,
    bool? isActive,
    String? serverId,
    String? serverName,
    String? serverCountry,
    String? protocol,
    int? dataUsed,
    SessionEndReason? endReason,
    Map<String, dynamic>? metadata,
  }) {
    return UsageSessionModel(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
      serverId: serverId ?? this.serverId,
      serverName: serverName ?? this.serverName,
      serverCountry: serverCountry ?? this.serverCountry,
      protocol: protocol ?? this.protocol,
      dataUsed: dataUsed ?? this.dataUsed,
      endReason: endReason ?? this.endReason,
      metadata: metadata ?? this.metadata,
    );
  }

  // Helper methods
  Duration get actualDuration {
    if (isActive) {
      return DateTime.now().difference(startTime);
    }
    return duration;
  }

  String get formattedDuration => _formatDuration(actualDuration);
  String get formattedStartTime => _formatTime(startTime);
  String get formattedEndTime =>
      endTime != null ? _formatTime(endTime!) : 'Ongoing';

  String get displayServerInfo {
    if (serverName != null && serverCountry != null) {
      return '$serverName - $serverCountry';
    } else if (serverCountry != null) {
      return serverCountry!;
    } else if (serverName != null) {
      return serverName!;
    }
    return 'Unknown Server';
  }

  String get displayProtocol => protocol?.toUpperCase() ?? 'Unknown';

  String get formattedDataUsed {
    if (dataUsed == null) return 'N/A';
    return _formatBytes(dataUsed!.toDouble());
  }

  String get endReasonText {
    switch (endReason) {
      case SessionEndReason.userDisconnected:
        return 'User disconnected';
      case SessionEndReason.timeLimitReached:
        return 'Time limit reached';
      case SessionEndReason.connectionLost:
        return 'Connection lost';
      case SessionEndReason.serverError:
        return 'Server error';
      case SessionEndReason.appClosed:
        return 'App closed';
      case SessionEndReason.networkChanged:
        return 'Network changed';
      case null:
        return isActive ? 'Active' : 'Unknown';
    }
  }

  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final sessionDay = DateTime(startTime.year, startTime.month, startTime.day);
    return sessionDay.isAtSameMomentAs(today);
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return startTime.isAfter(startOfWeek);
  }

  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  static String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
      'UsageSessionModel(start: $formattedStartTime, duration: $formattedDuration, server: $displayServerInfo)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsageSessionModel &&
          runtimeType == other.runtimeType &&
          startTime == other.startTime &&
          serverId == other.serverId;

  @override
  int get hashCode => startTime.hashCode ^ serverId.hashCode;
}

@HiveType(typeId: 53)
enum SessionEndReason {
  @HiveField(0)
  userDisconnected,
  @HiveField(1)
  timeLimitReached,
  @HiveField(2)
  connectionLost,
  @HiveField(3)
  serverError,
  @HiveField(4)
  appClosed,
  @HiveField(5)
  networkChanged,
}

@HiveType(typeId: 54)
@JsonSerializable()
class TimerSettingsModel {
  @HiveField(0)
  final bool autoDisconnectEnabled;

  @HiveField(1)
  final Duration warningThreshold;

  @HiveField(2)
  final bool showWarningNotifications;

  @HiveField(3)
  final bool persistTimerAcrossAppRestarts;

  @HiveField(4)
  final bool trackBackgroundUsage;

  @HiveField(5)
  final Duration customDailyLimit;

  @HiveField(6)
  final bool enableWeeklyLimits;

  @HiveField(7)
  final Duration weeklyLimit;

  @HiveField(8)
  final List<int> allowedDays;

  @HiveField(9)
  final TimeOfDay? allowedStartTime;

  @HiveField(10)
  final TimeOfDay? allowedEndTime;

  @HiveField(11)
  final bool enableParentalControls;

  @HiveField(12)
  final Map<String, dynamic> advancedSettings;

  const TimerSettingsModel({
    this.autoDisconnectEnabled = true,
    this.warningThreshold = const Duration(minutes: 10),
    this.showWarningNotifications = true,
    this.persistTimerAcrossAppRestarts = true,
    this.trackBackgroundUsage = true,
    this.customDailyLimit = const Duration(hours: 1),
    this.enableWeeklyLimits = false,
    this.weeklyLimit = const Duration(hours: 7),
    this.allowedDays = const [1, 2, 3, 4, 5, 6, 7], // All days
    this.allowedStartTime,
    this.allowedEndTime,
    this.enableParentalControls = false,
    this.advancedSettings = const {},
  });

  factory TimerSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$TimerSettingsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TimerSettingsModelToJson(this);

  TimerSettingsModel copyWith({
    bool? autoDisconnectEnabled,
    Duration? warningThreshold,
    bool? showWarningNotifications,
    bool? persistTimerAcrossAppRestarts,
    bool? trackBackgroundUsage,
    Duration? customDailyLimit,
    bool? enableWeeklyLimits,
    Duration? weeklyLimit,
    List<int>? allowedDays,
    TimeOfDay? allowedStartTime,
    TimeOfDay? allowedEndTime,
    bool? enableParentalControls,
    Map<String, dynamic>? advancedSettings,
  }) {
    return TimerSettingsModel(
      autoDisconnectEnabled:
          autoDisconnectEnabled ?? this.autoDisconnectEnabled,
      warningThreshold: warningThreshold ?? this.warningThreshold,
      showWarningNotifications:
          showWarningNotifications ?? this.showWarningNotifications,
      persistTimerAcrossAppRestarts:
          persistTimerAcrossAppRestarts ?? this.persistTimerAcrossAppRestarts,
      trackBackgroundUsage: trackBackgroundUsage ?? this.trackBackgroundUsage,
      customDailyLimit: customDailyLimit ?? this.customDailyLimit,
      enableWeeklyLimits: enableWeeklyLimits ?? this.enableWeeklyLimits,
      weeklyLimit: weeklyLimit ?? this.weeklyLimit,
      allowedDays: allowedDays ?? this.allowedDays,
      allowedStartTime: allowedStartTime ?? this.allowedStartTime,
      allowedEndTime: allowedEndTime ?? this.allowedEndTime,
      enableParentalControls:
          enableParentalControls ?? this.enableParentalControls,
      advancedSettings: advancedSettings ?? this.advancedSettings,
    );
  }

  // Helper methods
  bool get hasTimeRestrictions =>
      allowedStartTime != null && allowedEndTime != null;
  bool get hasWeeklyLimits => enableWeeklyLimits;

  bool isCurrentTimeAllowed() {
    if (!hasTimeRestrictions) return true;

    final now = TimeOfDay.now();
    final start = allowedStartTime!;
    final end = allowedEndTime!;

    // Handle overnight time ranges (e.g., 22:00 to 06:00)
    if (start.hour > end.hour ||
        (start.hour == end.hour && start.minute > end.minute)) {
      return _timeInRange(now, start, const TimeOfDay(hour: 23, minute: 59)) ||
          _timeInRange(now, const TimeOfDay(hour: 0, minute: 0), end);
    }

    return _timeInRange(now, start, end);
  }

  bool isCurrentDayAllowed() {
    final today = DateTime.now().weekday;
    return allowedDays.contains(today);
  }

  bool get isUsageAllowedNow => isCurrentTimeAllowed() && isCurrentDayAllowed();

  static bool _timeInRange(TimeOfDay time, TimeOfDay start, TimeOfDay end) {
    final timeMinutes = time.hour * 60 + time.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    return timeMinutes >= startMinutes && timeMinutes <= endMinutes;
  }

  @override
  String toString() =>
      'TimerSettingsModel(autoDisconnect: $autoDisconnectEnabled, dailyLimit: $customDailyLimit)';
}

// Simple TimeOfDay class for cross-platform compatibility
@HiveType(typeId: 55)
@JsonSerializable()
class TimeOfDay {
  @HiveField(0)
  final int hour;

  @HiveField(1)
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  factory TimeOfDay.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayFromJson(json);
  Map<String, dynamic> toJson() => _$TimeOfDayToJson(this);

  @override
  String toString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
