import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/base/component/base_component.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/business/service/music_servie.dart';
import 'package:music/res/colors.dart';
import 'package:music/res/r.dart';
import 'package:music/res/style.dart';
import 'package:music/utils/log_utils.dart';
import 'package:music/widget/base_network_image.dart';

///全局音乐播放器控制按钮
// ignore: must_be_immutable
class MusicPlayer extends BaseComponent<MusicPlayerController> {
  MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => Visibility(
          child: playContent(context),
          visible: controller.showMusicPlayer.value,
        ));
  }

  Widget playContent(BuildContext context) {
    return Container(
      color: ColorStyle.color_white,
      height: 120.w,
      child: Stack(
        children: [
          Row(
            children: [
              BaseNetworkImage(
                controller.playCoverUrl.value,
                height: 120.w,
                width: 120.w,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.musicTitle.value,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontSize: 30.sp,
                        color: ColorStyle.color_666666,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Box.hBox15,
                    Text(
                      controller.musicion.value,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontSize: 25.sp,
                        color: ColorStyle.color_666666,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(25.w),
                  alignment: Alignment.center,
                  height: 120.w,
                  width: 120.w,
                  child: Image.asset(controller.playIcon.value),
                ),
                onTap: () {
                  controller.playMusic();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool useLoadSir() {
    return false;
  }
}

class MusicPlayerController extends BaseController {
  ///图片封面
  RxString playCoverUrl =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.51yuansu.com%2Fpic3%2Fcover%2F03%2F19%2F89%2F5b642bed6d88c_610.jpg&refer=http%3A%2F%2Fpic.51yuansu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1652083866&t=bcf36906324b5a5627ee9d5da3dee95d"
          .obs;
  final musicService = Get.find<MusicService>();

  ///音乐名称
  RxString musicTitle = "".obs;

  ///歌手名称
  RxString musicion = "".obs;

  ///音乐播放器Icon
  RxString playIcon = R.red_play_icon.obs;

  ///是否展示音乐播放器
  RxBool showMusicPlayer = true.obs;

  ///播放音乐ID
  String playId = "";

  @override
  void loadNet() {}

  @override
  void onReady() {
    super.onReady();
    // musicService.audioPlayer.setUrl("https://www.ytmp3.cn/down/32474.mp3");
    musicService.audioPlayer.setUrl(
        "http://m10.music.126.net/20220410124318/40490e60c264c916a980c88cb1928201/ymusic/7e36/b485/9161/55fd937c2e7ee86838c53ae95fe41224.mp3");
    musicService.audioPlayer.playerStateStream.listen((event) {
      if (event.playing) {
        playIcon.value = R.red_pause_icon;
      } else {
        playIcon.value = R.red_play_icon;
      }
      switch (event.processingState) {
        case ProcessingState.completed:
          musicService.audioPlayer.stop();
          musicService.audioPlayer.seek(Duration.zero);
          playIcon.value = R.red_play_icon;
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

    musicService.audioPlayer.bufferedPositionStream.listen((event) {
      // var inSeconds = event.inSeconds;
      // LogD("歌曲时间>>>>>>>>>>>>>>>>>$inSeconds");
    });
    musicService.audioPlayer.durationStream.listen((event) {
      var inSeconds = event?.inSeconds;
      // LogD("歌曲时间>>>>>>>>>>>>>>>>>$inSeconds");
    });

    ///歌曲进度监听
    musicService.audioPlayer.positionStream.listen((event) {
      var inSeconds = event.inSeconds;
      // LogD("歌曲时间>>>>>>>>>>>>>>>>>$inSeconds");
    });
  }

  Future setMusicUrl(String? url) async {
    LogD("设置音乐播放器链接>>>>>>>$url");
    if (url != null && url.isNotEmpty) {
      await musicService.audioPlayer.setUrl(url);
      await musicService.audioPlayer.stop();
      // await musicService.audioPlayer.dispose();
    }
  }

  ///音乐播放逻辑
  void playMusic() {
    if (musicService.audioPlayer.playing) {
      musicService.audioPlayer.pause();
    } else {
      musicService.audioPlayer.play();
    }
  }
}
