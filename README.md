# Log Engine

A powerful and flexible logging solution for Flutter applications. This module helps manage logging
based on environment configurations, with support for both production and debug modes. It provides
different log levels, caller context resolution, and an easy-to-use logging provider.
## Features

- Seamless integration with different environments (Production/Debug)
- Log levels: Debug, Info, Warning, Error
- Context-based logging
- Customizable context resolver
- Singleton log provider for efficient management
- Compatible with external crash reporting tools (like Sentry)

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  log_engine:
    path: path/to/log_engine
```
Then Initialize the Logger based on your environment before anything:
```dart
  @singleton
  Logger logger() => Logger(AppConfigsEnvironmentProvider());
```
## Usage

```dart
Logger.info("Application started.")
Logger.debug("Debug message", tag: "MainScreen");
Logger.warn("Potential issue detected");
Logger.error("An error occurred", error: Exception("Test error"));

```

## Log Levels

* Debug: Detailed information for debugging purposes.
* Info: General application information.
* Warning: Situations that might cause potential problems.
* Error: Error events of considerable importance.

## Environment Configuration

Implement the EnvironmentProvider to determine the production mode:

```dart
  class AppConfigsEnvironmentProvider implements EnvironmentProvider {
   @override
   bool isProduction() => AppConfigs.appEnvironment == AppEnvironment.production;
}
```

## Remote Logging with Sentry

To enable remote logging using Sentry, make sure to initialize the SentryLogger:

```dart

final sentryLogger = SentryLogger();
sentryLogger.init();
```
### `IRemoteLogger`

An abstract interface for logging errors:

```dart
abstract interface class IRemoteLogger {
   Future<void> log(dynamic exception, dynamic stackTrace);
}
```

### `RemoteLoggerService`

A service class that utilizes an `IRemoteLogger` implementation to log errors:

```dart
class RemoteLoggerService {
   RemoteLoggerService({IRemoteLogger? remoteLogger})
           : _remoteLogger = remoteLogger ?? SentryLogger() {
      _init();
   }

   final IRemoteLogger _remoteLogger;

   Future<void> _init() async {
      if (_remoteLogger is SentryLogger) {
         await _remoteLogger.init();
      }
   }

   Future<void> log(dynamic exception, dynamic stackTrace) async {
      await _remoteLogger.log(exception, stackTrace);
   }
}
```

### `SentryLogger`

An implementation of `IRemoteLogger` that uses `sentry_flutter` for remote logging:

```dart
import 'package:remote_logger/src/remote_logger_interface.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLogger implements IRemoteLogger {
   Future<void> init() async {
      await SentryFlutter.init((options) {
         options.dsn = 'YOUR_DSN_HERE';
         options.tracesSampleRate = 1.0;
         options.profilesSampleRate = 1.0;
      });
   }

   @override
   Future<void> log(exception, stackTrace) async {
      await Sentry.captureException(
         exception,
         stackTrace: stackTrace,
      );
   }
}
```

Make sure to set your DSN in `SentryLogger` before running the project to ensure proper error
reporting.

## Caller Context Resolution

To get more context in logs, the CallerContextResolver can be customized:

```dart
CallerContextResolverFactory.instance.setCustomImplementation(MyCustomCallerContextResolver(),);
```

To reset to the default implementation:

```dart
CallerContextResolverFactory.instance.resetToDefault();
```
