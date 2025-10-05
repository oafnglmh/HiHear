import 'package:hihear_mo/data/datasources/sources/audio/audio_player_service.dart';

class PlaySplashMusicUseCase {
  final AudioPlayerService _audioPlayerService;

  PlaySplashMusicUseCase(this._audioPlayerService);

  Future<void> call() async {
    await _audioPlayerService.playSplashMusic();
  }
}
