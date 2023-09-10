import 'dart:developer';

import 'package:cliaula/core/exceptions/custom_exception.dart';
import 'package:cliaula/core/exceptions/failures/api_failures.dart';
import 'package:cliaula/core/extensions/dartz_extensions.dart';
import 'package:cliaula/infra/interfaces/api_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiSourceImpl implements IApiSource {
  final Dio dio;
  const DioApiSourceImpl(
    this.dio,
  );

  @override
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  void makeInitialConfigs() {
    dio.interceptors.add(PrettyDioLogger());
  }

  @override
  AsyncResp<T> get<T>({
    required String url,
    required T Function(Map<String, dynamic> map) fromMapFunc,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    return _requestWrapper(() async {
      final response = await dio.get(
        baseUrl + url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      );
      try {
        final map = response.data as Map<String, dynamic>;

        try {
          return fromMapFunc(map).toRight();
        } catch (error, stackTrace) {
          return ApiFailureCastingObject(
            error: error,
            stackTrace: stackTrace,
            response: response,
          ).toLeft();
        }
      } catch (error, stackTrace) {
        return ApiFailureInvalidResponse(
          code: response.statusCode.toString(),
          error: error,
          stackTrace: stackTrace,
          response: response,
        ).toLeft();
      }
    });
  }

  @override
  AsyncResp<List<T>> getList<T>({
    required String url,
    required T Function(Map<String, dynamic> map) fromMapFunc,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    return _requestWrapper(() async {
      final response = await dio.get(
        baseUrl + url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      );

      try {
        final res = response.data as List<dynamic>;
        final List<Map<String, dynamic>> castedMaps =
            res.cast<Map<String, dynamic>>();

        try {
          final List<T> itens = [];

          for (final map in castedMaps) {
            itens.add(fromMapFunc(map));
          }

          return itens.toRight();
        } catch (error, stackTrace) {
          return ApiFailureCastingObject(
            error: error,
            stackTrace: stackTrace,
            response: response,
          ).toLeft();
        }
      } catch (error, stackTrace) {
        return ApiFailureInvalidResponse(
          code: response.statusCode.toString(),
          error: error,
          stackTrace: stackTrace,
          response: response,
        ).toLeft();
      }
    });
  }

  @override
  AsyncResp<void> post({
    required String url,
    required Map<String, dynamic> payload,
    Map<String, dynamic>? headers,
  }) {
    return _requestWrapper(() async {
      await dio.post(
        baseUrl + url,
        data: payload,
        options: Options(
          headers: headers,
        ),
      );

      return right(null);
    });
  }

  @override
  AsyncResp<void> put({
    required String url,
    required Map<String, dynamic> payload,
    Map<String, dynamic>? headers,
  }) {
    return _requestWrapper(() async {
      await dio.put(
        baseUrl + url,
        data: payload,
        options: Options(
          headers: headers,
        ),
      );

      return right(null);
    });
  }

  @override
  AsyncResp<void> delete({
    required String url,
    Map<String, dynamic>? headers,
  }) {
    return _requestWrapper(() async {
      await dio.delete(
        baseUrl + url,
        options: Options(
          headers: headers,
        ),
      );

      return right(null);
    });
  }

  AsyncResp<T> _requestWrapper<T>(
    AsyncResp<T> Function() function,
  ) async {
    try {
      return function();
    } on DioException catch (error, stackTrace) {
      final statusCode = error.response?.statusCode;

      if (statusCode == 401) {
        return ApiFailureUnauthenticated(
          code: '${error.response?.statusCode}',
          error: error,
          stackTrace: stackTrace,
        ).toLeft();
      }

      if (statusCode == 403) {
        return ApiFailureUnautorized(
          code: '${error.response?.statusCode}',
          error: error,
          stackTrace: stackTrace,
        ).toLeft();
      }

      if (statusCode == 404) {
        return ApiFailureObjectNotFound(
          code: '${error.response?.statusCode}',
          error: error,
          stackTrace: stackTrace,
        ).toLeft();
      }

      if (statusCode != null && statusCode >= 500 && statusCode < 600) {
        return ApiFailureInternalError(
          code: '${error.response?.statusCode}',
          error: error,
          stackTrace: stackTrace,
        ).toLeft();
      }

      return ApiFailureUnknownFailure(
        code: '${error.response?.statusCode}',
        error: error,
        stackTrace: stackTrace,
      ).toLeft();
    } catch (error, stackTrace) {
      return UnknownError(
        error: error,
        stackTrace: stackTrace,
      ).toLeft();
    }
  }
}
