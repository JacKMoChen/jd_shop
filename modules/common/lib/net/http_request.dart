import 'package:common/net/sign_util.dart';
import 'package:dio/dio.dart';
import '../constants/config.dart';
import 'interceptors/log_interceptor.dart';

/// @date on 2021/6/8 16:58
/// @author jack
/// @filename http_request.dart
/// @description 网络请求库封装

class HttpRequest {
  // 工厂模式
  HttpRequest._() {
    if (AppHelper.isDebug) {
      // 全局拦截器
      // 创建默认的全局拦截器
      dio.interceptors.add(LogInterceptors());
    }
  }

  static final _instance = HttpRequest._();

  factory HttpRequest.getInstance() => _instance;

  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpConfig.BASEURL, connectTimeout: HttpConfig.TIMEOUT);

  static final Dio dio = Dio(baseOptions);

  Future<T> request<T>(String url,
      {String method = "get",
      Map<String, dynamic>? params, //get参数
      Interceptor? inter,
      Map<String, dynamic>? data //post请求参数
      }) async {
    // 1.创建单独配置
    final options = Options(method: method);
    // 2.发送网络请求
    try {
      Response response = await dio.request(url,
          queryParameters: params, options: options, data: data);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}

final HttpRequest http = HttpRequest.getInstance();
