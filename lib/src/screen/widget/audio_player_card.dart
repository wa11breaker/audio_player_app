import 'package:audio_player_ui/src/screen/widget/audio_waveform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/audio_player_state.dart';
import '../../provider/wave_form_state.dart';
import '../../theme/color.dart';
import '../../utils/duration.dart';

class AudioPlayerCard extends StatelessWidget {
  const AudioPlayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final data = ref.watch(audioPlayerState);
      final waveform = ref.watch(waveForm);
      return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What does sports mean to you?',
              style: TextStyle(
                color: AppColor.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Icon(
                    data.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColor.white,
                  ),
                  onTap: () {
                    data.isPlaying ? data.stop() : data.play();
                  },
                ),
                if (waveform.waveform != null)
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: AudioWaveformWidget(
                        waveform: waveform.waveform!,
                        duration: waveform.waveform!.duration,
                        start: data.currentPosition,
                        waveColor: AppColor.white,
                        strokeWidth: 1,
                        pixelsPerStep: 3,
                        scale: 0.6,
                      ),
                    ),
                  )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                getTimeFromDuration(data.totalDuration),
                style: const TextStyle(
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
