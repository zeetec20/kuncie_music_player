import 'package:flutter/material.dart';
import 'package:kuncie/ui/pages/auth/login.dart';
import 'package:kuncie/ui/pages/auth/register.dart';

class WrapperAuth extends StatelessWidget {
  final PageController pageController = PageController();

  Future movePage(int index) async {
    await pageController.animateToPage(index,
        duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoginPage(() => movePage(1)),
          RegisterPage(() => movePage(0))
        ],
      ),
    );
  }
}
