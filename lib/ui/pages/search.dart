import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuncie/ui/component/music.dart';
import 'package:kuncie/ui/component/spacer_music_play.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/ui/provider/search_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsPalete.secondary,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_search.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              child: Consumer<SearchProvider>(
                  builder: (context, searchProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: searchProvider.musics.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    searchProvider.musics.isNotEmpty
                        ? SizedBox(
                            key: UniqueKey(),
                          )
                        : Container(
                            child: Text(
                              'Search music\nFor your moods',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                    Container(
                      height: 53,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 40,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          bottom: searchProvider.musics.isEmpty ? 40 : 0),
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: Offset(0, 3),
                              blurRadius: 8,
                              spreadRadius: -3,
                            )
                          ]),
                      child: TextField(
                        controller: searchProvider.searchController,
                        cursorColor: ColorsPalete.primary,
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.nunito(
                            textStyle:
                                TextStyle(fontSize: 14, color: Colors.white)),
                        onSubmitted: (value) =>
                            searchProvider.searchMusic(context),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14)),
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                await searchProvider.searchMusic(context);
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 14, bottom: 14),
                                  child: ImageIcon(
                                    AssetImage('assets/images/icon/search.png'),
                                    color: ColorsPalete.primary,
                                  )),
                            ),
                            border: InputBorder.none,
                            hintText: 'Search...'),
                      ),
                    ),
                    searchProvider.musics.isNotEmpty
                        ? Expanded(
                            child: ListView(
                              key: UniqueKey(),
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                ...searchProvider.musics
                                    .map((e) => MusicComponent(
                                        e,
                                        searchProvider.musics,
                                        SourceMusic.search))
                                    .toList(),
                                SpacerMusicPlay()
                              ],
                            ),
                          )
                        : SizedBox(),
                    searchProvider.musics.isNotEmpty
                        ? SizedBox()
                        : SpacerMusicPlay()
                  ],
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
