import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final audioPlayerState = ChangeNotifierProvider((ref) => AudioPlayerState());

class AudioPlayerState extends ChangeNotifier {
  final player = AudioPlayer();
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  bool isPlaying = false;

  late final String audioFilePath;
  Waveform? waveform;

  Future<void> init() async {
    final ByteData data = await rootBundle.load('assets/sample.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/sample.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    final waveFile = File(path.join((await getTemporaryDirectory()).path, 'waveform.wave'));

    audioFilePath = tempFile.uri.toString();

    await for (var i in JustWaveform.extract(audioInFile: tempFile, waveOutFile: waveFile)) {
      if (i.progress == 1) {
        waveform = i.waveform!;
      }
    }
  }

  Future<void> play() async {
    await player.play(audioFilePath, isLocal: true);
    isPlaying = true;

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
