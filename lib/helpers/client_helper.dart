import 'package:http/http.dart' as http;
import 'package:sabak08/constants/app_urls.dart';

class ClientHelper {
  final client = http.Client();

  Future<http.Response> get(String endpoint) async {
    String url = AppUrls.baseUrl + endpoint;

    Uri uri = Uri.parse(url);

    final response = await client.get(uri);

    return _getResonse(response);

    // return client.get(uri).then((value) {
    //   return _getResonse(value);
    // });
  }

  Future<http.Response> post(
      String endpoint, Map<String, String> headers) async {
    String url = AppUrls.baseUrl + endpoint;

    Uri uri = Uri.parse(url);

    final response = await client.post(uri, headers: headers);
    return _getResonse(response);
  }

  http.Response _getResonse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      return null;
    }
  }
}

final ClientHelper clientHelper = ClientHelper();
