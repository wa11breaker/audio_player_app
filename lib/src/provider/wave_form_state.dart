import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final waveForm = ChangeNotifierProvider((ref) => AudioWaveForm());

class AudioWaveForm extends ChangeNotifier {
  Waveform? waveform;

  Future init() async {
    final audioFile = File(p.join((await getTemporaryDirectory()).path, 'waveform.mp3'));
    await audioFile.writeAsBytes((await rootBundle.load('assets/sample.mp3')).buffer.asUint8List());
    final waveFile = File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
    await for (var i in JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)) {
      if (i.progress == 1) {
        waveform = i.waveform!;
      }
    }
  }
}
