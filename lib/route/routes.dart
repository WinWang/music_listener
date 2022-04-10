import 'package:get/get.dart';
import 'package:music/business/page/main_page/main_page.dart';
import 'package:music/business/page/play_list_page/play_list_page.dart';

abstract class AppRoutes {
  static const mainPage = "/main_page"; //主页Main
  static const detailPage = "/play_list_page"; //详情页面

  static final routerPages = [
    ///主入口
    GetPage(
        name: AppRoutes.mainPage,
        page: () => const MainPage(),
        binding: MainBinding()),

    ///详情页面
    GetPage(
        name: AppRoutes.detailPage,
        page: () => const PlayListPage(),
        binding: PlayListBinding()),
  ];
}
