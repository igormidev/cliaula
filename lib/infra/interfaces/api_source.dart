// Imagine uma classe abtrata como um "contrato"
import 'package:cliaula/core/exceptions/custom_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IApiSource {
  abstract final String baseUrl;

  /// Obtem um objeto do banco de dados
  AsyncResp<T> get<T>({
    required String url,
    required T Function(Map<String, dynamic> map) fromMapFunc,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  });

  /// Obtem uma lista de mapas do banco de dados
  AsyncResp<List<T>> getList<T>({
    required String url,
    required T Function(Map<String, dynamic> map) fromMapFunc,
    Map<String, dynamic> queryParams,
    Map<String, String> headers,
  });

  /// Posta um objeto no banco de dados
  AsyncResp<void> post({
    required String url,
    required Map<String, dynamic> payload,
    Map<String, String> headers,
  });

  /// Atualiza um objeto
  AsyncResp<void> put({
    required String url,
    required Map<String, dynamic> payload,
    Map<String, String> headers,
  });

  /// Deleta um objeto do banco de dados
  AsyncResp<void> delete({
    required String url,
    Map<String, String> headers,
  });
}
