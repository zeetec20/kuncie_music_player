import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuncie/utils/colors_palete.dart';

class DialogWidget {
  static Future showLoadingDialog(BuildContext context) async {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Center(
                    child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xA2000000),
                                  blurRadius: 5,
                                  spreadRadius: -4)
                            ],
                            borderRadius: BorderRadius.circular(50)),
                        child: SizedBox(
                          width: 27,
                          height: 27,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff468AEF)),
                          ),
                        ))),
              ));
        });
    await Future.delayed(Duration(milliseconds: 150));
  }

  static Dialog error(BuildContext context, String message) {
    return Dialog(
      backgroundColor: ColorsPalete.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Icon(
                Icons.error_rounded,
                size: 43,
                color: Color(0xFFF05050),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 25, right: 25),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: ColorsPalete.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: ColorsPalete.secondary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Dialog warning(BuildContext context, String message) {
    return Dialog(
      backgroundColor: ColorsPalete.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Icon(
                Icons.warning_rounded,
                size: 43,
                color: Color(0xFFE6C24E),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 25, right: 25),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: ColorsPalete.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: ColorsPalete.secondary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
