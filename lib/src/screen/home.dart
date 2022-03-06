import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/audio_player_state.dart';
import 'widget/audio_player_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(audioPlayerState).init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: AudioPlayerCard()),
    );
  }
}
