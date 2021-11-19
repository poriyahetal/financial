import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/Screens/LoginPage.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                          child: Container(
                        width: displayWidth(context),
                        child: Image.asset(
                          'assets/Vector.png',
                          height: displayHeight(context) * .60,
                          width: displayWidth(context),
                          fit: BoxFit.fill,
                        ),
                      )),
                      Positioned(
                          left: displayWidth(context) * .14,
                          right: displayWidth(context) * .14,
                          bottom: displayHeight(context) * .20,
                          child: Center(
                              child: Image.asset(
                            'assets/gameSetup.png',
                            width: displayWidth(context) * .56.w,
                          ))),
                      Positioned(
                          bottom: displayHeight(context) * .05,
                          left: displayWidth(context) * .30,
                          right: displayWidth(context) * .30,
                          child: Center(
                            child: Text(
                              'Welcome !',
                              style: GoogleFonts.workSans(
                                  color: Color(0xff6348E8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp),
                            ),
                          )),
                    ],
                  ),
                  Center(
                      child: Text(
                    'Set up your game',
                    style: GoogleFonts.workSans(
                        color: Color(0xff3D3D3D),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  )),
                  SizedBox(
                    height: displayHeight(context) * .150,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Container(
                        height: displayHeight(context) * .08,
                        width: displayWidth(context) * .60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff4D6EF2),
                              Color(0xff6448E8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(
                              displayWidth(context) * .12),
                        ),
                        child: Center(
                          child: Text(
                            'Let\'s Start',
                            style: GoogleFonts.workSans(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
