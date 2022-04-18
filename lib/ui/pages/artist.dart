import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuncie/models/Artist.dart';
import 'package:kuncie/models/Music.dart';    
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/service/music_service.dart';
import 'package:kuncie/ui/component/music.dart';
import 'package:kuncie/ui/component/music_player.dart';
import 'package:kuncie/ui/component/spacer_music_play.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/ui/provider/music_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';

class ArtistPage extends StatelessWidget {
  ArtistPage(this.artist, this.image);
  final Artist artist;
  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureProvider<List<Music>>(
      initialData: [],
      create: (_) => Provider.of<MusicProvider>(context, listen: false).search(artist.name),
      child: Scaffold(
          backgroundColor: ColorsPalete.secondary,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsPalete.primary,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/background_artist_head.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30)),
                        ),
                        height: size.height * 0.3,
                        width: size.width,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05, top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_left_rounded,
                                    color: ColorsPalete.secondary,
                                    size: 35,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: image,
                                    imageBuilder: (context, image) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: size.width * 0.05),
                                        height: size.height * 0.1,
                                        width: size.height * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: image, fit: BoxFit.cover),
                                        ),
                                      );
                                    },
                                    placeholder: (context, _) {
                                      return Container();
                                    },
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 10,
                                        left: size.width * 0.05,
                                        right: size.width * 0.05,
                                        bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                artist.name,
                                                style: GoogleFonts.nunito(
                                                  textStyle: TextStyle(
                                                      color: ColorsPalete
                                                          .secondary,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 23),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Consumer<List<Music>>(
                                                  builder: (context, listMusic,
                                                      child) {
                                                listMusic = listMusic
                                                    .where((e) =>
                                                        e.artistId == artist.id)
                                                    .toList();
                                                return Text(
                                                  '${listMusic.length} Songs',
                                                  style: GoogleFonts.nunito(
                                                    textStyle: TextStyle(
                                                        color: ColorsPalete
                                                            .secondary,
                                                        fontSize: 13),
                                                  ),
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                        Consumer2<List<Music>, AppProvider>(
                                            builder: (context, listMusic,
                                                appProvider, child) {
                                          listMusic = listMusic
                                              .where((e) =>
                                                  e.artistId == artist.id)
                                              .toList();
                                          return GestureDetector(
                                            onTap: () {
                                              Provider.of<MusicPlayerProvider>(
                                                      context,
                                                      listen: false)
                                                  .playSource(
                                                      appProvider.user,
                                                      listMusic.first,
                                                      listMusic,
                                                      SourceMusic.artist);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                size: 33,
                                                color: ColorsPalete.primary,
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        color: ColorsPalete.primary,
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        height: size.height * 0.7,
                        width: size.width,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        height: size.height * 0.7,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(30)),
                          color: ColorsPalete.secondary,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/background_artist.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SingleChildScrollView(
                            child: Consumer<List<Music>>(
                                builder: (context, listMusic, child) {
                              listMusic = listMusic
                                  .where((e) => e.artistId == artist.id)
                                  .toList();
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ...listMusic
                                      .map((e) => MusicComponent(
                                          e, listMusic, SourceMusic.artist))
                                      .toList(),
                                  SpacerMusicPlay()
                                ],
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              MusicPlayerComponent()
            ],
          )),
    );
  }
}
