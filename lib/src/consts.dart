class HttpHeaderTypes {
  static const applicationJson = 'application/json';
  static const multipartFormData = 'multipart/form-data';
  static const xAuthorization = 'x-authorization';
}

const defaultJsonHeaders = {
  'content-type': HttpHeaderTypes.applicationJson,
  'accept': HttpHeaderTypes.applicationJson,
};

Map<String, String> jsonHeadersWithBearer(String token) => {
      'content-type': HttpHeaderTypes.applicationJson,
      'accept': HttpHeaderTypes.applicationJson,
      'authorization': 'Bearer $token',
    };

const Duration defaultTimeoutDuration = Duration(seconds: 90);
