import 'package:common/constants/config.dart';
import 'package:dio/dio.dart';

/// @date on 2021/6/8 17:44
/// @author jack
/// @filename log_interceptor.dart
/// @description 网络请求日志拦截器

class LogInterceptors extends InterceptorsWrapper {
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AppHelper.isDebug) {
      print('Request url: ${options.uri}');
      print('Request header: ${options.headers.toString()}');
      if (options.data != null) {
        print('Request params: ${options.data.toString()}');
      }
      print('\r\n');
      handler.next(options);
    }
  }

  onResponse(Response response, ResponseInterceptorHandler handler) {
    if (AppHelper.isDebug) {
      print('Response: ${response.toString()}');
      print('\r\n');
      handler.next(response);
    }
  }

  onError(DioError error, ErrorInterceptorHandler handler) {
    if (AppHelper.isDebug) {
      print('request error: ${error.toString()}');
      print('request error info: ${error.response?.toString() ?? ""}');
      handler.next(error);
    }
  }
}
