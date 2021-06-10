class HttpConfig {
  static const String BASEURL = "http://jd.itying.com/";
  static const int TIMEOUT = 5000;
}

class HomeConfig {
  static const int movieCount = 20;
}

class AppHelper {
  ///用于判断是否是module独立运行
  static bool isModuleRun = false;

  ///是否是生成环境
  static final bool isDebug = !bool.fromEnvironment('dart.vm.product');
}
