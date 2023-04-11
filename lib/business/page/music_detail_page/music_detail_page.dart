import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/component/music_component/music_player_component.dart';
import 'package:music/business/page/music_detail_page/widget/play_list_dialog.dart';
import 'package:music/res/colors.dart';
import 'package:music/res/r.dart';
import 'package:music/res/style.dart';
import 'package:music/utils/date_utils.dart';
import 'package:music/utils/log_utils.dart';
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
            Container(
              color: controller.themeController.isDarkMode.value ? ColorStyle.color_3A3A3B_90 : ColorStyle.color_E2E3E8_66,
              width: double.infinity,
              height: double.infinity,
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
                _createBottomSeekView(),
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
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  R.white_arrow_down_icon,
                  height: 45.w,
                  width: 45.w,
                ),
                width: 65.w,
                height: 65.w,
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

            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  R.icon_white_share,
                  height: 45.w,
                  width: 45.w,
                ),
                width: 65.w,
                height: 65.w,
              ),
              onTap: () {
                Get.back();
              },
            ),

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
                    if (controller.musicController.playingStatus.value && status == AnimationStatus.completed) {
                      controller.rotateController.repeat();
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
                        fit: BoxFit.cover,
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
                angle: pi / 180 * (controller.musicController.playingStatus.value ? 0 : -20),
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
              R.icon_white_previous,
              width: 70.w,
              height: 70.w,
            ),
            onTap: () {},
          )),
          Expanded(

              ///控制播放暂停按钮
              child: GestureDetector(
            child: Image.asset(
              controller.musicController.playingStatus.value ? R.icon_white_pause : R.icon_white_play,
              width: 90.w,
              height: 90.w,
            ),
            onTap: () async {
              if (controller.musicController.playingStatus.value) {
                LogD("msg》》》》》》暂停");
                controller.rotateController.stop();
              } else {
                LogD("msg》》》》》》播放");
                controller.rotateController.repeat();
                controller.rotateController.forward();
              }
              await controller.musicController.playMusic();
            },
          )),
          Expanded(
              child: GestureDetector(
            child: Image.asset(
              R.icon_white_next,
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
            onTap: () {
              showPlayListDialog();
            },
          )),
        ],
      ),
      height: 100.w,
    );
  }

  /// 构建地步控制栏--拖动条
  Widget _createBottomSeekView() {
    return Container(
      padding: EdgeInsets.only(left: 32.w, right: 32.w),
      height: 100.w,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 80.w,
            child: Text(
              TimeUtils.durationTransform(controller.musicController.currentPosition.value),
              style: TextStyle(fontSize: 26.sp, color: ColorStyle.color_white),
            ),
          ),
          Expanded(
              child: Slider(
            thumbColor: ColorStyle.color_white,
            inactiveColor: ColorStyle.color_white,
            activeColor: ColorStyle.color_white,
            value: controller.musicController.currentPosition.toDouble(),
            max: controller.musicController.audioLenght.toDouble(),
            onChanged: (value) {
              controller.musicController.setSeekPosition(value);
            },
          )),
          Container(
            alignment: Alignment.center,
            width: 80.w,
            child: Text(
              TimeUtils.durationTransform(controller.musicController.audioLenght.value),
              style: TextStyle(fontSize: 26.sp, color: ColorStyle.color_white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showTitleBar() => false;

  void showPlayListDialog() {
    Get.bottomSheet(PlayListDialog());
  }
}

class MusicDetailController extends BaseController with GetSingleTickerProviderStateMixin {
  var musicController = Get.find<MusicPlayerController>();
  late AnimationController rotateController = AnimationController(vsync: this, duration: const Duration(seconds: 10));

  @override
  void loadNet() {}

  @override
  void onReady() {
    super.onReady();
    musicController.showMusicPlayer.value = false;
    if (musicController.playingStatus.value) {
      rotateController.repeat();
      rotateController.forward();
    }
    musicController.musicService.audioPlayer.playerStateStream.listen((event) {
      switch (event.processingState) {
        case ProcessingState.completed:
          rotateController.stop();
          break;
        case ProcessingState.idle:
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          break;
      }
    });
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
    Get.lazyPut(() => DetailPlayListController(), fenix: true);
  }
}
