import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/audio_player_state.dart';
import '../theme/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (_, ref, __) {
          final data = ref.watch(audioPlayerState);
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'What does sports mean to you?',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          data.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          data.isPlaying ? data.stop() : data.play();
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      data.currentPosition.inSeconds.toString(),
                      style: const TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
