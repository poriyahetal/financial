import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/AllQueLevelOne.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

//ignore: must_be_immutable
class LevelOneSetUpPage extends StatefulWidget {
  User? user;
  PageController controller = PageController();

  LevelOneSetUpPage({Key? key, required this.controller, this.user})
      : super(key: key);

  @override
  _LevelOneSetUpPageState createState() => _LevelOneSetUpPageState();
}

class _LevelOneSetUpPageState extends State<LevelOneSetUpPage> {
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
                      'Level 1',
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
                  'Smart Money',
                  style: GoogleFonts.workSans(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: displayHeight(context) * .03,
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
                                ' Do you think you are smart with your money?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Color(0xff6448E8),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 19.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: displayHeight(context) * .02,
                                  left: displayWidth(context) * .05,
                                  right: displayWidth(context) * .05),
                              child: Text(
                                'It\'s your birthday week and  your generous Aunt has gifted you \$200 !',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: displayWidth(context) * .04,
                                  left: displayWidth(context) * .06,
                                  right: displayWidth(context) * .06),
                              child: Text(
                                'Let\'s see how smartly \n you spend it.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.workSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
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
                      var userId;
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      userId = pref.getString('uId');
                      DocumentSnapshot document =
                          await firestore.collection('User').doc(userId).get();
                      gameScore = document.get('game_score');
                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(userId)
                          .update({
                        'account_balance': 200,
                        'quality_of_life': 0,
                        'bill_payment': 0,
                        'credit_card_balance': 0,
                        'credit_card_bill': 0,
                        'payable_bill': 0,
                        'level_id': 0,
                        'previous_session_info': 'Level_1',
                        'need': 0,
                        'want': 0,
                      });
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: AllQueLevelOne(
                                billPayment: 0,
                                gameScore: gameScore,
                                level: 'Level_1',
                                levelId: 0,
                                qOl: 0,
                                savingBalance: 200,
                                creditCardBalance: 0,
                                creditCardBill: 0,
                                payableBill: 0,
                              ),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 250)));
                    },
                    child: GradientText(
                        text: 'Start Spending',
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
