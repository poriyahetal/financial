import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/Screens/AllQueLevelThree.dart';
import 'package:financial/Screens/AllQueLevelTwo.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class AllDone extends StatefulWidget {
  AllDone({
    Key? key,
  }) : super(key: key);

  @override
  _AllDoneState createState() => _AllDoneState();
}

class _AllDoneState extends State<AllDone> {
  //get user id
  var userId;

  getUID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
  }

  @override
  void initState() {
    getUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Container(
            width: displayWidth(context),
            height: displayHeight(context),
            decoration: boxDecoration,
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * .01.h,
                ),
                Container(
                  child: Image.asset(
                    'assets/done.png',
                    height: displayHeight(context) * .40,
                    width: displayWidth(context),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .02,
                ),
                Text(
                  'Yey! All done',
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 28.sp),
                ),
                SizedBox(
                  height: displayHeight(context) * .04,
                ),
                Text(
                  'You can start playing now.',
                  style: GoogleFonts.workSans(
                    color: Color(0xffE7E7E7),
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
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
                    onPressed: () {
                      getUserData();
                    },
                    child: GradientText(
                        text: 'let\'s go',
                        style: GoogleFonts.workSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        gradient: const LinearGradient(
                            colors: [Colors.white, Color(0xff6448E8)],
                            transform: GradientRotation(math.pi / 2))),
                  ),
                ),
                Spacer(),
              ],
            ),
          )),
    );
  }

  getUserData() async {
    String level;
    bool replayLevel;
    FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .get()
        .then((doc) => {
      level = doc.get("previous_session_info"),
      gameScore = doc.get('game_score'),
      replayLevel = doc.get('replay_level'),
      if (level == 'Level_2_setUp_page')
        {
          FirebaseFirestore.instance
              .collection('User')
              .doc(userId)
              .update({
            'bill_payment': globalVar,
            'previous_session_info': 'Level_2',
            if(replayLevel != true) 'last_level': 'Level_2',
            'game_score': gameScore,
            'account_balance': 0,
            'quality_of_life': 0,
            'level_id': 0,
            'credit_card_balance': 0,
            'credit_card_bill': 0,
            'credit_score': 0,
            'payable_bill': 0,
            'replay_level': false,
            'score': 0,
            'need': 0,
            'want': 0,
            'level_2_id' : 0,
          }),
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AllQueLevelTwo(
                        savingBalance: 0,
                        qOl: 0,
                        levelId: 0,
                        gameScore: gameScore,
                        billPayment: globalVar,
                        level: 'Level_2',
                        payableBill: 0,
                        creditCardBill: 0,
                        creditCardBalance: 0,
                      ))),
        },
      if (level == 'Level_3_setUp_page')
        {
          FirebaseFirestore.instance
              .collection('User')
              .doc(userId)
              .update({
            'bill_payment': globalVar,
            'credit_card_bill': 0,
            'previous_session_info': 'Level_3',
            if(replayLevel != true) 'last_level': 'Level_3',
            'game_score': gameScore,
            'credit_card_balance': 2000,
            'account_balance': 0,
            'level_id': 0,
            'credit_score': 350,
            'quality_of_life': 0,
            'payable_bill': 0,
            'score': 350,
            'need': 0,
            'want': 0,
            'level_3_id' : 0,
            'replay_level': false,
          }),
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AllQueLevelThree(
                        savingBalance: 0,
                        qOl: 0,
                        levelId: 0,
                        gameScore: gameScore,
                        billPayment: globalVar,
                        level: 'Level_3',
                        creditCardBalance: 500,
                        creditCardBill: 0,
                        payableBill: 0,
                      ))),
        }
    });
  }
}
