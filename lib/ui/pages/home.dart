import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Artist.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/RecentMusicPlayed.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/service/music_service.dart';
import 'package:kuncie/ui/component/music.dart';
import 'package:kuncie/ui/component/spacer_music_play.dart';
import 'package:kuncie/ui/pages/artist.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/ui/provider/music_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';
import 'package:blur/blur.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  Widget popularArtist(BuildContext context, Artist artist) {
    Widget placeHolder() {
      return Shimmer.fromColors(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            width: 170,
            decoration: BoxDecoration(
              color: ColorsPalete.tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Blur(
                      colorOpacity: 0.35,
                      blurColor: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          height: 40,
                          child: Row(
                            children: [],
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            artist.name,
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: ColorsPalete.secondary,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 5,
                                  spreadRadius: -3)
                            ], shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 18,
                              color: ColorsPalete.secondary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          baseColor: ColorsPalete.tertiary,
          highlightColor: Color(0xFF0E3141));
    }

    return FutureBuilder<String?>(
      future: Provider.of<MusicProvider>(context, listen: false)
          .getImageArtist(artist),
      initialData: null,
      builder: (context, image) {
        if (image.data == null) return placeHolder();
        String imageUrl = image.data!;
        return CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, image) {
            return Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: image, fit: BoxFit.cover),
              ),
              margin: EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtistPage(artist, imageUrl),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Blur(
                          colorOpacity: 0.4,
                          blurColor: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              height: 40,
                              child: Row(
                                children: [],
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                artist.name,
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: ColorsPalete.secondary,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      spreadRadius: -3)
                                ], shape: BoxShape.circle, color: Colors.white),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  size: 18,
                                  color: ColorsPalete.secondary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          placeholder: (context, _) => placeHolder(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureProvider<List<Artist>>(
      initialData: [],
      create: (_) =>
          Provider.of<MusicProvider>(context, listen: false).getArtist(),
      child: Scaffold(
        backgroundColor: ColorsPalete.secondary,
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_home.png'),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        'Dashboard',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Consumer<List<Artist>>(
                        builder: (context, listArtist, child) {
                      Artist? artist = listArtist.isNotEmpty
                          ? listArtist
                              .where((element) => element.bestMonthly)
                              .first
                          : null;
                      if (artist == null)
                        return placeHolderArtistMonth(context);
                      return FutureProvider<String?>(
                        initialData: null,
                        create: (_) =>
                            Provider.of<MusicProvider>(context, listen: false)
                                .getImageArtist(artist),
                        builder: (context, child) {
                          String? imageUrl = Provider.of<String?>(context);
                          if (imageUrl == null)
                            return placeHolderArtistMonth(context,
                                artist: artist);
                          return CachedNetworkImage(
                            imageUrl: imageUrl,
                            imageBuilder: (context, image) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: ColorsPalete.tertiary,
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: image,
                                    opacity: 0.87,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: size.height * 0.21,
                                padding: EdgeInsets.only(bottom: 15),
                                margin: EdgeInsets.only(
                                    top: 20,
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.05,
                                          right: size.width * 0.05),
                                      child: Text(
                                        'Best Artist of the Month',
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                              height: 0.7,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: size.width * 0.05,
                                          ),
                                          child: Text(
                                            artist.name,
                                            style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: size.width * 0.05),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.only(
                                                  left: 22, right: 22),
                                              backgroundColor:
                                                  ColorsPalete.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ChangeNotifierProvider<
                                                    MusicPlayerProvider>.value(
                                                  value: Provider.of<
                                                          MusicPlayerProvider>(
                                                      context),
                                                  child: ArtistPage(
                                                      artist, imageUrl),
                                                );
                                              }));
                                            },
                                            child: Text(
                                              'Listen',
                                              style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorsPalete.secondary),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            placeholder: (contex, _) =>
                                placeHolderArtistMonth(context, artist: artist),
                          );
                        },
                      );
                    }),
                    Container(
                      margin: EdgeInsets.only(
                          top: 30,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        'Popular Artist',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.05, top: 20),
                      height: 170,
                      child: Consumer<List<Artist>>(
                        builder: (context, listArtist, child) {
                          return SingleChildScrollView(
                            key: UniqueKey(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: listArtist
                                  .map((artist) =>
                                      popularArtist(context, artist))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 30,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        'Recently Played',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<ValueListenable<Box<RecentMusicPlayed>>>(
                        future:
                            Provider.of<MusicProvider>(context, listen: false)
                                .recentMusicPlayedListen(),
                        builder: (context, recentMusic) {
                          if (recentMusic.data == null) return Container();
                          return Consumer2<AppProvider, MusicPlayerProvider>(
                              builder:
                                  (context, appProvider, musicProvider, child) {
                            return ValueListenableBuilder(
                                valueListenable: recentMusic.data!,
                                builder: (context, box, child) {
                                  List<RecentMusicPlayed>
                                      listRecentMusicPlayed =
                                      (box as Box<RecentMusicPlayed>)
                                          .values
                                          .where((element) =>
                                              element.userId ==
                                              appProvider.user?.id)
                                          .toList();
                                  List<RecentMusicPlayed>
                                      listRecentMusicPlayedUniqe = [];
                                  listRecentMusicPlayed.reversed.forEach(
                                      (element) => listRecentMusicPlayedUniqe
                                              .where((e) => e.id == element.id)
                                              .isEmpty
                                          ? listRecentMusicPlayedUniqe
                                              .add(element)
                                          : null);
                                  listRecentMusicPlayed =
                                      listRecentMusicPlayedUniqe
                                          .toList()
                                          .asMap()
                                          .entries
                                          .where((element) => element.key < 10)
                                          .map((e) => e.value)
                                          .toList();
                                  if (listRecentMusicPlayed.isEmpty ||
                                      musicProvider.sourceMusic ==
                                          SourceMusic.recommendation) {
                                    return Consumer<List<Artist>>(
                                        builder: (context, listArtist, child) {
                                      if (listArtist.isEmpty)
                                        return Container();
                                      Artist artist = listArtist
                                          .where(
                                              (element) => element.bestMonthly)
                                          .first;
                                      return FutureProvider<List<Music>>(
                                        create: (_) =>
                                            Provider.of<MusicProvider>(context,
                                                    listen: false)
                                                .search(artist.name),
                                        initialData: [],
                                        builder: (context, child) {
                                          List<Music> listMusic =
                                              Provider.of<List<Music>>(context)
                                                  .asMap()
                                                  .entries
                                                  .where((element) =>
                                                      element.value.artistId ==
                                                      artist.id)
                                                  .map((e) => e.value)
                                                  .toList()
                                                  .asMap()
                                                  .entries
                                                  .where((element) =>
                                                      element.key < 10)
                                                  .map((e) => e.value)
                                                  .toList();
                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 15,
                                                    left: size.width * 0.05,
                                                    right: size.width * 0.05),
                                                child: Text(
                                                  "You don't ever play music, please see some recommendation music for you",
                                                  style: GoogleFonts.nunito(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              ...listMusic
                                                  .map((e) => MusicComponent(
                                                      e,
                                                      listMusic,
                                                      SourceMusic
                                                          .recommendation))
                                                  .toList()
                                            ],
                                          );
                                        },
                                      );
                                    });
                                  }
                                  return Column(
                                    children: listRecentMusicPlayed
                                        .map((e) => MusicComponent(
                                            e.toMusic(),
                                            listRecentMusicPlayed
                                                .map((e) => e.toMusic())
                                                .toList(),
                                            SourceMusic.recent))
                                        .toList(),
                                  );
                                });
                          });
                        }),
                    SpacerMusicPlay()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget placeHolderArtistMonth(BuildContext context, {Artist? artist}) {
  Size size = MediaQuery.of(context).size;

  return Container(
      decoration: BoxDecoration(
        color: ColorsPalete.tertiary,
        borderRadius: BorderRadius.circular(30),
      ),
      height: size.height * 0.21,
      padding: EdgeInsets.only(bottom: 15),
      margin: EdgeInsets.only(
          top: 20, left: size.width * 0.05, right: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            child: Text(
              'Best Artist of the Month',
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    height: 0.7,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 22),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.05,
                ),
                child: Text(
                  artist?.name ?? 'Artist',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: size.width * 0.05),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(left: 22, right: 22),
                    backgroundColor: ColorsPalete.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Listen',
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorsPalete.secondary),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ));
}
