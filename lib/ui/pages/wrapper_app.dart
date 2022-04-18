import 'package:flutter/material.dart';
import 'package:kuncie/ui/component/music_player.dart';
import 'package:kuncie/ui/pages/home.dart';
import 'package:kuncie/ui/pages/like.dart';
import 'package:kuncie/ui/pages/profile.dart';
import 'package:kuncie/ui/pages/search.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:provider/provider.dart';

class WrapperApp extends StatelessWidget {
  final PageController pageController = PageController();

  Future movePage(int index) async {
    await pageController.animateToPage(index,
        duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Provider.of<AppProvider>(context, listen: false).checkUser(),
        builder: (context, snapshot) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                decoration:
                    BoxDecoration(color: ColorsPalete.secondary, boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      offset: Offset(0, -2),
                      blurRadius: 12,
                      spreadRadius: -8)
                ]),
                child: Consumer<AppProvider>(
                    builder: (context, appProvider, child) {
                  return BottomNavigationBar(
                    currentIndex: appProvider.page,
                    onTap: (index) => movePage(index),
                    backgroundColor: ColorsPalete.secondary,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: ImageIcon(
                            AssetImage('assets/images/icon/home.png'),
                            color: Colors.white,
                          ),
                          activeIcon: ImageIcon(
                            AssetImage('assets/images/icon/home.png'),
                            color: ColorsPalete.primary,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: ImageIcon(
                            AssetImage('assets/images/icon/music.png'),
                            color: Colors.white,
                          ),
                          activeIcon: ImageIcon(
                            AssetImage('assets/images/icon/music.png'),
                            color: ColorsPalete.primary,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: ImageIcon(
                            AssetImage('assets/images/icon/search.png'),
                            color: Colors.white,
                          ),
                          activeIcon: ImageIcon(
                            AssetImage('assets/images/icon/search.png'),
                            color: ColorsPalete.primary,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          backgroundColor: Colors.black,
                          icon: ImageIcon(
                            AssetImage('assets/images/icon/profile.png'),
                            color: Colors.white,
                          ),
                          activeIcon: ImageIcon(
                            AssetImage('assets/images/icon/profile.png'),
                            color: ColorsPalete.primary,
                          ),
                          label: ''),
                    ],
                    type: BottomNavigationBarType.fixed,
                  );
                }),
              ),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (page) =>
                        Provider.of<AppProvider>(context, listen: false)
                            .changePage(page),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      HomePage(),
                      LikePage(),
                      SearchPage(),
                      ProfilePage()
                    ],
                  ),
                  MusicPlayerComponent()
                ],
              ));
        });
  }
}
