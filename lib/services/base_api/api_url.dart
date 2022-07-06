import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {
  fetchImageData() async {
    var client = http.Client();
    Map<String, String> requestHeaders = {'content-type': 'application/json'};
    Uri url =  Uri.http('jsonplaceholder.typicode.com', '/photos');
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      JsonDecoder _decoder =  JsonDecoder();

      return _decoder.convert(response.body);
    }
  }
}
