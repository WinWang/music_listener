import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

///音乐播放器Service
class MusicService extends GetxService {

  final audioPlayer = AudioPlayer();

  @override
  void onReady() {
    super.onReady();
  }
}
