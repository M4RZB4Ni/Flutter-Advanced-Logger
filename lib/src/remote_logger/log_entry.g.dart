// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogEntry _$LogEntryFromJson(Map<String, dynamic> json) => LogEntry(
      timestamp: json['timestamp'] as String,
      level: json['level'] as String,
      message: json['message'] as String,
      device: DeviceInfo.fromJson(json['device'] as Map<String, dynamic>),
      appVersion: json['appVersion'] as String,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$LogEntryToJson(LogEntry instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'level': instance.level,
      'message': instance.message,
      'device': instance.device,
      'appVersion': instance.appVersion,
      'userId': instance.userId,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      model: json['model'] as String,
      os: json['os'] as String,
      connectionType: json['connectionType'] as String,
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'model': instance.model,
      'os': instance.os,
      'connectionType': instance.connectionType,
    };
