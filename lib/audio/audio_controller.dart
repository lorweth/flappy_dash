import 'dart:math';

import 'package:flappy_dash/audio/sounds.dart';
import 'package:logging/logging.dart';
import 'package:audioplayers/audioplayers.dart';

/// Allows playing music and sound. A facade to `package:audioplayers`.
class AudioController {
  static final _log = Logger('AudioController');
  final Random _random = Random();

  /// This is a list of [AudioPlayer] instances which are rotated to play
  /// sound effects.
  final List<AudioPlayer> _sfxPlayers;

  int _currentSfxPlayer = 0;

  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _sfxPlayers = Iterable.generate(
                polyphony, (i) => AudioPlayer(playerId: '_sfxPlayer#$i'))
            .toList(growable: false);

  void dispose(){
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }

  /// Plays a single sound effect, defined by [type].
  void playSfx(SfxType type) {
    _log.fine(() => 'Playing sound: $type');
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    _log.fine(() => '- Chosen filename: $filename');

    final currentPlayer = _sfxPlayers[_currentSfxPlayer];
    currentPlayer.play(AssetSource('sfx/$filename'),
        volume: soundTypeToVolume(type));
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
  }

  /// Preloads all sound effects.
  Future<void> preloadSfx() async {
    _log.info('Preloading sound effects');
    // This assumes there is only a limited number of sound effects in the game.
    // If there are hundreds of long sound effect files, it's better
    // to be more selective when preloading.
    await AudioCache.instance.loadAll(SfxType.values
        .expand(soundTypeToFilename)
        .map((path) => 'sfx/$path')
        .toList());
  }
}
