import 'dart:io';

class HttpHeaderTypes {
  static const applicationJson = 'application/json';
  static const multipartFormData = 'multipart/form-data';
  static const xAuthorization = 'x-authorization';
}

const defaultJsonHeaders = {
  HttpHeaders.contentTypeHeader: HttpHeaderTypes.applicationJson,
  HttpHeaders.acceptHeader: HttpHeaderTypes.applicationJson,
};

Map<String, String> jsonHeadersWithBearer(String token) => {
      HttpHeaders.contentTypeHeader: HttpHeaderTypes.applicationJson,
      HttpHeaders.acceptHeader: HttpHeaderTypes.applicationJson,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

const Duration defaultTimeoutDuration = Duration(seconds: 90);
