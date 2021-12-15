import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/ProfilePage.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      // extendBodyBehindAppBar: true,
      body: Container(
        decoration: boxDecoration,
        width: displayWidth(context),
        height: displayHeight(context),
        child: Column(
          children: [
            SizedBox(
              height: displayHeight(context) * .08,
            ),
            Text(
              'finshark',
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: displayHeight(context) * .08,
            ),
            Image.asset(
              'assets/comingSoon.png',
              width: displayWidth(context) * .90,
              height: displayHeight(context) * .20,
            ),
            SizedBox(
              height: displayHeight(context) * .05,
            ),
            Text(
              'COMING SOON',
              style: GoogleFonts.balooDa(
                  color: Color(0xffFFD25E),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: displayHeight(context) * .02,
            ),
            Container(
              height: displayHeight(context) * .18,
              width: displayWidth(context) * .80,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(displayWidth(context) * .08),
                  color: Color(0xff6A6BEF)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * .06,
                    vertical: displayWidth(context) * .04),
                child: Center(
                  child: Text(
                    'We are under the process of creating something amazing. NEW LEVELS will be live soon!! ',
                    style: GoogleFonts.workSans(
                        color: Colors.white, fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: displayHeight(context) * .08,
            ),
            Container(
              width: displayWidth(context) * .56,
              height: displayHeight(context) * .06,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(displayWidth(context) * .12),
                    ))),
                child: GradientText(
                  text: 'Play Again',
                  style: GoogleFonts.workSans(
                      fontSize: 18.sp, fontWeight: FontWeight.w700),
                  gradient: LinearGradient(colors: [
                    Color(0xff4D6EF2),
                    Color(0xff6448E8),
                  ]),
                ),
                onPressed: () {
                  Future.delayed(
                      Duration(seconds: 1),
                      () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
