import 'package:flutter/cupertino.dart';
import 'package:music/res/colors.dart';

///自定义进度条
class ProgressPaint extends CustomPainter {
  int progress;
  int maxValue;
  var progressPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;

  ProgressPaint(this.progress, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    //切除方角
    // var clipPath = Path();
    var rRect =
        RRect.fromLTRBR(0, 0, width, height, Radius.circular(height / 2));
    // clipPath.addRRect(rRect);
    // canvas.clipPath(clipPath);
    //绘制背景条
    progressPaint.color = ColorStyle.color_999999;
    canvas.drawRRect(rRect, progressPaint);
    //绘制前景条
    if (maxValue == 0) {
      return;
    }
    var progressRatio = progress / maxValue;
    var rRectProgress = RRect.fromLTRBR(
        0, 0, width * progressRatio, height, Radius.circular(height / 2));
    progressPaint.color = ColorStyle.color_EA4C43;
    canvas.drawRRect(rRectProgress, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
