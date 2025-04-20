import 'package:log_engine/src/log_priority.dart';

abstract interface class IRemoteLogger {
  void log(LogPriority priority, String message, {String? tag, Object? error});
}
