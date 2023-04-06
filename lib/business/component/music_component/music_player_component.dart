import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/base/component/base_component.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/business/service/music_servie.dart';
import 'package:music/constant/common_constant.dart';
import 'package:music/http/apiservice/api_service.dart';
import 'package:music/http/interceptor/netease_handler.dart';
import 'package:music/res/colors.dart';
import 'package:music/res/r.dart';
import 'package:music/res/style.dart';
import 'package:music/route/routes.dart';
import 'package:music/utils/log_utils.dart';
import 'package:music/utils/sp_utils.dart';
import 'package:music/widget/base_network_image.dart';
import 'package:music/widget/progress_paint.dart';

///全局音乐播放器控制按钮
// ignore: must_be_immutable
class MusicPlayer extends BaseComponent<MusicPlayerController> {
  MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => playContent(context));
  }

  Widget playContent(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        color: ColorStyle.color_white,
        height: controller.showMusicPlayer.value ? 120.w : 0,
        duration: const Duration(milliseconds: 150),
        child: Stack(
          children: [
            Positioned(
              child: CustomPaint(
                size: Size(630.w, 3.w),
                painter: ProgressPaint(controller.currentPosition.value,
                    controller.audioLenght.value),
              ),
              left: 120.w,
            ),
            Row(
              children: [
                BaseNetworkImage(
                  controller.playCoverUrl.value,
                  height: 120.w,
                  width: 120.w,
                  fit: BoxFit.cover,
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
            ),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(AppRoutes.musicDetailPage);
      },
    );
  }

  @override
  bool useLoadSir() {
    return false;
  }
}

class MusicPlayerController extends BaseController<ApiService> {
  ///图片封面
  RxString playCoverUrl = "".obs;

  ///音乐播放器服务
  var musicService = Get.find<MusicService>();

  ///音乐名称
  RxString musicTitle = "".obs;

  ///歌手名称
  RxString musicion = "".obs;

  ///音乐播放器Icon
  RxString playIcon = R.red_play_icon.obs;

  ///是否展示音乐播放器
  RxBool showMusicPlayer = true.obs;

  ///播放音乐ID
  RxString playId = "".obs;

  RxBool playingStatus = false.obs;

  ///音乐播放链接
  String musicUrl = "";

  ///音频时长
  RxInt audioLenght = 0.obs;

  ///音频当前播放位置
  RxInt currentPosition = 0.obs;

  @override
  void loadNet() {}

  @override
  void onReady() {
    super.onReady();
    // musicService.audioPlayer.setUrl("https://www.ytmp3.cn/down/32474.mp3");
    musicService.audioPlayer.playerStateStream.listen((event) {
      if (event.playing) {
        playIcon.value = R.red_pause_icon;
        playingStatus.value = true;
      } else {
        playIcon.value = R.red_play_icon;
        playingStatus.value = false;
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
      audioLenght.value = event?.inSeconds ?? 0;
      // LogD("歌曲时间>>>>>>>>>>>>>>>>>$inSeconds");
    });

    ///歌曲进度监听
    musicService.audioPlayer.positionStream.listen((event) {
      currentPosition.value = event.inSeconds;
      // LogD("歌曲时间>>>>>>>>>>>>>>>>>$inSeconds");
    });
    _initMusicPlayer();
    getSongUrl();
  }

  Future setMusicUrl(String? url, {bool isInit = false}) async {
    if (url != null && url.isNotEmpty) {
      await musicService.audioPlayer.setUrl(url);
      if (isInit) {
        await musicService.audioPlayer.stop();
      }
      // await musicService.audioPlayer.dispose();
    }
  }

  ///设置当前音频进度
  void setSeekPosition(double? seekPosition) {
    musicService.audioPlayer
        .seek(Duration(seconds: seekPosition?.toInt() ?? 0));
  }

  ///音乐播放逻辑
  Future playMusic() async {
    if (musicService.audioPlayer.playing) {
      await musicService.audioPlayer.pause();
    } else {
      await musicService.audioPlayer.play();
    }
  }

  ///设置当前音乐信息
  Future setCurrentMusicInfo(String? title, String? artist, String? coverUrl,
      String? audioUrl, String? audioTrackId,
      {bool needSave = true, bool autoPlay = true}) async {
    //设置界面数据
    setMusicInfo(title, artist, coverUrl, audioTrackId, audioUrl);
    if (musicUrl.isEmpty) {
      showMusicPlayer.value = false;
    } else {
      showMusicPlayer.value = true;
    }
    //缓存播放数据
    if (needSave) {
      SPUtils.instance.putString(KeyConstant.keyMusicTitle, title ?? "");
      SPUtils.instance.putString(KeyConstant.keyMusicArt, artist ?? "");
      SPUtils.instance.putString(KeyConstant.keyMusicCover, coverUrl ?? "");
      SPUtils.instance.putString(KeyConstant.keyMusicID, audioTrackId ?? "");
      SPUtils.instance.putString(KeyConstant.keyMusicUrl, musicUrl);
    }
    //设置播放器链接并播放
    await setMusicUrl(musicUrl, isInit: needSave);
    if (autoPlay) {
      playMusic();
    }
  }

  void setMusicInfo(String? title, String? artist, String? coverUrl,
      String? audioTrackId, String? audioUrl) {
    musicTitle.value = title ?? "";
    musicion.value = artist ?? "";
    playCoverUrl.value = coverUrl ?? "";
    playId.value = audioTrackId ?? "";
    musicUrl = audioUrl ?? "";
  }

  ///初始化设置播放器数据
  void _initMusicPlayer() {
    var title = SPUtils.instance.getString(KeyConstant.keyMusicTitle);
    var artist = SPUtils.instance.getString(KeyConstant.keyMusicArt);
    var coverUrl = SPUtils.instance.getString(KeyConstant.keyMusicCover);
    var playId = SPUtils.instance.getString(KeyConstant.keyMusicID);
    var musicUrl = SPUtils.instance.getString(KeyConstant.keyMusicUrl);
    LogD("初始化音频链接>>>>>>>>>$musicUrl");
    setCurrentMusicInfo(title, artist, coverUrl, musicUrl, playId,
        needSave: false, autoPlay: false);
  }

  ///获取音乐的播放链接
  void getSongUrl() {
    LogWTF("网络更新播放链接1>>>>>>>>>$musicUrl");
    if (playId.isNotEmpty) {
      httpRequest<SongUrlListWrap>(
          api.getSongUrlV1("[$playId]", options: joinOptions()), (value) {
        musicUrl = value.data?[0].url ?? "";
        setMusicUrl(musicUrl);
        LogWTF("网络更新播放链接2>>>>>>>>>$musicUrl");
      });
    }
  }

  @override
  void onClose() {
    musicService.audioPlayer.dispose();
    super.onClose();
  }
}
