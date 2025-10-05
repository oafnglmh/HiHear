import 'package:audioplayers/audioplayers.dart';
import 'package:hihear_mo/core/constants/app_audio.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSplashMusic() async {
    await _player.setReleaseMode(ReleaseMode.stop);
    await _player.play(AssetSource(AppAudio.backgroundMusic));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void dispose() {
    _player.dispose();
  }
}
