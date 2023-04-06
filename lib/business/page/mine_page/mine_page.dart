import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/page/mine_page/widget/item_play_my_song_list_widget.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/db/record_database.dart';

class MinePage extends BaseStatelessWidget<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => ListView.builder(
          itemBuilder: (context, index) {
            return ItemPlayMySongListWidget(controller.myList[index], "".obs);
          },
          itemCount: controller.myList.length,
        ));
  }

  @override
  bool useLoadSir() => false;

  @override
  bool showTitleBar() => false;
}

class MineController extends BaseController {
  RxList<MyRecord> myList = <MyRecord>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadNet();
    addStremSub(eventBus.on<MyRecord>().listen((event) {
      myList.insert(0, event);
    }));
  }

  Future<void> queryMyRecord() async {
    var readAllRecord = await RecordDatabase.instance.readAllRecord();
    myList.value = readAllRecord.reversed.toList();
    showToast("msg");
  }

  @override
  void loadNet() {
    queryMyRecord();
  }

  @override
  bool useEventBus() {
    return true;
  }
}

class MineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineController());
  }
}
