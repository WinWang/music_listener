import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/component/base_component.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/db/playlist_database.dart';

import '../../netease_page/model/bean.dart';
import 'item_playing_list_widget.dart';

class PlayListDialog extends BaseComponent<DetailPlayListController> {
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
                  child: ItemPlayingListWidget(controller.dataList[index], "".obs),
                  onTap: () async {
                    var itemData = controller.dataList[index];
                    // controller.playId.value = itemData.id;
                    // controller.musicPlayerController.setCurrentMusicInfo(itemData.name ?? "", itemData.al.name ?? "",
                    //     itemData.al.picUrl ?? "", itemData.audioUrl ?? "", itemData.id);
                    // controller.savePlayRecord(itemData);
                  },
                ));
              },
              itemCount: controller.dataList.length,
            )),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
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
