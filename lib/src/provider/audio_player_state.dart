import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final audioPlayerState = ChangeNotifierProvider((ref) => AudioPlayerState());

class AudioPlayerState extends ChangeNotifier {
  final player = AudioPlayer();
  late Duration totalDuration;
  Duration currentPosition = Duration.zero;

  Future<void> setUp() async {
    var totalDuration = await player.setUrl('https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3');
    player.positionStream.listen((event) {
      currentPosition = player.position;
      print('asdfasdf' + player.position.toString());
      notifyListeners();
    });
    // player.playerStateStream.listen((state) {
    //   print('asdfasdf ' + state.toString());
    //   if (state.playing) {
    //     currentPosition = player.position;
    //     print('asdfasdf' + player.position.toString());
    //     notifyListeners();
    //   }
    // });
    play();
  }

  Future<void> play() async {
    player.play();
  }

  Future<void> stop() async {
    player.stop();
  }
}
