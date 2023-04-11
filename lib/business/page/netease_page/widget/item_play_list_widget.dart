import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music/base/pageWidget/common_stateless_widget.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/res/colors.dart';
import 'package:music/widget/base_network_image.dart';

// ignore: must_be_immutable
class ItemPlayListWidget extends CommonStatelessWidget {
  Play itemData;

  ItemPlayListWidget(this.itemData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.w,
      child: Column(
        children: [
          BaseNetworkImage(
            itemData.coverImgUrl ?? "",
            height: 240.w,
          ),
          Text(
            itemData.name ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                color: themeController.isDarkMode.value ? ColorStyle.color_CCCCCC : ColorStyle.color_666666,
                fontSize: 26.sp),
          )
        ],
      ),
    );
  }
}
