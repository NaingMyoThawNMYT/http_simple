library http_simple;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'consts.dart';
import 'enums/hs_response_status.dart';
import 'enums/http_methods.dart';
import 'log_simple.dart';
import 'models/attachment_file.dart';
import 'models/hs_response.dart';
import 'utils.dart';

Future<Response> get({
  final Function(Response)? onResponse,
  final VoidCallback? onTimeout,
  final VoidCallback? onNoInternet,
  required final String tag,
  required final String url,
  final Map<String, String> headers = defaultJsonHeaders,
  final Map<String, String>? params,
  final Duration timeoutDuration = defaultTimeoutDuration,
  bool needToPrintResponseLog = true,
}) async {
  final fullUrl = await getFullURL(url, params);
  http.Response response = http.Response('', 444);

  try {
    response = await http.get(Uri.parse(fullUrl), headers: headers).timeout(
      timeoutDuration,
      onTimeout: () {
        printDebugLogFail(
          tag: tag,
          message: '\nRequest URL: $fullUrl'
              '\nRequest Method: GET'
              '\nRequest Headers: $headers'
              '\nRequest Timeout: $timeoutDuration',
        );
        if (onTimeout != null) onTimeout();
        return response;
      },
    ).then((http.Response response) {
      final body = needToPrintResponseLog ? response.body : 'MIME Image';
      printDebugLogSuccess(
        tag: tag,
        message: '\nRequest URL: $fullUrl'
            '\nRequest Method: GET'
            '\nRequest Headers: $headers'
            '\nResponse Code: ${response.statusCode}'
            '\nResponse Body: $body',
      );

      return response;
    });

    if (response.statusCode == 444) {
      return Response(
        status: ResponseStatus.timeout,
      );
    } else {
      if (onResponse != null) {
        onResponse(Response(
          status: ResponseStatus.ok,
          response: response,
        ));
      }
      return Response(
        status: ResponseStatus.ok,
        response: response,
      );
    }
  } on SocketException catch (_) {
    if (onNoInternet != null) onNoInternet();
    return Response(status: ResponseStatus.connectionError);
  } catch (_) {
    return Response(status: ResponseStatus.unknownException);
  }
}

Future<Response> post({
  final Function(Response)? onResponse,
  final VoidCallback? onTimeout,
  final VoidCallback? onNoInternet,
  required final String tag,
  required final String url,
  final Map<String, String> headers = defaultJsonHeaders,
  final Map<String, String>? params,
  final dynamic body,
  final Duration timeoutDuration = defaultTimeoutDuration,
}) async {
  final fullUrl = await getFullURL(url, params);
  http.Response response = http.Response('', 444);

  try {
    response = await http
        .post(Uri.parse(fullUrl), headers: headers, body: body)
        .timeout(
      timeoutDuration,
      onTimeout: () {
        printDebugLogFail(
          tag: tag,
          message: '\nRequest URL: $fullUrl'
              '\nRequest Method: POST'
              '\nRequest Headers: $headers'
              '\nRequest Body: $body'
              '\nRequest Timeout: $timeoutDuration',
        );

        if (onTimeout != null) onTimeout();

        return response;
      },
    ).then((http.Response response) {
      printDebugLogSuccess(
        tag: tag,
        message: '\nRequest URL: $fullUrl'
            '\nRequest Method: POST'
            '\nRequest Headers: $headers'
            '\nRequest Body: $body'
            '\nResponse Code: ${response.statusCode}'
            '\nResponse Body: ${response.body}',
      );

      return response;
    });

    if (response.statusCode == 444) {
      return Response(
        status: ResponseStatus.timeout,
      );
    } else {
      if (onResponse != null) {
        onResponse(Response(
          status: ResponseStatus.ok,
          response: response,
        ));
      }
      return Response(
        status: ResponseStatus.ok,
        response: response,
      );
    }
  } on SocketException catch (_) {
    if (onNoInternet != null) onNoInternet();
    return Response(status: ResponseStatus.connectionError);
  } catch (_) {
    return Response(status: ResponseStatus.unknownException);
  }
}

