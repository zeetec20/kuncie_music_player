import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/MusicLike.dart';
import 'package:kuncie/ui/component/spacer_music_play.dart';
import 'package:kuncie/ui/pages/auth/wrapper_auth.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/user_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsPalete.secondary,
      body: Consumer<AppProvider>(builder: (context, appProvider, child) {
        if (appProvider.user != null)
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsPalete.primary,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/background_profile_head.png'),
                          fit: BoxFit.cover),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                    ),
                    height: size.height * 0.3,
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          height: size.height * 0.14,
                          width: size.height * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5),
                            image: DecorationImage(
                                image: AssetImage('assets/images/avatar.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
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
                              'assets/images/background_profile.png'),
                          fit: BoxFit.cover),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: 30,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Text(
                              'Your Profile',
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    color: ColorsPalete.primary,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 30,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: ColorsPalete.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ImageIcon(
                                    AssetImage(
                                        'assets/images/icon/profile.png'),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    appProvider.user!.name,
                                    style: GoogleFonts.nunito(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: ColorsPalete.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ImageIcon(
                                    AssetImage('assets/images/icon/email.png'),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    appProvider.user!.email,
                                    style: GoogleFonts.nunito(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 20,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: ColorsPalete.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ImageIcon(
                                    AssetImage('assets/images/icon/music.png'),
                                  ),
                                ),
                                Container(
                                  child: FutureBuilder<
                                          ValueListenable<Box<MusicLike>>>(
                                      future: Provider.of<UserProvider>(context,
                                              listen: false)
                                          .listenLikeMusic(),
                                      builder: (context, listenLikeMusic) {
                                        if (!listenLikeMusic.hasData)
                                          return Text(
                                            '0 Liked Songs',
                                            style: GoogleFonts.nunito(
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          );
                                        return ValueListenableBuilder<
                                                Box<MusicLike>>(
                                            valueListenable:
                                                listenLikeMusic.data!,
                                            builder: (context, listMusicLike,
                                                child) {
                                              return Text(
                                                '${listMusicLike.values.where((element) => element.userId == appProvider.user!.id).length} Liked Songs',
                                                style: GoogleFonts.nunito(
                                                    textStyle: TextStyle(
                                                        color: Colors.white),
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            });
                                      }),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 55,
                            margin: EdgeInsets.only(
                                top: 60,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                color: ColorsPalete.primary,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.25),
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
                                    spreadRadius: -3,
                                  )
                                ]),
                            child: TextButton(
                              onPressed: () => appProvider.removeUser(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Logout',
                                    style: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                            fontSize: 15,
                                            color: ColorsPalete.secondary,
                                            fontWeight: FontWeight.w800)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SpacerMusicPlay()
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );

        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_likes.png'),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorsPalete.primary),
                  child: ImageIcon(
                    AssetImage('assets/images/icon/profile_filled.png'),
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
                    'Profile',
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
                    'Create collection music of a favorite music is posible by login on Kuncie music player',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: EdgeInsets.only(
                      top: 30,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: ColorsPalete.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.25),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: -3,
                        )
                      ]),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => WrapperAuth()),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: ColorsPalete.secondary,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
