import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/component/music_component/music_player_component.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/business/page/play_list_page/widget/item_play_song_list_widget.dart';
import 'package:music/db/playlist_database.dart';
import 'package:music/db/record_database.dart';
import 'package:music/http/apiservice/api_service.dart';
import 'package:music/http/interceptor/netease_handler.dart';
import 'package:music/res/colors.dart';
import 'package:music/utils/log_utils.dart';
import 'package:music/widget/base_network_image.dart';

class PlayListPage extends BaseStatelessWidget<PlayListController> {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return CustomScrollView(slivers: [_createSliverAppBar(), _createSliverList()]);
  }

  ///顶部滚动AppBar
  Widget _createSliverAppBar() {
    return SliverAppBar(
      elevation: 8.0,
      title: Text(
        controller.title.value,
        style: TextStyle(fontSize: 32.sp),
      ),
      pinned: true,
      expandedHeight: 500.w,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            BaseNetworkImage(
              controller.topCover.value,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              // 过滤器
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //必须设置一个空容器
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.only(left: 40.w, right: 40.w),
              margin: EdgeInsets.only(top: 200.w),
              child: Text(
                controller.desc.value,
                style: TextStyle(color: ColorStyle.color_white, fontSize: 26.sp),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///列表数据
  Widget _createSliverList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return InkWell(
        child: ItemPlaySongListWidget(controller.dataList[index], controller.musicPlayerController.playId),
        onTap: () async {
          var itemData = controller.dataList[index];
          controller.playId.value = itemData.id;
          controller.musicPlayerController.setCurrentMusicInfo(itemData.name ?? "", itemData.al.name ?? "",
              itemData.al.picUrl ?? "", itemData.audioUrl ?? "", itemData.id);
          controller.savePlayRecord(itemData);
        },
      );
    }, childCount: controller.dataList.length));
  }

  @override
  bool showTitleBar() => false;
}

class PlayListController extends BaseController<ApiService> {
  var musicPlayerController = Get.find<MusicPlayerController>();
  var id = Get.arguments; //歌曲ID值
  RxList<Song2> dataList = <Song2>[].obs;
  RxString topCover = "".obs;
  RxString topDesc = "".obs;
  RxString title = "".obs;
  RxString desc = "".obs;
  RxString playId = "".obs;

  @override
  void loadNet() {
    getMusicList();
  }

  @override
  void onReady() {
    super.onReady();
    loadNet();
  }

  ///获取专辑列表
  void getMusicList() {
    httpRequest<SinglePlayListWrap>(api.getPlayList(id, options: joinOptions()), (value) {
      var trackIds = value.playlist?.trackIds?.map((i) => i.id);
      var c = '[' + trackIds!.map((id) => '{"id":' + id + '}').join(',') + ']';
      var ids = '[' + trackIds.join(',') + ']';
      getSong(c, ids);
      title.value = value.playlist?.name ?? "";
      topCover.value = value.playlist?.coverImgUrl ?? "";
      desc.value = value.playlist?.description ?? "";
    });
  }

  ///获取歌曲详情列表
  void getSong(String c, String ids) {
    httpRequest<SongDetailWrap>(api.getSongList(c, ids, options: joinOptions()), (value) {
      dataList.value = value.songs ?? [];
      getSongUrl(ids, value.songs ?? []);
    });
  }

  ///获取音乐的播放链接
  void getSongUrl(String ids, List<Song2> songList) {
    httpRequest<SongUrlListWrap>(api.getSongUrlV1(ids, options: joinOptions()), (value) {
      if (songList.isNotEmpty) {
        value.data?.forEach((elementUrl) {
          for (var elementSong in songList) {
            if (elementUrl.id == elementSong.id) {
              elementSong.audioUrl = elementUrl.url;
            }
          }
        });
      }
      dataList.value = songList;
    });
  }

  Future<void> savePlayRecord(Song2 item) async {
    LogD("播放链接>>>>>>${item.audioUrl}");
    var myRecord = MyRecord();
    myRecord.name = item.name ?? "";
    myRecord.al_name = item.al.name ?? "";
    myRecord.picUrl = item.al.picUrl ?? "";
    myRecord.id = item.id;
    myRecord.audioUrl = item.audioUrl ?? "";
    myRecord.time = DateTime.now().millisecondsSinceEpoch.toString();
    await RecordDatabase.instance.create(myRecord);
    eventBus.fire(myRecord);
    //存储播放列表
    savePlayList();
  }

  Future<void> savePlayList() async {
    await PlayListDatabase.instance.clearDatabase();
    for (var element in dataList) {
      var myRecord = MyRecord();
      myRecord.name = element.name ?? "";
      myRecord.al_name = element.al.name ?? "";
      myRecord.picUrl = element.al.picUrl ?? "";
      myRecord.audioUrl = element.audioUrl ?? "";
      myRecord.id = element.id;
      myRecord.time = DateTime.now().millisecondsSinceEpoch.toString();
      await PlayListDatabase.instance.create(myRecord);
    }
  }

  @override
  bool useEventBus() {
    return true;
  }

  @override
  void onClose() async {
    // await PlayListDatabase.instance.close();
    // await RecordDatabase.instance.close();
    super.onClose();
  }
}

class PlayListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayListController());
  }
}
