import 'dart:convert';

import 'package:http/http.dart' as http;

import '_src_exp.dart';

Future<String> getFullURL(
  final String url,
  Map<String, String>? params,
) async {
  String fullURL = url;

  params ??= <String, String>{};

  if (params.isNotEmpty) {
    if (!fullURL.contains('?')) {
      fullURL += '?';
    }

    params.forEach((key, value) {
      if (fullURL[fullURL.length - 1] != '?') {
        fullURL += '&';
      }
      fullURL += '$key=$value';
    });
  }

  return fullURL;
}

/// This method will parse [modelWithFromJson] or [ErrorCodeAndMessage] from [response].
/// [response] is the API's returned data.
/// [modelWithFromJson] is the class what you want back if the [response] is success.
/// [ErrorCodeAndMessage] will be returned if the [response] is fail.
/// Note: class [modelWithFromJson] must have 'fromJson' method.
Future<dynamic> parseAPIResponse<T, D>({
  required Future<Response> response,
  required T Function(Map<dynamic, dynamic>) fromJson,
  required String defaultErrorMessage,
  bool? checkDefaultStatusCode,
  bool? returnTrueForSuccess,
  Function(T)? onSuccess,
  Function(ErrorCodeAndMessage)? onFailure,
}) async {
  final res = await response;

  final statusCode = res.response?.statusCode.toString();

  if (res.status == ResponseStatus.unknownException ||
      res.status == ResponseStatus.connectionError ||
      res.status == ResponseStatus.timeout) {
    final error = ErrorCodeAndMessage(
      code: statusCode,
      message: res.status == ResponseStatus.connectionError
          ? 'No Internet Connection!'
          : res.status == ResponseStatus.timeout
              ? 'Connection timeout!'
              : 'Unknown Exception!',
    );

    onFailure?.call(error);

    return error;
  }

  try {
    final map = jsonDecode(res.response!.body);

    final code =
        checkDefaultStatusCode == true ? statusCode : map['code']?.toString();

    if (code == '200') {
      if (returnTrueForSuccess == true) {
        return true;
      }

      final successResponse = fromJson(map);

      if (onSuccess != null) {
        onSuccess(successResponse);
      }

      return successResponse;
    } else {
      final errorResponse = ErrorCodeAndMessage.fromJson(
        map,
        code: statusCode,
      );

      if (onFailure != null) {
        onFailure(errorResponse);
      }

      return errorResponse;
    }
  } catch (error) {
    printDebugLogFail(
      tag: 'parseAPIResponse',
      message: error.toString(),
    );

    final errorResponse = ErrorCodeAndMessage(
      code: statusCode,
      message: '$defaultErrorMessage\n$error',
    );

    if (onFailure != null) {
      onFailure(errorResponse);
    }

    return errorResponse;
  }
}

Future<bool> checkInternetConnection() async {
  try {
    final response = await http.get(Uri.parse('https://www.google.com'));
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
}

dynamic getPrettyJSONString(res) {
  try {
    dynamic data;

    if (res is String) {
      data = jsonDecode(res);
    } else {
      data;
    }

    var encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(data);
  } catch (_) {
    return res;
  }
}
