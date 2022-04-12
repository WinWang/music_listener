import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/component/music_component/music_player_component.dart';
import 'package:music/res/r.dart';
import 'package:music/res/style.dart';
import 'package:music/widget/base_network_image.dart';

class MusicDetailPage extends BaseStatelessWidget<MusicDetailController> {
  const MusicDetailPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => Stack(
          children: [
            BaseNetworkImage(
              controller.musicController.playCoverUrl.value,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            BackdropFilter(
              // 过滤器
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              //必须设置一个空容器
              child: Container(),
            ),
            Column(
              children: [
                Container(
                  height: MediaQueryData.fromWindow(window).padding.top,
                  color: Colors.transparent,
                ),
                _createTitleView(),
                _createMiddlerContent(),
                _createBottomControlView(),
                Box.hBox30
              ],
            )
          ],
        ));
  }

  ///顶部状态拦标题
  Widget _createTitleView() {
    return Container(
      height: 100.w,
      alignment: Alignment.center,
      child: Padding(
        child: Row(
          children: [
            GestureDetector(
              child: Image.asset(
                R.white_arrow_down_icon,
                height: 65.w,
                width: 65.w,
              ),
              onTap: () {
                Get.back();
              },
            ),

            Expanded(
                child: Text(
              controller.musicController.musicTitle.value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 32.sp),
            )),

            // Icon(icon)
          ],
        ),
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
      ),
    );
  }

  ///构建中间播放动画
  Widget _createMiddlerContent() {
    return Expanded(
        child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 140.w),
              width: double.infinity,
              child: RotationTransition(
                turns: controller.rotateController
                  ..addStatusListener((status) {
                    if (controller.musicController.playingStatus.value &&
                        status == AnimationStatus.completed) {
                      controller.rotateController.reset();
                      controller.rotateController.forward();
                    }
                  }),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      R.music_back,
                      width: 600.w,
                      height: 600.w,
                    ),
                    ClipOval(
                      child: BaseNetworkImage(
                        controller.musicController.playCoverUrl.value,
                        width: 300.w,
                        height: 300.w,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(left: 150.w),
              child: Transform.rotate(
                angle: pi /
                    180 *
                    (controller.musicController.playingStatus.value ? 0 : -20),
                origin: Offset(-76.w, -141.w),
                child: Image.asset(
                  R.music_point,
                  width: 240.w,
                  height: 370.w,
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }

  /// 构建地步控制栏--控制按钮
  Widget _createBottomControlView() {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            child: Image.asset(
              R.icon_white_once,
              width: 70.w,
              height: 70.w,
            ),
            onTap: () {},
          )),
          Expanded(
              child: GestureDetector(
            child: Image.asset(
              R.icon_white_more,
              width: 70.w,
              height: 70.w,
            ),
            onTap: () {},
          )),
          Expanded(

              ///控制播放暂停按钮
              child: GestureDetector(
            child: Image.asset(
              controller.musicController.playingStatus.value
                  ? R.icon_white_pause
                  : R.icon_white_play,
              width: 90.w,
              height: 90.w,
            ),
            onTap: () async {
              await controller.musicController.playMusic();
              if (!controller.musicController.playingStatus.value) {
                controller.rotateController.stop();
              } else {
                controller.rotateController.forward();
              }
            },
          )),
          Expanded(
              child: GestureDetector(
            child: Image.asset(
              R.icon_white_more,
              width: 70.w,
              height: 70.w,
            ),
            onTap: () {},
          )),
          Expanded(
              child: GestureDetector(
            child: Image.asset(
              R.icon_white_more,
              width: 70.w,
              height: 70.w,
            ),
            onTap: () {},
          )),
        ],
      ),
      height: 100.w,
    );
  }

  /// 构建地步控制栏--拖动条
  Widget _createBottomSeekView() {
    return SizedBox(
      height: 100.w,
      child: Row(
        children: [],
      ),
    );
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showTitleBar() => false;
}

class MusicDetailController extends BaseController
    with GetSingleTickerProviderStateMixin {
  var musicController = Get.find<MusicPlayerController>();
  late AnimationController rotateController =
      AnimationController(vsync: this, duration: const Duration(seconds: 10));

  @override
  void loadNet() {}

  @override
  void onReady() {
    super.onReady();
    musicController.showMusicPlayer.value = false;
    if (musicController.playingStatus.value) {
      rotateController.forward();
    }
  }

  @override
  void onClose() {
    musicController.showMusicPlayer.value = true;
    rotateController.dispose();
    super.onClose();
  }
}

class MusicDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MusicDetailController());
  }
}
