class ErrorCodeAndMessage {
  final String? code;
  final String message;

  ErrorCodeAndMessage({
    required this.code,
    required this.message,
  });

  factory ErrorCodeAndMessage.fromJson(
    dynamic obj, {
    String? code,
  }) {
    if (obj['error'] != null && obj['error'] is Map<String, dynamic>) {
      return ErrorCodeAndMessage(
        code: obj['error']['code'].toString(),
        message: obj['error']['message'],
      );
    }

    if (obj['errors'] != null && obj['errors'] is Map<String, dynamic>) {
      String message = '';

      try {
        (obj['errors'] as Map<String, dynamic>).forEach((key, value) {
          for (final e in value) {
            if (message.isEmpty) {
              message += '\n';
            }

            message += '$e';
          }
        });
      } catch (_) {}

      return ErrorCodeAndMessage(
        code: code,
        message: message,
      );
    }

    return ErrorCodeAndMessage(
      code: (obj['code'] ?? code).toString(),
      message: obj['message'] ??
          obj['data']?['message'] ??
          _handleMessage(obj['data']),
    );
  }
}

String? _handleMessage(dynamic json) {
  if (json == null || json['message'] == null) return null;

  if (json['message'] is String) {
    return json['message'];
  }

  if (json['message'] is List) {
    return json['message'][0];
  }

  return null;
}
