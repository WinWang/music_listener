import 'package:music/utils/log_utils.dart';

class TimeUtils {
  //时间转换 将秒转换为小时分钟
  static String durationTransform(int seconds) {
    var d = Duration(seconds: seconds);
    LogD(">>>>>>>${d.toString()}");
    var replaceAll = d.toString().replaceAll(".000000", "");
    List<String> parts = replaceAll.split(':');
    return '${parts[1]}:${parts[2]}';
  }
}
