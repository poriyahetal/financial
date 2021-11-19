import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/RentPlan.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

//ignore: must_be_immutable
class LevelTwoSetUpPage extends StatefulWidget {
  User? user;
  PageController controller = PageController();

  LevelTwoSetUpPage({Key? key, required this.controller, this.user})
      : super(key: key);

  @override
  _LevelTwoSetUpPageState createState() => _LevelTwoSetUpPageState();
}

class _LevelTwoSetUpPageState extends State<LevelTwoSetUpPage> {
  get uid => widget.user!.uid;

  get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    return SafeArea(
        child: Container(
      width: displayWidth(context),
      height: displayHeight(context),
      decoration: boxDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: displayHeight(context) * .08,
                ),
                Center(
                  child: Container(
                    height: displayHeight(context) * .08,
                    width: displayWidth(context) * .62,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(displayWidth(context) * .14),
                      color: Color(0xffEF645B),
                    ),
                    child: Center(
                        child: Text(
                      'Level 2',
                      style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .04,
                ),
                Text(
                  'Smart Saver',
                  style: GoogleFonts.workSans(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: displayHeight(context) * .04,
                ),
                Container(
                  width: displayWidth(context) * .80,
                  height: displayHeight(context) * .48,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(displayWidth(context) * .09)),
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: 00,
                          right: 00,
                          child: Image.asset(
                            'assets/mastGroup.png',
                            width: displayWidth(context) * .06.h,
                            alignment: Alignment.bottomRight,
                          )),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: displayWidth(context) * .04,
                                right: displayWidth(context) * .09,
                                left: displayWidth(context) * .09,
                              ),
                              child: Text(
                                ' Let\'s test your budgeting skills!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Color(0xff6448E8),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: displayHeight(context) * .02,
                                  left: displayWidth(context) * .09,
                                  right: displayWidth(context) * .09),
                              child: Text(
                                'You\'ve just taken up a new job and moved to a new new city.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: displayHeight(context) * .01,
                                  left: displayWidth(context) * .09,
                                  right: displayWidth(context) * .09),
                              child: Text(
                                'Your goal is to save 20% of your income while paying all your basic expenses',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: displayWidth(context) * .03,
                                  left: displayWidth(context) * .14,
                                  right: displayWidth(context) * .14),
                              child: Text(
                                'Go to next screen to set up your basic expenses.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: displayHeight(context) * .08,
                  width: displayWidth(context) * .75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(displayWidth(context) * .12)),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentPlan()));
                    },
                    child: GradientText(
                        text: 'Let\'s Go',
                        style: GoogleFonts.workSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xff6D00C2)],
                            transform: GradientRotation(math.pi / 2))),
                  ),
                ),
                Spacer(),
              ],
            )),
      ),
    ));
  }
}
