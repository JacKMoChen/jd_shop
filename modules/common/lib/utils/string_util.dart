class StringUtil {
  //判断字符串是否为空
  static bool isEmpty(String? s) {
    if (s == null) {
      return true;
    }
    return s.isEmpty;
  }

  //判断字符串非空
  static bool isNotEmpty(String? s) {
    if (s == null) {
      return false;
    }
    return s.isNotEmpty;
  }
}
