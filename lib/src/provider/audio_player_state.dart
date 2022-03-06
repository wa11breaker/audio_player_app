import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioPlayerState = ChangeNotifierProvider((ref) => AudioPlayerState());

class AudioPlayerState extends ChangeNotifier {
  final player = AudioPlayer();
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  bool isPlaying = false;

  Future<void> play() async {
    await player.play('assets/sample.mp3', isLocal: true);
    isPlaying = true;
    // await player.play('assets/sample.mp3', isLocal: true);
    player.onDurationChanged.listen((Duration d) {
      totalDuration = d;
      notifyListeners();
    });

    player.onAudioPositionChanged.listen((Duration d) {
      currentPosition = d;
      notifyListeners();
    });
  }

  Future<void> stop() async {
    isPlaying = false;
    player.stop();
    notifyListeners();
  }
}
