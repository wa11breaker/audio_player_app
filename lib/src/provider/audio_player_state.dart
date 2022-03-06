import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const url = 'https://samplelib.com/lib/preview/mp3/sample-15s.mp3';
final audioPlayerState = ChangeNotifierProvider((ref) => AudioPlayerState());

class AudioPlayerState extends ChangeNotifier {
  final player = AudioPlayer();
  late Duration totalDuration;
  Duration currentPosition = Duration.zero;
  bool isPlaying = false;

  Future<void> setUp() async {
    totalDuration = (await player.setUrl(url)) ?? Duration.zero;
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

final waveForm = ChangeNotifierProvider((ref) => AudioWaveForm());

class AudioWaveForm extends ChangeNotifier {
  Waveform? waveform;

  Future init() async {
    final audioFile = File(p.join((await getTemporaryDirectory()).path, 'waveform.mp3'));
    await audioFile.writeAsBytes((await rootBundle.load('assets/sample.mp3')).buffer.asUint8List());
    final waveFile = File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
    await for (var i in JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)) {
      print(i.progress);
      if (i.progress == 1) {
        waveform = i.waveform!;
      }
    }
  }
}
