import 'package:json_annotation/json_annotation.dart';

part 'log_entry.g.dart';

@JsonSerializable()
class LogEntry {
  LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
    required this.device,
    required this.appVersion,
    this.userId,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) => _$LogEntryFromJson(json);
  final String timestamp;
  final String level;
  final String message;
  final DeviceInfo device;
  final String appVersion;
  final String? userId;

  Map<String, dynamic> toJson() => _$LogEntryToJson(this);
}

@JsonSerializable()
class DeviceInfo {
  DeviceInfo({
    required this.model,
    required this.os,
    required this.connectionType,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);
  final String model;
  final String os;
  final String connectionType;

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
