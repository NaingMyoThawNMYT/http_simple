import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

const _ansiResetCode = '\x1B[0m';
const _ansiColorBlack = '\x1B[30m';
const _ansiColorRed = '\x1B[31m';
const _ansiColorGreen = '\x1B[32m';
const _ansiColorYellow = '\x1B[33m';
const _ansiColorBlue = '\x1B[34m';
const _ansiColorPurple = '\x1B[35m';
const _ansiColorCyan = '\x1B[36m';
const _ansiColorWhite = '\x1B[37m';

enum LogType {
  success(_ansiColorGreen),
  fail(_ansiColorRed);

  final String color;

  const LogType(this.color);

  static String buildLog({
    required final String message,
    required final LogType? logType,
  }) {
    if (logType == null) return message;

    late final String prefix;

    switch (logType) {
      case LogType.success:
        {
          prefix = LogType.success.color;
          break;
        }
      case LogType.fail:
        {
          prefix = LogType.fail.color;
          break;
        }
    }

    return prefix + message + _ansiResetCode;
  }
}

void printDebugLog({
  required final String tag,
  required final String message,
  LogType? logType,
}) {
  if (kReleaseMode) return;

  if (kIsWeb) {
    print('$tag: $message');
  } else {
    dev.log(LogType.buildLog(message: message, logType: logType), name: tag);
  }
}

void printDebugLogSuccess({
  required final String tag,
  required final String message,
}) {
  printDebugLog(
    tag: tag,
    message: message,
    logType: LogType.success,
  );
}

void printDebugLogFail({
  required final String tag,
  required final String message,
}) {
  printDebugLog(
    tag: tag,
    message: message,
    logType: LogType.fail,
  );
}
