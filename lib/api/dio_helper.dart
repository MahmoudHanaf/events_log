// core/api/dio_helper.dart
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DioHelper {
  final Dio _dio;

  DioHelper({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(milliseconds: 6000),
              receiveTimeout: const Duration(milliseconds: 3000),
            ),
          );

  /// Check if there is an active internet connection
  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// Generic method to make HTTP requests with error and connection handling
  Future<T> request<T>({
    required String url,
    required String method, // e.g., GET, POST
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    if (!await _isConnected()) {
      throw Exception("No internet connection. Please check your network.");
    }

    try {
      Response response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options ?? Options(method: method),
      );
      return response.data;
    } on DioException catch (dioError) {
      throw _handleDioError(dioError);
    } catch (error) {
      throw Exception("An unexpected error occurred: $error");
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again later.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout. Please try again later.";
      case DioExceptionType.sendTimeout:
        return "Send timeout. Please try again later.";
      case DioExceptionType.badResponse:
        // Handle HTTP response errors
        return "Server error occurred. Please try again.";
      case DioExceptionType.connectionError:
        if (error.message!.contains("SocketException")) {
          return "No internet connection. Please check your network.";
        }
        return "No internet connection. Please check your network.";
      default:
        return "An unexpected error occurred. Please try again.";
    }
  }
}
