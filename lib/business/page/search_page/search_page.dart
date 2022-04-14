import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/base/controller/base_controller.dart';
import 'package:music/base/pageWidget/base_stateless_widget.dart';
import 'package:music/business/component/music_component/music_player_component.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/business/page/search_page/widget/item_search_list_widget.dart';
import 'package:music/http/apiservice/api_service.dart';
import 'package:music/http/interceptor/netease_handler.dart';
import 'package:music/res/colors.dart';
import 'package:music/utils/keyboard_util.dart';

import 'model/bean.dart';

class SearchPage extends BaseStatelessWidget<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return Obx(() => ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              child: ItemSearchListWidget(
                  controller.dataList[index], controller.playId),
              onTap: () {
                var item = controller.dataList[index];
                controller.playId.value = item.id;
                controller.getSongUrl(item);
              },
            );
          },
          itemCount: controller.dataList.length,
        ));
  }

  @override
  Widget? titleWidget() {
    var outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        borderSide: BorderSide(color: ColorStyle.color_white, width: 1.w));
    return Container(
      height: 80.w,
      alignment: Alignment.centerLeft,
      // decoration: BoxDecoration(
      //     border: Border(
      //         bottom: BorderSide(width: 10.w, color: ColorStyle.color_white))),
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 32.sp, color: ColorStyle.color_white),
        cursorColor: ColorStyle.color_white,
        maxLines: 1,
        autofocus: controller.autoFocus.value,
        controller: controller.editingController,
        decoration: InputDecoration(
          hintText: "请输入歌曲、歌手、专辑名",
          border: InputBorder.none,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          hintStyle: TextStyle(color: ColorStyle.color_CCCCCC, fontSize: 32.sp),
        ),
        onChanged: (value) {
          controller.inputValue.value = value;
        },
      ),
    );
  }

  @override
  bool useLoadSir() => false;

  ///搜索按钮
  @override
  List<Widget>? appBarActionWidget(BuildContext context) {
    return [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.transparent,
          ))
    ];
  }
}

class SearchController extends BaseController<ApiService> {
  TextEditingController editingController = TextEditingController();
  var musicPlayerController = Get.find<MusicPlayerController>();
  RxString inputValue = "".obs;
  late Worker debounceWorker;
  RxList<Song> dataList = <Song>[].obs;
  RxString playId = "".obs;
  RxBool autoFocus = true.obs;

  @override
  void onReady() {
    super.onReady();
    playId.value = musicPlayerController.playId;
    debounceWorker = debounce<String>(inputValue, (value) {
      if (value.isNotEmpty) {
        KeyboardUtils.hideKeyboard(Get.context);
        loadNet();
        autoFocus.value = false;
      }
    }, time: const Duration(milliseconds: 700));
  }

  @override
  void loadNet() {
    httpRequest<SearchSongWrapX>(
        api.searchSong(inputValue.value, options: joinOptions()), (value) {
      dataList.value = value.result.songs;
    }, showLoading: true);
  }

  ///获取音乐的播放链接
  void getSongUrl(Song item) {
    httpRequest<SongUrlListWrap>(
        api.getSongUrlV1("[${item.id}]", options: joinOptions()), (value) {
      musicPlayerController.setCurrentMusicInfo(
          item.name,
          item.artists?[0].name,
          item.artists?[0].img1v1Url,
          value.data?[0].url,
          item.id);
    });
  }

  @override
  void onClose() {
    debounceWorker.dispose();
    editingController.dispose();
    super.onClose();
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
