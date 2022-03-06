import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

const url = 'https://samplelib.com/lib/preview/mp3/sample-15s.mp3';
final audioPlayerState = ChangeNotifierProvider((ref) => AudioPlayerState());

class AudioPlayerState extends ChangeNotifier {
  final player = AudioPlayer();
  late Duration totalDuration;
  Duration currentPosition = Duration.zero;
  bool isPlaying = false;

  Future<void> setUp() async {
    await player.setUrl(url);
    player.positionStream.listen((event) {
      currentPosition = player.position;
      notifyListeners();
    });
  }

  Future<void> play() async {
    isPlaying = true;
    player.play();
    notifyListeners();
  }

  Future<void> stop() async {
    isPlaying = false;
    player.stop();
    notifyListeners();
  }
}
