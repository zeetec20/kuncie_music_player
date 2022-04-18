import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/MusicLike.dart';
import 'package:kuncie/repository/music_like_repository.dart';
import 'package:kuncie/service/user_service.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:kuncie/utils/dialog_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kuncie/utils/utils.dart';

class MusicPlayerComponent extends StatelessWidget {
  final MusicLikeRepository musicLikeRepository = MusicLikeRepository();
  late final UserService userService = UserService(musicLikeRepository);
  bool processNext = false;
  Duration? recentDuration;

  Widget placeholderLikeMusic() {
    return ImageIcon(
      AssetImage('assets/images/icon/like_unselect.png'),
      color: ColorsPalete.primary,
      size: 14,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MusicPlayerProvider>(
        builder: (context, musicProvider, child) {
      if (!(musicProvider.isPaused || musicProvider.isPlayed))
        return SizedBox();

      return Dismissible(
          direction: DismissDirection.startToEnd,
          onDismissed: (_) async => await musicProvider.stop(),
          key: Key('music_player'),
          child: StreamProvider<Duration>(
            create: (_) => musicProvider.audioPlayer.positionStream,
            initialData: recentDuration ?? Duration(),
            child: Container(
              constraints: BoxConstraints(minHeight: 130),
              // height: double.minPositive,
              margin: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsPalete.tertiary.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: musicProvider.music!.cover,
                              imageBuilder: (context, image) {
                                return Container(
                                  height: 110,
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: image, fit: BoxFit.cover),
                                  ),
                                  width: size.width * 0.3,
                                  child: Column(),
                                );
                              },
                              placeholder: (context, _) {
                                return Shimmer.fromColors(
                                    child: Container(
                                      height: 110,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: size.width * 0.3,
                                      child: Column(),
                                    ),
                                    baseColor: ColorsPalete.tertiary,
                                    highlightColor: Color(0xFF0E3141));
                              },
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 13, left: 13, bottom: 13, right: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: Text(
                                              musicProvider.music!.title,
                                              style: GoogleFonts.nunito(
                                                  textStyle: TextStyle(
                                                      color:
                                                          ColorsPalete.primary,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        Consumer<AppProvider>(builder:
                                            (context, appProvider, child) {
                                          if (appProvider.isAuthenticate) {
                                            return FutureBuilder<
                                                    ValueListenable<
                                                        Box<MusicLike>>>(
                                                future: userService
                                                    .listenLikeMusic(),
                                                builder:
                                                    (context, listenLikeMusic) {
                                                  if (listenLikeMusic.data ==
                                                      null)
                                                    return placeholderLikeMusic();
                                                  return ValueListenableBuilder(
                                                      valueListenable:
                                                          listenLikeMusic.data!,
                                                      builder: (context,
                                                          likeMusic, child) {
                                                        List<MusicLike>
                                                            listLikeMusic =
                                                            (likeMusic as Box<
                                                                    MusicLike>)
                                                                .values
                                                                .toList();

                                                        bool liked = listLikeMusic
                                                            .where((element) =>
                                                                appProvider.user
                                                                        ?.id ==
                                                                    element
                                                                        .userId &&
                                                                element.id ==
                                                                    musicProvider
                                                                        .music!
                                                                        .id)
                                                            .isNotEmpty;
                                                        return GestureDetector(
                                                          onTap: () async {
                                                            if (liked)
                                                              return await userService
                                                                  .removeLikeMusic(
                                                                      appProvider
                                                                          .user!
                                                                          .id,
                                                                      musicProvider
                                                                          .music!);
                                                            return await userService
                                                                .addLikeMusic(
                                                                    appProvider
                                                                        .user!
                                                                        .id,
                                                                    musicProvider
                                                                        .music!);
                                                          },
                                                          child: ImageIcon(
                                                            liked
                                                                ? AssetImage(
                                                                    'assets/images/icon/like_selected.png')
                                                                : AssetImage(
                                                                    'assets/images/icon/like_unselect.png'),
                                                            color: ColorsPalete
                                                                .primary,
                                                            size: 14,
                                                          ),
                                                        );
                                                      });
                                                });
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    DialogWidget.warning(
                                                        context,
                                                        'You must login to like some music'),
                                              );
                                            },
                                            child: placeholderLikeMusic(),
                                          );
                                        })
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Text(
                                        musicProvider.music!.artist,
                                        style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.zero,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                      trackHeight: 2.5,
                                                      overlayShape:
                                                          SliderComponentShape
                                                              .noOverlay,
                                                      thumbShape:
                                                          RoundSliderThumbShape(
                                                              enabledThumbRadius:
                                                                  6)),
                                              child: Consumer2<Duration,
                                                      AppProvider>(
                                                  builder: (context,
                                                      musicDurationNow,
                                                      appProvider,
                                                      child) {
                                                double durationNow = (musicProvider
                                                                .audioPlayer
                                                                .duration
                                                                ?.inMilliseconds
                                                                .toDouble() ??
                                                            1.0) <
                                                        musicDurationNow
                                                            .inMilliseconds
                                                            .toDouble()
                                                    ? (musicProvider
                                                            .audioPlayer
                                                            .duration
                                                            ?.inMilliseconds
                                                            .toDouble() ??
                                                        1.0)
                                                    : musicDurationNow
                                                        .inMilliseconds
                                                        .toDouble();
                                                recentDuration = Duration(
                                                    milliseconds:
                                                        durationNow.toInt());
                                                double maxDuration =
                                                    musicProvider
                                                            .audioPlayer
                                                            .duration
                                                            ?.inMilliseconds
                                                            .toDouble() ??
                                                        1.toDouble();
                                                maxDuration =
                                                    maxDuration > durationNow
                                                        ? maxDuration
                                                        : durationNow;
                                                if (durationNow ==
                                                        maxDuration &&
                                                    !processNext) {
                                                  (() async {
                                                    processNext = true;
                                                    await musicProvider
                                                        .next(appProvider.user);
                                                    processNext = false;
                                                  })();
                                                }

                                                return Slider(
                                                  value: durationNow,
                                                  onChanged: (time) async =>
                                                      await musicProvider.seek(
                                                          Duration(
                                                              milliseconds: time
                                                                  .toInt())),
                                                  min: 0,
                                                  max: maxDuration,
                                                  activeColor:
                                                      ColorsPalete.primary,
                                                  inactiveColor:
                                                      ColorsPalete.secondary,
                                                  thumbColor:
                                                      ColorsPalete.primary,
                                                );
                                              })),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Consumer<Duration>(builder:
                                                    (context, musicDurationNow,
                                                        child) {
                                                  int durationNow = (musicProvider
                                                                  .audioPlayer
                                                                  .duration
                                                                  ?.inMilliseconds ??
                                                              1) <
                                                          musicDurationNow
                                                              .inMilliseconds
                                                      ? (musicProvider
                                                              .audioPlayer
                                                              .duration
                                                              ?.inMilliseconds ??
                                                          1)
                                                      : musicDurationNow
                                                          .inMilliseconds;
                                                  return Text(
                                                    millisToMinutes(
                                                        durationNow),
                                                    style: GoogleFonts.nunito(
                                                        color: Colors.white,
                                                        fontSize: 9),
                                                  );
                                                }),
                                                Text(
                                                  millisToMinutes((musicProvider
                                                          .audioPlayer
                                                          .duration
                                                          ?.inMilliseconds ??
                                                      1)),
                                                  style: GoogleFonts.nunito(
                                                      color: Colors.white,
                                                      fontSize: 9),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Consumer<AppProvider>(builder:
                                            (context, appProvider, child) {
                                          return GestureDetector(
                                            onTap: () => musicProvider
                                                .previous(appProvider.user),
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.skip_previous_rounded,
                                                size: 26,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }),
                                        GestureDetector(
                                          onTap: () => musicProvider.isPlayed
                                              ? musicProvider.pause()
                                              : musicProvider.play(),
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorsPalete
                                                          .primary
                                                          .withOpacity(0.5),
                                                      blurRadius: 7,
                                                      spreadRadius: -3)
                                                ],
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Icon(
                                              musicProvider.isPlayed
                                                  ? Icons.pause_rounded
                                                  : Icons.play_arrow_rounded,
                                              color: ColorsPalete.primary,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Consumer<AppProvider>(builder:
                                            (context, appProvider, child) {
                                          return GestureDetector(
                                            onTap: () => musicProvider
                                                .next(appProvider.user),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Icon(
                                                Icons.skip_next_rounded,
                                                size: 26,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
