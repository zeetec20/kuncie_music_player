import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Artist.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/MusicLike.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/music_like_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/service/music_service.dart';
import 'package:kuncie/service/user_service.dart';
import 'package:kuncie/ui/component/music.dart';
import 'package:kuncie/ui/component/spacer_music_play.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/ui/provider/music_provider.dart';
import 'package:kuncie/ui/provider/user_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LikePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: ColorsPalete.secondary,
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_likes.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                SafeArea(
                  child: FutureBuilder<ValueListenable<Box<MusicLike>>>(
                      future: Provider.of<UserProvider>(context, listen: false)
                          .listenLikeMusic(),
                      builder: (context, listenLikeMusic) {
                        if (listenLikeMusic.data == null) return Container();
                        return Consumer<AppProvider>(
                            builder: (context, appProvider, child) {
                          return ValueListenableBuilder<Box<MusicLike>>(
                              valueListenable: listenLikeMusic.data!,
                              builder: (context, likeMusic, child) {
                                List<MusicLike> listLikeMusic = likeMusic.values
                                    .where((element) =>
                                        element.userId == appProvider.user?.id)
                                    .toList();
                                if (listLikeMusic.isEmpty)
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorsPalete.primary),
                                        child: ImageIcon(
                                          AssetImage(
                                              'assets/images/icon/like_selected.png'),
                                          size: 30,
                                          color: ColorsPalete.secondary,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 15,
                                            left: size.width * 0.05,
                                            right: size.width * 0.05),
                                        child: Text(
                                          'Like Music Empty',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 32),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 25,
                                            left: size.width * 0.05,
                                            right: size.width * 0.05),
                                        child: Text(
                                          'You can play music favorite without search by like when music played',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );

                                List<Artist> listArtistUniqe = [];
                                List<Artist> listArtist = listLikeMusic
                                    .map((e) => Artist(e.artist, e.artistUrl))
                                    .toList();
                                listArtist.forEach((artist) => listArtistUniqe
                                        .where((element) =>
                                            element.id == artist.id)
                                        .isNotEmpty
                                    ? null
                                    : listArtistUniqe.add(artist));
                                listArtist = listArtistUniqe;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.05,
                                              right: size.width * 0.05),
                                          child: Text(
                                            'Favorite Songs',
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: size.width * 0.05),
                                            child: Consumer2<
                                                    MusicPlayerProvider,
                                                    AppProvider>(
                                                builder: (context,
                                                    musicProvider,
                                                    appProvider,
                                                    child) {
                                              List<Music> shuffle =
                                                  listLikeMusic
                                                      .map((e) => e.toMusic())
                                                      .toList();
                                              return GestureDetector(
                                                onTap: () =>
                                                    musicProvider.playSource(
                                                        appProvider.user,
                                                        shuffle[Random()
                                                            .nextInt(
                                                                shuffle.length -
                                                                    1)],
                                                        shuffle,
                                                        SourceMusic.like),
                                                child: Icon(
                                                  Icons.shuffle_rounded,
                                                  size: 28,
                                                  color: Colors.white,
                                                ),
                                              );
                                            }))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    ...listArtist.map((artist) {
                                      List<Music> listMusic = listLikeMusic
                                          .where((element) =>
                                              element.artistId == artist.id)
                                          .map((e) => e.toMusic())
                                          .toList();
                                      return Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: ColorsPalete.tertiary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              margin: EdgeInsets.only(
                                                  bottom: 10,
                                                  top: 30,
                                                  left: size.width * 0.05,
                                                  right: size.width * 0.05),
                                              child: Row(
                                                children: [
                                                  FutureBuilder<String>(
                                                      future: Provider.of<
                                                                  MusicProvider>(
                                                              context,
                                                              listen: false)
                                                          .getImageArtist(
                                                              artist),
                                                      builder:
                                                          (context, imageUrl) {
                                                        Widget placeHolder() {
                                                          return Shimmer
                                                              .fromColors(
                                                                  child:
                                                                      Container(
                                                                    height: 65,
                                                                    width: 65,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      // image: DecorationImage(image: image),
                                                                    ),
                                                                  ),
                                                                  baseColor:
                                                                      ColorsPalete
                                                                          .tertiary,
                                                                  highlightColor:
                                                                      Color(
                                                                          0xFF0E3141));
                                                        }

                                                        if (!imageUrl.hasData)
                                                          return placeHolder();
                                                        return CachedNetworkImage(
                                                          imageUrl:
                                                              imageUrl.data!,
                                                          imageBuilder:
                                                              (context, image) {
                                                            return Container(
                                                              height: 65,
                                                              width: 65,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                image: DecorationImage(
                                                                    image:
                                                                        image),
                                                              ),
                                                            );
                                                          },
                                                          placeholder:
                                                              (context, _) =>
                                                                  placeHolder(),
                                                        );
                                                      }),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          artist.name,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            textStyle: TextStyle(
                                                                color:
                                                                    ColorsPalete
                                                                        .primary,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          '${listMusic.length} Songs',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  Consumer2<MusicPlayerProvider,
                                                          AppProvider>(
                                                      builder: (context,
                                                          musicProvider,
                                                          appProvider,
                                                          child) {
                                                    return GestureDetector(
                                                      child: Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        size: 35,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  })
                                                ],
                                              )),
                                          Column(
                                            children: listMusic
                                                .map((e) => Dismissible(
                                                      direction:
                                                          DismissDirection
                                                              .startToEnd,
                                                      key: UniqueKey(),
                                                      onDismissed: (_) => Provider
                                                              .of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .removeLikeMusic(
                                                              appProvider
                                                                  .user!.id,
                                                              e),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 20),
                                                        child: MusicComponent(
                                                            e,
                                                            listMusic,
                                                            SourceMusic.like),
                                                      ),
                                                    ))
                                                .toList(),
                                          )
                                        ],
                                      );
                                    }).toList()
                                  ],
                                );
                              });
                        });
                      }),
                ),
                SpacerMusicPlay()
              ],
            ),
          ),
        ));
  }
}
