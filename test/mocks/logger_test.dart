import 'package:log_engine/src/core/base_logger.dart';
import 'package:log_engine/src/core/environment_provider.dart';
import 'package:log_engine/src/remote_logger/remote_logger_interface.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([BaseLogger, EnvironmentProvider, IRemoteLogger])
void main() {}
