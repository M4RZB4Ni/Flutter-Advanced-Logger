/// Enum for log priority levels
enum LogPriority {
  /// Debug priority
  debug(1),

  /// Info priority
  info(2),

  /// Warning priority
  warn(3),

  /// Error priority
  error(4);

  /// Constructor
  const LogPriority(this.value);

  /// Priority value.
  ///
  /// This value is an integer representing the priority of the log level.
  /// Higher values indicate higher priority.
  final int value;
}
