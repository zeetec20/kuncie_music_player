import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuncie/service/auth_result.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/login_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:kuncie/utils/dialog_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage(this.toRegister);
  final Function toRegister;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsPalete.secondary,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_login.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width * 0.05, top: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: ColorsPalete.primary,
                  size: 35,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  color: ColorsPalete.primary),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hay welcome to Kuncie music app please login to unlock all feature',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 50,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        'Email',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: ColorsPalete.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      return Container(
                        height: 55,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: 5,
                            left: size.width * 0.05,
                            right: size.width * 0.05),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffF3F6F8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: Offset(0, 3),
                                blurRadius: 8,
                                spreadRadius: -3,
                              )
                            ]),
                        child: TextField(
                          key: Key('email-field'),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (e) => loginProvider.validateEmail(),
                          controller: loginProvider.emailController,
                          textAlignVertical: TextAlignVertical.center,
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                            fontSize: 15,
                          )),
                          decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                child: ImageIcon(
                                  AssetImage('assets/images/icon/email.png'),
                                  color: ColorsPalete.secondary,
                                  size: 5,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Email'),
                        ),
                      );
                    }),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      if (loginProvider.submited &&
                          loginProvider.emailValidate?.message != null)
                        return Container(
                          key: Key('email-validate-field'),
                          margin: EdgeInsets.only(
                              top: 5,
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Text(
                            loginProvider.emailValidate!.message!,
                            style: TextStyle(fontSize: 11, color: Colors.red),
                          ),
                        );
                      return SizedBox();
                    }),
                    Container(
                      margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.05,
                          right: size.width * 0.05),
                      child: Text(
                        'Password',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            color: ColorsPalete.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      return Container(
                        height: 55,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: 5,
                            left: size.width * 0.05,
                            right: size.width * 0.05),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: Offset(0, 3),
                                blurRadius: 8,
                                spreadRadius: -3,
                              )
                            ]),
                        child: TextField(
                          key: Key('password-field'),
                          obscureText: !loginProvider.showPassword,
                          onChanged: (e) => loginProvider.validatePassword(),
                          controller: loginProvider.passwordController,
                          textAlignVertical: TextAlignVertical.center,
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                            fontSize: 15,
                          )),
                          decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                child: ImageIcon(
                                  AssetImage('assets/images/icon/password.png'),
                                  color: ColorsPalete.secondary,
                                  size: 5,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    loginProvider.showAndHidePassword(),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: loginProvider.showPassword
                                      ? ColorsPalete.primary
                                      : Colors.grey[500],
                                  size: 24,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Password'),
                        ),
                      );
                    }),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                      if (loginProvider.submited &&
                          loginProvider.passwordValidate?.message != null)
                        return Container(
                          key: Key('password-validate-field'),
                          margin: EdgeInsets.only(
                              top: 5,
                              left: size.width * 0.05,
                              right: size.width * 0.05),
                          child: Text(
                            loginProvider.passwordValidate!.message!,
                            style: TextStyle(fontSize: 11, color: Colors.red),
                          ),
                        );
                      return SizedBox();
                    }),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(
                          top: 40,
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
                      child: Consumer2<LoginProvider, AppProvider>(builder:
                          (context, loginProvider, appProvider, child) {
                        return TextButton(
                          key: Key('sign-in-button'),
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // DialogWidget.showLoading(context);
                            AuthResult response = await loginProvider.login();
                            if (response.success) {
                              await appProvider.setUser(response.user!);
                              return Navigator.pop(context);
                            }
                            if (loginProvider.validate)
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DialogWidget.error(
                                        context, response.message!);
                                  });
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: ColorsPalete.secondary,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 15,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                          bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have a account ? ',
                                  style: GoogleFonts.nunito(
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextSpan(
                                    text: 'Register',
                                    style: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                            color: ColorsPalete.primary)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .resetForm();
                                        toRegister();
                                      })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
