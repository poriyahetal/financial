import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/RentPlan.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

//ignore: must_be_immutable
class LevelThreeSetUpPage extends StatefulWidget {
  User? user;
  PageController controller = PageController();

  LevelThreeSetUpPage({Key? key, required this.controller, this.user})
      : super(key: key);

  @override
  _LevelThreeSetUpPageState createState() => _LevelThreeSetUpPageState();
}

class _LevelThreeSetUpPageState extends State<LevelThreeSetUpPage> {
  get uid => widget.user!.uid;

  get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    //var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
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
                      'Level 3',
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
                  'Credit Karma',
                  style: GoogleFonts.workSans(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: displayHeight(context) * .03,
                ),
                Container(
                  alignment: Alignment.center,
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
                                top: displayWidth(context) * .03,
                                right: displayWidth(context) * .09,
                                left: displayWidth(context) * .09,
                              ),
                              child: Text(
                                ' Congratulations!',
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
                                  left: displayWidth(context) * .04,
                                  right: displayWidth(context) * .04),
                              child: Text(
                                'You\’ve just been given your first credit card. It has a credit limit of \$2000.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: displayWidth(context) * .02,
                                  left: displayWidth(context) * .02,
                                  right: displayWidth(context) * .02),
                              child: Text(
                                'A high Credit Score shows you can be trusted to pay back the money you owe. A good score helps you get home and other loans cheaper!',
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
                                  top: displayWidth(context) * .02,
                                  left: displayWidth(context) * .05,
                                  right: displayWidth(context) * .05),
                              child: Text(
                                'Your Goal in this level is to achieve a Credit Score above 750.',
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
                      addData() async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        var userId = pref.getString('uId');
                        print('UserId :$userId');
                        FirebaseFirestore.instance
                            .collection('User')
                            .doc(userId)
                            .update({
                          'account_balance': 0,
                          'credit_card_balance': 0,
                          'credit_card_bill': 0,
                          'bill_payment': globalVar,
                          'quality_of_life': 0,
                        });
                      }

                      addData();
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: RentPlan(),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 250)));
                    },
                    child: GradientText(
                        text: 'Let’s Go',
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
            ),
          )),
    ));
  }
}
