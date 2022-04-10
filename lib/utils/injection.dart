import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:music/business/component/music_component/music_player_component.dart';
import 'package:music/business/service/music_servie.dart';
import 'package:music/http/apiservice/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

///初始化注入对象
class Injection extends GetxService {
  Future<void> init() async {
    await Get.putAsync(() => SharedPreferences.getInstance());
    Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => EventBus(), fenix: true);
    Get.lazyPut(() => MusicService());
    Get.lazyPut(() => MusicPlayerController(), fenix: true);
  }
}