Future<Response> put({
  final Function(Response)? onResponse,
  final VoidCallback? onTimeout,
  final VoidCallback? onNoInternet,
  required final String tag,
  required final String url,
  final Map<String, String> headers = defaultJsonHeaders,
  final dynamic body,
  final Map<String, String>? params,
  final Duration timeoutDuration = defaultTimeoutDuration,
}) async {
  final fullUrl = await getFullURL(url, params);
  http.Response response = http.Response('', 444);

  try {
    response = await http
        .put(Uri.parse(fullUrl), headers: headers, body: body)
        .timeout(
      timeoutDuration,
      onTimeout: () {
        printDebugLogFail(
          tag: tag,
          message: '\nRequest URL: $fullUrl'
              '\nRequest Method: PUT'
              '\nRequest Headers: $headers'
              '\nRequest Body: $body'
              '\nRequest Timeout: $timeoutDuration',
        );

        if (onTimeout != null) onTimeout();

        return response;
      },
    ).then((http.Response response) {
      printDebugLogSuccess(
        tag: tag,
        message: '\nRequest URL: $fullUrl'
            '\nRequest Method: PUT'
            '\nRequest Headers: $headers'
            '\nRequest Body: $body'
            '\nResponse Code: ${response.statusCode}'
            '\nResponse Body: ${response.body}',
      );

      return response;
    });
    if (response.statusCode == 444) {
      return Response(
        status: ResponseStatus.timeout,
      );
    } else {
      if (onResponse != null) {
        onResponse(Response(
          status: ResponseStatus.ok,
          response: response,
        ));
      }
      return Response(
        status: ResponseStatus.ok,
        response: response,
      );
    }
  } on SocketException catch (_) {
    if (onNoInternet != null) onNoInternet();
    return Response(status: ResponseStatus.connectionError);
  } catch (_) {
    return Response(status: ResponseStatus.unknownException);
  }
}

Future<Response> patch({
  final Function(Response)? onResponse,
  final VoidCallback? onTimeout,
  final VoidCallback? onNoInternet,
  required final String tag,
  required final String url,
  final Map<String, String> headers = defaultJsonHeaders,
  final dynamic body,
  final Map<String, String>? params,
  final Duration timeoutDuration = defaultTimeoutDuration,
}) async {
  final fullUrl = await getFullURL(url, params);
  http.Response response = http.Response('', 444);

  try {
    response = await http
        .patch(Uri.parse(fullUrl), headers: headers, body: body)
        .timeout(
      timeoutDuration,
      onTimeout: () {
        printDebugLogFail(
          tag: tag,
          message: '\nRequest URL: $fullUrl'
              '\nRequest Method: PATCH'
              '\nRequest Headers: $headers'
              '\nRequest Body: $body'
              '\nRequest Timeout: $timeoutDuration',
        );

        if (onTimeout != null) onTimeout();
        return response;
      },
    ).then((http.Response response) {
      printDebugLogSuccess(
        tag: tag,
        message: '\nRequest URL: $fullUrl'
            '\nRequest Method: PATCH'
            '\nRequest Headers: $headers'
            '\nRequest Body: $body'
            '\nResponse Code: ${response.statusCode}'
            '\nResponse Body: ${response.body}',
      );

      return response;
    });
    if (response.statusCode == 444) {
      return Response(
        status: ResponseStatus.timeout,
      );
    } else {
      if (onResponse != null) {
        onResponse(Response(
          status: ResponseStatus.ok,
          response: response,
        ));
      }
      return Response(
        status: ResponseStatus.ok,
        response: response,
      );
    }
  } on SocketException catch (_) {
    if (onNoInternet != null) onNoInternet();
    return Response(status: ResponseStatus.connectionError);
  } catch (_) {
    return Response(status: ResponseStatus.unknownException);
  }
}

Future<Response> delete({
  final Function(Response)? onResponse,
  final VoidCallback? onTimeout,
  final VoidCallback? onNoInternet,
  required final String tag,
  required final String url,
  final Map<String, String> headers = defaultJsonHeaders,
  final dynamic body,
  final Map<String, String>? params,
  final Duration timeoutDuration = defaultTimeoutDuration,
}) async {
  final fullUrl = await getFullURL(url, params);
  http.Response response = http.Response('', 444);

  try {
    response = await http
        .delete(
      Uri.parse(fullUrl),
      headers: headers,
      body: body,
    )
        .timeout(timeoutDuration, onTimeout: () {
      printDebugLogFail(
        tag: tag,
        message: '\nRequest URL: $fullUrl'
            '\nRequest Method: DELETE'
            '\nRequest Headers: $headers'
            '\nRequest Body: $body'
            '\nRequest Timeout: $timeoutDuration',
      );

      if (onTimeout != null) onTimeout();

      return response;
    }).then((http.Response response) {
      printDebugLogSuccess(
        tag: tag,
        message: '\nRequest URL: $fullUrl'
            '\nRequest Method: DELETE'
            '\nRequest Headers: $headers'
            '\nRequest Body: $body'
            '\nResponse Code: ${response.statusCode}'
            '\nResponse Body: ${response.body}',
      );

      return response;
    });
    if (response.statusCode == 444) {
      return Response(
        status: ResponseStatus.timeout,
      );
    } else {
      if (onResponse != null) {
        onResponse(Response(
          status: ResponseStatus.ok,
          response: response,
        ));
      }
      return Response(
        status: ResponseStatus.ok,
        response: response,
      );
    }
  } on SocketException catch (_) {
    if (onNoInternet != null) onNoInternet();
    return Response(status: ResponseStatus.connectionError);
  } catch (_) {
    return Response(status: ResponseStatus.unknownException);
  }
}

