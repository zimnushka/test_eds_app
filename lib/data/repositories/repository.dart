import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Repository {
  static const homeUrl = "https://jsonplaceholder.typicode.com/";
  static const int _countSecTimeOut = 10;
  static const String _timeOutMessage = "Ошибка подключения к серверу";

  Future<ResponseData> postRequest({
    required String url,
    required String parametrs,
    required Map<String, String> headers,
  }) async {
    try {
      http.Response response = await http
          .post(Uri.parse("$homeUrl$url"), headers: headers, body: parametrs)
          .timeout(const Duration(seconds: _countSecTimeOut));

      return ResponseData(
        data: utf8.decode(response.bodyBytes),
        status: response.statusCode,
      );
    } catch (e) {
      return const ResponseData(data: _timeOutMessage, status: 408);
    }
  }

  Future<ResponseData> getRequest(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      http.Response response = await http
          .get(Uri.parse("$homeUrl$url"), headers: headers)
          .timeout(const Duration(seconds: _countSecTimeOut));

      return ResponseData(
        data: utf8.decode(response.bodyBytes),
        status: response.statusCode,
      );
    } catch (e) {
      return const ResponseData(data: _timeOutMessage, status: 408);
    }
  }

  Future<ResponseData> putRequest({
    required String url,
    required String parametrs,
    required Map<String, String> headers,
  }) async {
    try {
      http.Response response = await http
          .put(Uri.parse("$homeUrl$url"), headers: headers, body: parametrs)
          .timeout(const Duration(seconds: _countSecTimeOut));

      return ResponseData(
        data: utf8.decode(response.bodyBytes),
        status: response.statusCode,
      );
    } catch (e) {
      return const ResponseData(data: _timeOutMessage, status: 408);
    }
  }

  Future<ResponseData> deleteRequest({
    required String url,
    required Map<String, String> headers,
  }) async {
    try {
      http.Response response = await http
          .delete(Uri.parse("$homeUrl$url"), headers: headers)
          .timeout(const Duration(seconds: _countSecTimeOut));

      return ResponseData(
        data: utf8.decode(response.bodyBytes),
        status: response.statusCode,
      );
    } catch (e) {
      return const ResponseData(data: _timeOutMessage, status: 408);
    }
  }
}

class ResponseData<T> {
  final T data;
  final int? status;
  final bool? isSuccesful;

  const ResponseData({required this.data, this.status, this.isSuccesful});
}
