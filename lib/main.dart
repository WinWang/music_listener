import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music/business/page/main_page/main_page.dart';
import 'package:music/http/interceptor/netease_handler.dart';
import 'package:music/route/routes.dart';
import 'package:music/utils/injection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base/pageWidget/common_stateful_widget.dart';
import 'business/component/music_component/music_player_component.dart';
import 'business/music_component/music_player_component.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSDK();
  runApp(MyApp());
}

///初始化SDK
Future<void> initSDK() async {
  // SharedPreferences.setMockInitialValues({});
  NeteaseMusicApi.init(debug: false);
  await Injection().init();
}

class MyApp extends CommonStatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init( Size(750, 1334));
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => const MaterialClassicHeader(),
      footerBuilder: () => const ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: ScreenUtilInit(
          designSize: const Size(750, 1334),
          builder: () => GetMaterialApp(
                getPages: AppRoutes.routerPages,
                defaultTransition: Transition.rightToLeft,
                transitionDuration: const Duration(milliseconds: 150),
                title: 'OpenEye',
                theme: ThemeData(
                  primarySwatch: Colors.red,
                ),
                initialBinding: MainBinding(),
                // home: const MainPage(),
                initialRoute: AppRoutes.mainPage,
                locale: const Locale('zh'),
                builder: (BuildContext context, Widget? child) {
                  return Column(
                    children: [Expanded(child: child!), MusicPlayer()],
                  );
                },
              )),
    );
  }
}
