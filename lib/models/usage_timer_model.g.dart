// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_timer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsageTimerModelAdapter extends TypeAdapter<UsageTimerModel> {
  @override
  final int typeId = 50;

  @override
  UsageTimerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsageTimerModel(
      userId: fields[0] as String,
      totalUsedTime: fields[1] as Duration,
      dailyLimit: fields[2] as Duration,
      remainingTime: fields[3] as Duration,
      lastResetAt: fields[4] as DateTime,
      currentSessionStartedAt: fields[5] as DateTime?,
      currentSessionDuration: fields[6] as Duration,
      isTimerActive: fields[7] as bool,
      isPremiumUser: fields[8] as bool,
      sessions: (fields[9] as List).cast<UsageSessionModel>(),
      status: fields[10] as TimerStatus,
      limitExceededAt: fields[11] as DateTime?,
      warningNotificationsSent: fields[12] as int,
      lastWarningAt: fields[13] as DateTime?,
      autoDisconnectEnabled: fields[14] as bool,
      warningThreshold: fields[15] as Duration,
      settings: (fields[16] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UsageTimerModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.totalUsedTime)
      ..writeByte(2)
      ..write(obj.dailyLimit)
      ..writeByte(3)
      ..write(obj.remainingTime)
      ..writeByte(4)
      ..write(obj.lastResetAt)
      ..writeByte(5)
      ..write(obj.currentSessionStartedAt)
      ..writeByte(6)
      ..write(obj.currentSessionDuration)
      ..writeByte(7)
      ..write(obj.isTimerActive)
      ..writeByte(8)
      ..write(obj.isPremiumUser)
      ..writeByte(9)
      ..write(obj.sessions)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.limitExceededAt)
      ..writeByte(12)
      ..write(obj.warningNotificationsSent)
      ..writeByte(13)
      ..write(obj.lastWarningAt)
      ..writeByte(14)
      ..write(obj.autoDisconnectEnabled)
      ..writeByte(15)
      ..write(obj.warningThreshold)
      ..writeByte(16)
      ..write(obj.settings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsageTimerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsageSessionModelAdapter extends TypeAdapter<UsageSessionModel> {
  @override
  final int typeId = 52;

  @override
  UsageSessionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsageSessionModel(
      startTime: fields[0] as DateTime,
      endTime: fields[1] as DateTime?,
      duration: fields[2] as Duration,
      isActive: fields[3] as bool,
      serverId: fields[4] as String?,
      serverName: fields[5] as String?,
      serverCountry: fields[6] as String?,
      protocol: fields[7] as String?,
      dataUsed: fields[8] as int?,
      endReason: fields[9] as SessionEndReason?,
      metadata: (fields[10] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UsageSessionModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.serverId)
      ..writeByte(5)
      ..write(obj.serverName)
      ..writeByte(6)
      ..write(obj.serverCountry)
      ..writeByte(7)
      ..write(obj.protocol)
      ..writeByte(8)
      ..write(obj.dataUsed)
      ..writeByte(9)
      ..write(obj.endReason)
      ..writeByte(10)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsageSessionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimerSettingsModelAdapter extends TypeAdapter<TimerSettingsModel> {
  @override
  final int typeId = 54;

  @override
  TimerSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerSettingsModel(
      autoDisconnectEnabled: fields[0] as bool,
      warningThreshold: fields[1] as Duration,
      showWarningNotifications: fields[2] as bool,
      persistTimerAcrossAppRestarts: fields[3] as bool,
      trackBackgroundUsage: fields[4] as bool,
      customDailyLimit: fields[5] as Duration,
      enableWeeklyLimits: fields[6] as bool,
      weeklyLimit: fields[7] as Duration,
      allowedDays: (fields[8] as List).cast<int>(),
      allowedStartTime: fields[9] as TimeOfDay?,
      allowedEndTime: fields[10] as TimeOfDay?,
      enableParentalControls: fields[11] as bool,
      advancedSettings: (fields[12] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, TimerSettingsModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.autoDisconnectEnabled)
      ..writeByte(1)
      ..write(obj.warningThreshold)
      ..writeByte(2)
      ..write(obj.showWarningNotifications)
      ..writeByte(3)
      ..write(obj.persistTimerAcrossAppRestarts)
      ..writeByte(4)
      ..write(obj.trackBackgroundUsage)
      ..writeByte(5)
      ..write(obj.customDailyLimit)
      ..writeByte(6)
      ..write(obj.enableWeeklyLimits)
      ..writeByte(7)
      ..write(obj.weeklyLimit)
      ..writeByte(8)
      ..write(obj.allowedDays)
      ..writeByte(9)
      ..write(obj.allowedStartTime)
      ..writeByte(10)
      ..write(obj.allowedEndTime)
      ..writeByte(11)
      ..write(obj.enableParentalControls)
      ..writeByte(12)
      ..write(obj.advancedSettings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 55;

  @override
  TimeOfDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeOfDay(
      hour: fields[0] as int,
      minute: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimerStatusAdapter extends TypeAdapter<TimerStatus> {
  @override
  final int typeId = 51;

  @override
  TimerStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TimerStatus.available;
      case 1:
        return TimerStatus.running;
      case 2:
        return TimerStatus.warning;
      case 3:
        return TimerStatus.limitReached;
      case 4:
        return TimerStatus.paused;
      case 5:
        return TimerStatus.unlimited;
      default:
        return TimerStatus.available;
    }
  }

  @override
  void write(BinaryWriter writer, TimerStatus obj) {
    switch (obj) {
      case TimerStatus.available:
        writer.writeByte(0);
        break;
      case TimerStatus.running:
        writer.writeByte(1);
        break;
      case TimerStatus.warning:
        writer.writeByte(2);
        break;
      case TimerStatus.limitReached:
        writer.writeByte(3);
        break;
      case TimerStatus.paused:
        writer.writeByte(4);
        break;
      case TimerStatus.unlimited:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SessionEndReasonAdapter extends TypeAdapter<SessionEndReason> {
  @override
  final int typeId = 53;

  @override
  SessionEndReason read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SessionEndReason.userDisconnected;
      case 1:
        return SessionEndReason.timeLimitReached;
      case 2:
        return SessionEndReason.connectionLost;
      case 3:
        return SessionEndReason.serverError;
      case 4:
        return SessionEndReason.appClosed;
      case 5:
        return SessionEndReason.networkChanged;
      default:
        return SessionEndReason.userDisconnected;
    }
  }

  @override
  void write(BinaryWriter writer, SessionEndReason obj) {
    switch (obj) {
      case SessionEndReason.userDisconnected:
        writer.writeByte(0);
        break;
      case SessionEndReason.timeLimitReached:
        writer.writeByte(1);
        break;
      case SessionEndReason.connectionLost:
        writer.writeByte(2);
        break;
      case SessionEndReason.serverError:
        writer.writeByte(3);
        break;
      case SessionEndReason.appClosed:
        writer.writeByte(4);
        break;
      case SessionEndReason.networkChanged:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionEndReasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsageTimerModel _$UsageTimerModelFromJson(Map<String, dynamic> json) =>
    UsageTimerModel(
      userId: json['userId'] as String,
      totalUsedTime: json['totalUsedTime'] == null
          ? Duration.zero
          : Duration(microseconds: (json['totalUsedTime'] as num).toInt()),
      dailyLimit: json['dailyLimit'] == null
          ? const Duration(hours: 1)
          : Duration(microseconds: (json['dailyLimit'] as num).toInt()),
      remainingTime: json['remainingTime'] == null
          ? const Duration(hours: 1)
          : Duration(microseconds: (json['remainingTime'] as num).toInt()),
      lastResetAt: DateTime.parse(json['lastResetAt'] as String),
      currentSessionStartedAt: json['currentSessionStartedAt'] == null
          ? null
          : DateTime.parse(json['currentSessionStartedAt'] as String),
      currentSessionDuration: json['currentSessionDuration'] == null
          ? Duration.zero
          : Duration(
              microseconds: (json['currentSessionDuration'] as num).toInt()),
      isTimerActive: json['isTimerActive'] as bool? ?? false,
      isPremiumUser: json['isPremiumUser'] as bool? ?? false,
      sessions: (json['sessions'] as List<dynamic>?)
              ?.map(
                  (e) => UsageSessionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$TimerStatusEnumMap, json['status']) ??
          TimerStatus.available,
      limitExceededAt: json['limitExceededAt'] == null
          ? null
          : DateTime.parse(json['limitExceededAt'] as String),
      warningNotificationsSent:
          (json['warningNotificationsSent'] as num?)?.toInt() ?? 0,
      lastWarningAt: json['lastWarningAt'] == null
          ? null
          : DateTime.parse(json['lastWarningAt'] as String),
      autoDisconnectEnabled: json['autoDisconnectEnabled'] as bool? ?? true,
      warningThreshold: json['warningThreshold'] == null
          ? const Duration(minutes: 10)
          : Duration(microseconds: (json['warningThreshold'] as num).toInt()),
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$UsageTimerModelToJson(UsageTimerModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'totalUsedTime': instance.totalUsedTime.inMicroseconds,
      'dailyLimit': instance.dailyLimit.inMicroseconds,
      'remainingTime': instance.remainingTime.inMicroseconds,
      'lastResetAt': instance.lastResetAt.toIso8601String(),
      'currentSessionStartedAt':
          instance.currentSessionStartedAt?.toIso8601String(),
      'currentSessionDuration': instance.currentSessionDuration.inMicroseconds,
      'isTimerActive': instance.isTimerActive,
      'isPremiumUser': instance.isPremiumUser,
      'sessions': instance.sessions,
      'status': _$TimerStatusEnumMap[instance.status]!,
      'limitExceededAt': instance.limitExceededAt?.toIso8601String(),
      'warningNotificationsSent': instance.warningNotificationsSent,
      'lastWarningAt': instance.lastWarningAt?.toIso8601String(),
      'autoDisconnectEnabled': instance.autoDisconnectEnabled,
      'warningThreshold': instance.warningThreshold.inMicroseconds,
      'settings': instance.settings,
    };

const _$TimerStatusEnumMap = {
  TimerStatus.available: 'available',
  TimerStatus.running: 'running',
  TimerStatus.warning: 'warning',
  TimerStatus.limitReached: 'limitReached',
  TimerStatus.paused: 'paused',
  TimerStatus.unlimited: 'unlimited',
};

UsageSessionModel _$UsageSessionModelFromJson(Map<String, dynamic> json) =>
    UsageSessionModel(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: json['duration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['duration'] as num).toInt()),
      isActive: json['isActive'] as bool? ?? false,
      serverId: json['serverId'] as String?,
      serverName: json['serverName'] as String?,
      serverCountry: json['serverCountry'] as String?,
      protocol: json['protocol'] as String?,
      dataUsed: (json['dataUsed'] as num?)?.toInt(),
      endReason:
          $enumDecodeNullable(_$SessionEndReasonEnumMap, json['endReason']),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$UsageSessionModelToJson(UsageSessionModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
      'isActive': instance.isActive,
      'serverId': instance.serverId,
      'serverName': instance.serverName,
      'serverCountry': instance.serverCountry,
      'protocol': instance.protocol,
      'dataUsed': instance.dataUsed,
      'endReason': _$SessionEndReasonEnumMap[instance.endReason],
      'metadata': instance.metadata,
    };

const _$SessionEndReasonEnumMap = {
  SessionEndReason.userDisconnected: 'userDisconnected',
  SessionEndReason.timeLimitReached: 'timeLimitReached',
  SessionEndReason.connectionLost: 'connectionLost',
  SessionEndReason.serverError: 'serverError',
  SessionEndReason.appClosed: 'appClosed',
  SessionEndReason.networkChanged: 'networkChanged',
};

TimerSettingsModel _$TimerSettingsModelFromJson(Map<String, dynamic> json) =>
    TimerSettingsModel(
      autoDisconnectEnabled: json['autoDisconnectEnabled'] as bool? ?? true,
      warningThreshold: json['warningThreshold'] == null
          ? const Duration(minutes: 10)
          : Duration(microseconds: (json['warningThreshold'] as num).toInt()),
      showWarningNotifications:
          json['showWarningNotifications'] as bool? ?? true,
      persistTimerAcrossAppRestarts:
          json['persistTimerAcrossAppRestarts'] as bool? ?? true,
      trackBackgroundUsage: json['trackBackgroundUsage'] as bool? ?? true,
      customDailyLimit: json['customDailyLimit'] == null
          ? const Duration(hours: 1)
          : Duration(microseconds: (json['customDailyLimit'] as num).toInt()),
      enableWeeklyLimits: json['enableWeeklyLimits'] as bool? ?? false,
      weeklyLimit: json['weeklyLimit'] == null
          ? const Duration(hours: 7)
          : Duration(microseconds: (json['weeklyLimit'] as num).toInt()),
      allowedDays: (json['allowedDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [1, 2, 3, 4, 5, 6, 7],
      allowedStartTime: json['allowedStartTime'] == null
          ? null
          : TimeOfDay.fromJson(
              json['allowedStartTime'] as Map<String, dynamic>),
      allowedEndTime: json['allowedEndTime'] == null
          ? null
          : TimeOfDay.fromJson(json['allowedEndTime'] as Map<String, dynamic>),
      enableParentalControls: json['enableParentalControls'] as bool? ?? false,
      advancedSettings:
          json['advancedSettings'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$TimerSettingsModelToJson(TimerSettingsModel instance) =>
    <String, dynamic>{
      'autoDisconnectEnabled': instance.autoDisconnectEnabled,
      'warningThreshold': instance.warningThreshold.inMicroseconds,
      'showWarningNotifications': instance.showWarningNotifications,
      'persistTimerAcrossAppRestarts': instance.persistTimerAcrossAppRestarts,
      'trackBackgroundUsage': instance.trackBackgroundUsage,
      'customDailyLimit': instance.customDailyLimit.inMicroseconds,
      'enableWeeklyLimits': instance.enableWeeklyLimits,
      'weeklyLimit': instance.weeklyLimit.inMicroseconds,
      'allowedDays': instance.allowedDays,
      'allowedStartTime': instance.allowedStartTime,
      'allowedEndTime': instance.allowedEndTime,
      'enableParentalControls': instance.enableParentalControls,
      'advancedSettings': instance.advancedSettings,
    };

TimeOfDay _$TimeOfDayFromJson(Map<String, dynamic> json) => TimeOfDay(
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
    );

Map<String, dynamic> _$TimeOfDayToJson(TimeOfDay instance) => <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
    };
