import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/component/base_component.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/business/component/music_component/music_player_component.dart';
import 'package:music/controller/theme_controller.dart';
import 'package:music/db/playlist_database.dart';
import 'package:music/res/colors.dart';

import '../../netease_page/model/bean.dart';
import 'item_playing_list_widget.dart';

class PlayListDialog extends BaseComponent<DetailPlayListController> {
  var themeController = Get.find<ThemeController>();

  PlayListDialog({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => SizedBox(
        height: 900.w,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Material(
                    child: InkWell(
                  child: ItemPlayingListWidget(controller.dataList[index], controller.musicPlayerController.playId),
                  onTap: () async {
                    var itemData = controller.dataList[index];
                    controller.musicPlayerController.setCurrentMusicInfo(itemData.name ?? "", itemData.al.name ?? "",
                        itemData.al.picUrl ?? "", itemData.audioUrl ?? "", itemData.id);
                  },
                ));
              },
              itemCount: controller.dataList.length,
            )),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: themeController.isDarkMode.value ? ColorStyle.color_444444: Colors.white,
                height: 100.w,
                child: const Text("关闭", style: TextStyle()),
              ),
              onTap: () {
                Get.back();
              },
            )
          ],
        )));
  }

  @override
  bool useLoadSir() => false;
}

class DetailPlayListController extends BaseController {
  var musicPlayerController = Get.find<MusicPlayerController>();

  RxList dataList = <MyRecord>[].obs;

  @override
  void onReady() {
    loadNet();
  }

  Future<void> queryMyRecord() async {
    var readAllRecord = await PlayListDatabase.instance.readAllPlayList();
    dataList.value = readAllRecord;
  }

  @override
  void loadNet() {
    queryMyRecord();
  }
}
