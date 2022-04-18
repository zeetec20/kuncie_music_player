import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MusicComponent extends StatelessWidget {
  MusicComponent(this.music, this.listMusic, this.sourceMusic);
  final Music music;
  final List<Music> listMusic;
  final SourceMusic sourceMusic;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          bottom: 20, left: size.width * 0.05, right: size.width * 0.05),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: music.cover,
            imageBuilder: (context, image) {
              return Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: image),
                ),
              );
            },
            placeholder: (context, _) => Shimmer.fromColors(
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                ),
                baseColor: ColorsPalete.tertiary,
                highlightColor: Color(0xFF0E3141)),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  music.title,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: ColorsPalete.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  music.artist,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          )),
          Consumer2<MusicPlayerProvider, AppProvider>(
              builder: (context, musicProvider, appProvider, child) {
            return GestureDetector(
              key: Key('button_play'),
              onTap: () async => musicProvider.music != null &&
                      musicProvider.music!.id == music.id
                  ? musicProvider.isPlayed
                      ? musicProvider.pause()
                      : musicProvider.play()
                  : await musicProvider.playSource(
                      appProvider.user, music, listMusic, sourceMusic),
              child: Icon(
                musicProvider.music != null &&
                        musicProvider.music!.id == music.id
                    ? musicProvider.isPlayed
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded
                    : Icons.play_arrow_rounded,
                size: 35,
                color: Colors.white,
              ),
            );
          })
        ],
      ),
    );
  }
}
