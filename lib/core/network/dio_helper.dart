import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/storage/secure_storage.dart';

class DioHelper {
  final Dio _dio;
  final SecureStorage _secureStorage;
  CancelToken _cancelToken = CancelToken();

  final StreamController<void> _refreshFailedController =
      StreamController<void>.broadcast();
  Stream<void> get refreshFailedStream => _refreshFailedController.stream;
  final StreamController<void> _refreshSucceededController =
      StreamController<void>.broadcast();
  Stream<void> get refreshSucceededStream => _refreshSucceededController.stream;

  bool _isRefreshing = false;
  final List<Completer<void>> _refreshCompleters = [];

  DioHelper(this._dio, this._secureStorage) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!isAuthEndPoint(options.path)) {
            final accessToken = await _secureStorage.getAccessToken();
            if (accessToken != null) {
              options.headers["Authorization"] = "Bearer $accessToken";
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 408 &&
              !isAuthEndPoint(error.requestOptions.path) &&
              !error.requestOptions.path.contains(ApiUrls.refresh)) {
            try {
              await _refreshAccessTokenSafely();
              final newAccessToken = await _secureStorage.getAccessToken();
              if (newAccessToken != null) {
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                dynamic requestData = error.requestOptions.data;

                // ✅ Rebuild FormData if needed
                if (requestData is FormData) {
                  final newFormData = FormData();

                  // Copy fields
                  for (var field in requestData.fields) {
                    newFormData.fields.add(MapEntry(field.key, field.value));
                  }

                  // Rebuild files
                  for (var entry in requestData.files) {
                    final MultipartFile originalFile = entry.value;

                    // NOTE: Recreate the file using fromFile if you have path,
                    // otherwise you must use fromBytes if you stored bytes.

                    // If originalFile was created from a file path
                    final String? filePath = originalFile.filename != null
                        ? (originalFile as dynamic).filePath as String?
                        : null;

                    if (filePath != null) {
                      final newFile = await MultipartFile.fromFile(
                        filePath,
                        filename: originalFile.filename,
                        contentType: originalFile.contentType,
                      );

                      newFormData.files.add(MapEntry(entry.key, newFile));
                    } else {
                      throw Exception(
                        "Cannot recreate MultipartFile for retry without file path.",
                      );
                    }
                  }

                  requestData = newFormData;
                }

                final response = await _dio.request(
                  error.requestOptions.path,
                  data: requestData,
                  queryParameters: error.requestOptions.queryParameters,
                  options: Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers,
                    contentType: error.requestOptions.contentType,
                  ),
                );
                return handler.resolve(response);
              } else {
                throw Exception('No access token after refresh');
              }
            } catch (refreshError) {
              log('❌ Token refresh failed: $refreshError');

              // Clear all tokens and cookies
              await _clearAllTokensAndCookies();

              // Notify that refresh failed (triggers redirect to login)
              _refreshFailedController.add(null);

              // Continue with original 401 error
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }

  /// Check if endpoint is auth-related
  bool isAuthEndPoint(String path) {
    final authEndpoints = [ApiUrls.refresh];
    return authEndpoints.any((endpoint) => path.contains(endpoint));
  }

  /// Safely refresh access token with concurrency control
  Future<void> _refreshAccessTokenSafely() async {
    if (_isRefreshing) {
      final completer = Completer<void>();
      _refreshCompleters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null) return;
      await _refreshAccessToken(refreshToken);

      // Complete all waiting requests
      for (final completer in _refreshCompleters) {
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
      _refreshCompleters.clear();
    } catch (e) {
      // Complete all waiting requests with error
      for (final completer in _refreshCompleters) {
        if (!completer.isCompleted) {
          completer.completeError(e);
        }
      }
      _refreshCompleters.clear();
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  /// Refresh access token using HTTP-only cookie
  Future<void> _refreshAccessToken(String refreshToken) async {
    try {
      log('🔄 Attempting to refresh access token...');

      final response = await _dio.post(
        ApiUrls.refresh,
        queryParameters: {'refreshToken': refreshToken},
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final String? accessToken =
            response.data['data']?['tokens']?['accessToken'];
        final String? refreshToken =
            response.data['data']?['tokens']?['refreshToken'];
        if (accessToken != null &&
            accessToken.isNotEmpty &&
            refreshToken != null &&
            refreshToken.isNotEmpty) {
          await _secureStorage.saveTokens(accessToken, refreshToken);
          _refreshSucceededController.add(null);
          log('✅ Access token refreshed successfully');
        } else {
          throw Exception('No access token in refresh response');
        }
      } else {
        throw Exception(
          'Refresh request failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('❌ Refresh token request failed: $e');
      rethrow;
    }
  }

  /// Clear all tokens
  Future<void> _clearAllTokensAndCookies() async {
    try {
      await _secureStorage.deleteTokens();

      log('🧹 All tokens cleared');
    } catch (e) {
      log('❌ Error clearing tokens: $e');
    }
  }

  /// Manual logout - clear everything
  Future<void> logout() async {
    try {
      // Optionally call logout endpoint
      await _dio.post(ApiUrls.logOut);
      log('✅ Logout API called successfully');
    } catch (e) {
      log('❌ Logout endpoint error: $e');
      // Continue with cleanup even if logout endpoint fails
    } finally {
      await _clearAllTokensAndCookies();
    }
  }

  /// ✅ GET Request
  Future<Response> get(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.get(
        endpoint,
        data: data,
        cancelToken: _cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// ✅ POST Request with Merged Headers
  Future<Response> post(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final mergedHeaders = {
      ..._dio.options.headers,
      if (headers != null) ...headers,
    };
    try {
      Response response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: mergedHeaders),
        cancelToken: _cancelToken,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// ✅ PATCH Request with Merged Headers
  Future<Response> patch(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final mergedHeaders = {
      ..._dio.options.headers,
      if (headers != null) ...headers,
    };

    try {
      Response response = await _dio.patch(
        endpoint,
        data: data,
        options: Options(headers: mergedHeaders),
        cancelToken: _cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// ✅ PUT Request
  Future<Response> put(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    final mergedHeaders = {
      ..._dio.options.headers,
      if (headers != null) ...headers,
    };
    try {
      Response response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: mergedHeaders),
        cancelToken: _cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// ✅ DELETE Request
  Future<Response> delete(String endpoint) async {
    try {
      Response response = await _dio.delete(
        endpoint,
        cancelToken: _cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// ✅ Cancel Requests
  void cancelRequests() {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel("Request cancelled");
      _cancelToken = CancelToken();
    }
  }

  void dispose() {
    _refreshSucceededController.close();
    _refreshFailedController.close();
    cancelRequests();
  }

  /// ❌ Error Handling
  dynamic _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw Failure.network('connection timeout error');
        case DioExceptionType.receiveTimeout:
          throw Failure.network('receive timeout error');
        case DioExceptionType.badResponse:
          if (error.response?.data is Map<String, dynamic>) {
            final Map<String, dynamic> responseData = error.response!.data;
            if (responseData.containsKey('message')) {
              throw Failure.server(responseData['message']);
            }
          }
          throw Failure.server(
            error.response?.data.toString() ?? 'Bad response',
          );
        case DioExceptionType.cancel:
          throw Failure.network('Request was cancelled');
        default:
          throw Failure.network('unknown error');
      }
    } else {
      throw Failure.network('unknown error');
    }
  }
}
