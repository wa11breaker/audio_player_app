import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/audio_player_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (_, ref, __) {
          final data = ref.watch(audioPlayerState);
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data.currentPosition.inSeconds.toString()),
                IconButton(
                  onPressed: () {
                    data.setUp();
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    data.stop();
                  },
                  icon: Icon(Icons.add),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
