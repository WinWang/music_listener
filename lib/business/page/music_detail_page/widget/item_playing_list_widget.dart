import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/pageWidget/common_stateful_widget.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/res/colors.dart';
import 'package:music/res/r.dart';
import 'package:music/res/style.dart';
import 'package:music/widget/base_network_image.dart';

// ignore: must_be_immutable
class ItemPlayingListWidget extends CommonStatefulWidget {
  MyRecord itemData;
  RxString playId;

  ItemPlayingListWidget(this.itemData, this.playId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ItemPlayingListWidgetState();
  }
}

class ItemPlayingListWidgetState extends State<ItemPlayingListWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(left: 15.w, right: 30.w),
          // color: ColorStyle.color_EA4C43,
          height: 100.w,
          width: double.infinity,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    child: RotationTransition(
                        turns: _controller
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              _controller.reset();
                              _controller.forward();
                            }
                          }),
                        child: Image.asset(
                          R.red_playing_icon,
                          width: 80.w,
                          height: 80.w,
                        )),
                    visible: widget.itemData.id == widget.playId.value,
                  )
                ],
              ),
              Box.wBox15,
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemData.name ?? "",
                    style: TextStyle(
                        color: widget.themeController.isDarkMode.value
                            ? (widget.itemData.id == widget.playId.value
                                ? ColorStyle.color_EA4C43
                                : ColorStyle.color_CCCCCC)
                            : (widget.itemData.id == widget.playId.value
                                ? ColorStyle.color_EA4C43
                                : ColorStyle.color_333333),
                        fontSize: 28.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Box.hBox5,
                  Text(
                    widget.itemData.al_name ?? "",
                    style: TextStyle(
                        color: widget.themeController.isDarkMode.value
                            ? (widget.itemData.id == widget.playId.value
                                ? ColorStyle.color_EA4C43
                                : ColorStyle.color_999999)
                            : (widget.itemData.id == widget.playId.value
                                ? ColorStyle.color_EA4C43
                                : ColorStyle.color_999999),
                        fontSize: 24.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
              GestureDetector(
                child: SizedBox(
                  height: 120.w,
                  width: 38.w,
                  child: Image.asset(
                    R.black_more_icon,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
