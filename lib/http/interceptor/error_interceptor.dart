import 'package:dio/dio.dart';
import 'package:music/utils/log_utils.dart';

import '../app_except.dart';

///错误处理拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // error统一处理
    AppException appException = AppException.create(err);
    // 错误提示
    LogE('DioError===: ${appException.toString()}');
    var newError = err.copyWith(error: appException);
    super.onError(newError, handler);
  }
}
