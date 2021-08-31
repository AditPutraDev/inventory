import 'package:http/http.dart' as http;

const baseUrl = 'http://192.168.1.3/inventory_server/';

class Request {
  String? url;
  dynamic body;
  Map<String, String>? headers;

  Request({
    this.url,
    this.body,
    this.headers,
  });

  Future<http.Response> get() {
    return http.get(Uri.parse('$baseUrl$url'), headers: headers);
  }

  Future<http.Response> post() {
    return http.post(Uri.parse('$baseUrl$url'), body: body, headers: headers);
  }
}
