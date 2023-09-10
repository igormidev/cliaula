// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:cliaula/infra/interfaces/api_source.dart';

// class HttpApiSourceImpl implements IApiSource {
//   @override
//   final String baseUrl = 'https://www.jsonplaceholder.typicode.com';

//   @override
//   Future<T> get<T>({
//     required String url,
//     Map<String, dynamic>? queryParams,
//     Map<String, String>? headers,
//   }) async {
//     final uri = Uri.parse(baseUrl + url);
//     final response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       final jsonAsMap = jsonDecode(response.body) as Map<String, dynamic>;
//       return jsonAsMap;
//     } else {
//       throw UnimplementedError();
//     }
//   }

//   @override
//   Future<void> delete({
//     required String url,
//     Map<String, String>? headers,
//   }) async {
//     final uri = Uri.http(baseUrl, url);
//     final response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       return;
//     } else {
//       throw UnimplementedError();
//     }
//   }

//   @override
//   Future<List<Map<String, dynamic>>> getList({
//     required String url,
//     Map<String, dynamic>? queryParams,
//     Map<String, String>? headers,
//   }) {
//     // TODO: implement getList
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> post({
//     required String url,
//     required Map<String, dynamic> payload,
//     Map<String, String>? headers,
//   }) {
//     // TODO: implement post
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> put({
//     required String url,
//     required Map<String, dynamic> payload,
//     Map<String, String>? headers,
//   }) {
//     // TODO: implement put
//     throw UnimplementedError();
//   }
// }
