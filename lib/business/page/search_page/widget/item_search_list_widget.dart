import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/pageWidget/common_stateless_widget.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/res/colors.dart';
import 'package:music/res/style.dart';

// ignore: must_be_immutable
class ItemSearchListWidget extends CommonStatelessWidget {
  Song itemData;
  RxString playId;

  ItemSearchListWidget(this.itemData, this.playId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.only(top: 5.w, bottom: 5.w),
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 20.w, bottom: 20.w),
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemData.name ?? '',
                      style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? (itemData.id == playId.value ? ColorStyle.color_EA4C43 : ColorStyle.color_CCCCCC)
                              : (itemData.id == playId.value ? ColorStyle.color_EA4C43 : ColorStyle.color_333333),
                          fontSize: 28.sp),
                    ),
                    Box.hBox15,
                    Text(
                      "${itemData.artists?[0].name}  ${itemData.album?.name ?? ""}",
                      style: TextStyle(
                          color: themeController.isDarkMode.value
                              ? (itemData.id == playId.value ? ColorStyle.color_EA4C43 : ColorStyle.color_999999)
                              : (itemData.id == playId.value ? ColorStyle.color_EA4C43 : ColorStyle.color_777777),
                          fontSize: 24.sp),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
