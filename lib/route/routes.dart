import 'package:get/get.dart';
import 'package:music/business/page/main_page/main_page.dart';
import 'package:music/business/page/music_detail_page/music_detail_page.dart';
import 'package:music/business/page/play_list_page/play_list_page.dart';

abstract class AppRoutes {
  static const mainPage = "/main_page"; //主页Main
  static const playListPage = "/play_list_page"; //详情页面
  static const musicDetailPage = "/music_detail_page"; //详情页面

  static final routerPages = [
    ///主入口
    GetPage(
        name: AppRoutes.mainPage,
        page: () => const MainPage(),
        binding: MainBinding()),

    ///列表页面
    GetPage(
        name: AppRoutes.playListPage,
        page: () => const PlayListPage(),
        binding: PlayListBinding()),

    ///详情页面
    GetPage(
        name: AppRoutes.musicDetailPage,
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 200),
        page: () => const MusicDetailPage(),
        binding: MusicDetailBinding()),
  ];
}