Future<Response> apiCallForFile({
  final Function(Response)? onResponse,
  final VoidCallback? onTimeout,
  final VoidCallback? onNoInternet,
  required final String tag,
  required final HttpMethods apiMethod,
  required final String url,
  final Map<String, String> headers = defaultJsonHeaders,
  final Map<String, dynamic>? body,
  final Map<String, String>? params,
  final Map<String, AttachmentFile>? keyAndfileMap,
  final List<String>? apiKeysForFiles,
  final List<AttachmentFile>? files,
  final Duration timeoutDuration = defaultTimeoutDuration,
  bool needToPrintResponseLog = true,
}) async {
  final fullUrl = await getFullURL(url, params);

  http.StreamedResponse response = http.StreamedResponse(
    const Stream.empty(),
    444,
  );

  final request = http.MultipartRequest(
    apiMethod.toString().split('.').last.toUpperCase(),
    Uri.parse(fullUrl),
  );

  request.headers.addAll(headers);

  if (body != null && body.isNotEmpty) {
    body.forEach((key, value) {
      request.fields[key] = (value ?? '').toString();
    });
  }

  if (keyAndfileMap != null && keyAndfileMap.isNotEmpty) {
    keyAndfileMap.forEach((key, value) {
      request.files.add(http.MultipartFile.fromBytes(
        key,
        value.data,
        filename: value.fileNameWithExtension,
      ));
    });
  } else if (files != null &&
      apiKeysForFiles != null &&
      files.length == apiKeysForFiles.length) {
    for (int i = 0, l = files.length; i < l; i++) {
      final file = files[i];
      final key = apiKeysForFiles[i];

      request.files.add(http.MultipartFile.fromBytes(
        key,
        file.data,
        filename: file.fileNameWithExtension,
      ));
    }
  }

  try {
    response = await request.send().timeout(
      timeoutDuration,
      onTimeout: () {
        printDebugLogFail(
          tag: tag,
          message: '\nRequest URL: $fullUrl'
              '\nRequest Method: ${apiMethod.toString().split('.').last.toUpperCase()}'
              '\nRequest Headers: $headers'
              '\nRequest Keys: ${keyAndfileMap?.entries.map((e) => e.key).toList()}'
              '\nRequest Body: $body'
              '\nRequest Timeout: $timeoutDuration',
        );

        if (onTimeout != null) onTimeout();

        return response;
      },
    );

    if (response.statusCode == 444) {
      return Response(status: ResponseStatus.timeout);
    } else {
      final res = await http.Response.fromStream(response);

      printDebugLogSuccess(
        tag: tag,
        // ignore: prefer_interpolation_to_compose_strings
        message: '\nRequest URL: $fullUrl'
                '\nRequest Method: ${apiMethod.toString().split('.').last.toUpperCase()}'
                '\nRequest Headers: $headers'
                '\nRequest Keys: ${keyAndfileMap?.values.map((AttachmentFile f) => f.path).toList()}'
                '\nRequest Body: $body'
                '\nResponse Code: ${res.statusCode}' +
            (needToPrintResponseLog
                ? '\nResponse Body: ${res.body}'
                : '\nResponse Body: <Data>'),
      );

      final finalRes = Response(
        status: ResponseStatus.ok,
        response: res,
      );

      if (onResponse != null) {
        onResponse(finalRes);
      }

      return finalRes;
    }
  } on SocketException catch (_) {
    if (onNoInternet != null) onNoInternet();
    return Response(status: ResponseStatus.connectionError);
  } catch (_) {
    return Response(status: ResponseStatus.unknownException);
  }
}