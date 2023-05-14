import 'package:http/http.dart' as http;

import '../enums/hs_response_status.dart';

class Response {
  ResponseStatus status;
  http.Response? response;

  Response({required this.status, this.response});
}
