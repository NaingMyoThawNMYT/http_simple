import 'dart:convert';

import 'package:flutter/material.dart';

import 'enums/hs_response_status.dart';
import 'log_simple.dart';
import 'models/error_code_and_message.dart';
import 'models/hs_response.dart';

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
  ValueChanged<T>? onSuccess,
  ValueChanged<ErrorCodeAndMessage>? onFailure,
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