import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuncie/service/auth_result.dart';
import 'package:kuncie/ui/provider/register_provider.dart';
import 'package:kuncie/utils/colors_palete.dart';
import 'package:kuncie/utils/dialog_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage(this.toLogin);
  final Function toLogin;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsPalete.secondary,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_register.png'),
              fit: BoxFit.cover),
        ),
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
                              'Register',
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
                              'Hay welcome to kuncie music app please sign in to unlock all feature',
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
                            top: 35,
                            left: size.width * 0.05,
                            right: size.width * 0.05),
                        child: Text(
                          'Name',
                          style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                              color: ColorsPalete.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      Consumer<RegisterProvider>(
                          builder: (context, registerProvider, child) {
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
                            key: Key('name-field'),
                            keyboardType: TextInputType.name,
                            controller: registerProvider.nameController,
                            textAlignVertical: TextAlignVertical.center,
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                              fontSize: 15,
                            )),
                            onChanged: (e) => registerProvider.validateName(),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: EdgeInsets.only(top: 13, bottom: 13),
                                  child: ImageIcon(
                                    AssetImage(
                                        'assets/images/icon/profile.png'),
                                    color: ColorsPalete.secondary,
                                    size: 5,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: 'Name'),
                          ),
                        );
                      }),
                      Consumer<RegisterProvider>(
                          builder: (context, registerProvider, child) {
                        if (registerProvider.submited &&
                            registerProvider.nameValidate?.message != null)
                          return Container(
                            key: Key('name-validate-field'),
                            margin: EdgeInsets.only(
                                top: 5,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Text(
                              registerProvider.nameValidate!.message!,
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
                      Consumer<RegisterProvider>(
                          builder: (context, registerProvider, child) {
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
                            key: Key('email-field'),
                            keyboardType: TextInputType.emailAddress,
                            controller: registerProvider.emailController,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            onChanged: (e) => registerProvider.validateEmail(),
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
                      Consumer<RegisterProvider>(
                          builder: (context, registerProvider, child) {
                        if (registerProvider.submited &&
                            registerProvider.emailValidate?.message != null)
                          return Container(
                            key: Key('email-validate-field'),
                            margin: EdgeInsets.only(
                                top: 5,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Text(
                              registerProvider.emailValidate!.message!,
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
                      Consumer<RegisterProvider>(
                          builder: (context, registerProvider, child) {
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
                            obscureText: !registerProvider.showPassword,
                            onChanged: (e) =>
                                registerProvider.validatePassword(),
                            controller: registerProvider.passwordController,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: EdgeInsets.only(top: 13, bottom: 13),
                                  child: ImageIcon(
                                    AssetImage(
                                        'assets/images/icon/password.png'),
                                    color: ColorsPalete.secondary,
                                    size: 5,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      registerProvider.showAndHidePassword(),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: registerProvider.showPassword
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
                      Consumer<RegisterProvider>(
                          builder: (context, registerProvider, child) {
                        if (registerProvider.submited &&
                            registerProvider.passwordValidate?.message != null)
                          return Container(
                            key: Key('password-validate-field'),
                            margin: EdgeInsets.only(
                                top: 5,
                                left: size.width * 0.05,
                                right: size.width * 0.05),
                            child: Text(
                              registerProvider.passwordValidate!.message!,
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
                        child: Consumer<RegisterProvider>(
                            builder: (context, registerProvider, child) {
                          return TextButton(
                            key: Key('sign-up-button'),
                            onPressed: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              AuthResult response =
                                  await registerProvider.register();
                              if (response.success) return toLogin();

                              if (registerProvider.validate)
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogWidget.error(
                                          context, response.message!);
                                    });
                            },
                            child: Text(
                              'Register',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      color: ColorsPalete.secondary,
                                      fontWeight: FontWeight.w800)),
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
                                    text: 'Have a account ? ',
                                    style: GoogleFonts.nunito(
                                      textStyle: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextSpan(
                                      text: 'Login',
                                      style: GoogleFonts.nunito(
                                          textStyle: TextStyle(
                                              color: ColorsPalete.primary)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Provider.of<RegisterProvider>(context,
                                                  listen: false)
                                              .resetForm();
                                          toLogin();
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
          ),
        ),
      ),
    );
  }
}
