import 'package:flutter/material.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:provider/provider.dart';

class SpacerMusicPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerProvider>(builder: (context, musicProvider, child) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 350),
        height: musicProvider.isPlayed || musicProvider.isPaused ? 200 : 0,
      );
    });
  }
}
