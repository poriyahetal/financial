import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/Screens/AllQueLevelOne.dart';
import 'package:financial/Screens/AllQueLevelThree.dart';
import 'package:financial/Screens/AllQueLevelTwo.dart';
import 'package:financial/ReusableScreen/ExpandedBottomDrawer.dart';
import 'package:financial/ReusableScreen/GameScorePage.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/IntroScreen.dart';
import 'package:financial/Screens/LevelThreeSetUpPage.dart';
import 'package:financial/Screens/LevelTwoSetUpPage.dart';
import 'package:financial/Screens/PopQuiz.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:financial/Screens/LevelOneSetUpPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //to get user id
  var userId;

  //for get all value from firestore
  String level = ' ';
  int levelId = 0;
  int billPayment = 0;
  int creditCardBalance = 0;
  int creditCardBill = 0;
  int payableBill = 0;
  int creditScore = 0;

  //function for get all value from firestore and check user state
  getUID() async {
    //get user id
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString('uId');
    print('UserId $userId');

    //if user id available than check there state and move to that position
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .get()
          .then((doc) => {
                level = doc.get("previous_session_info"),
                levelId = doc.get("level_id"),
                billPayment = doc.get("bill_payment"),
                creditCardBalance = doc.get("credit_card_balance"),
                creditCardBill = doc.get('credit_card_bill'),
                payableBill = doc.get('payable_bill'),
                qualityOfLife = doc.get("quality_of_life"),
                balance = doc.get("account_balance"),
                creditScore = doc.get("credit_score"),
                gameScore = doc.get("game_score"),
              })
          .then((value) {
        if (level == '') {
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LevelOneSetUpPage(controller: PageController()))));
        }

        if (level == 'Level_1')
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllQueLevelOne(
                          level: level,
                          levelId: levelId,
                          billPayment: billPayment,
                          qOl: qualityOfLife,
                          savingBalance: balance,
                          creditCardBalance: creditCardBalance,
                          creditCardBill: creditCardBill,
                          payableBill: payableBill,
                          gameScore: gameScore))));

        if (level == 'Level_2_setUp_page') {
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LevelTwoSetUpPage(controller: PageController()))));
        }

        if (level == 'Level_2')
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllQueLevelTwo(
                          level: level,
                          levelId: levelId,
                          billPayment: billPayment,
                          qOl: qualityOfLife,
                          savingBalance: balance,
                          creditCardBalance: creditCardBalance,
                          creditCardBill: creditCardBill,
                          payableBill: payableBill,
                          gameScore: gameScore))));

        if (level == 'Level_2_Pop_Quiz') {
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => PopQuiz())));
        }
        if (level == 'Level_3_setUp_page') {
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LevelThreeSetUpPage(controller: PageController()))));
        }

        if (level == 'Level_3') {
          Future.delayed(
              Duration(seconds: 6),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllQueLevelThree(
                          level: level,
                          levelId: levelId,
                          billPayment: billPayment,
                          qOl: qualityOfLife,
                          savingBalance: balance,
                          creditCardBalance: creditCardBalance,
                          creditCardBill: creditCardBill,
                          payableBill: payableBill,
                          gameScore: gameScore))));
        }

        if (level == 'Level_3_Pop_Quiz') {
          Future.delayed(
              Duration(seconds: 6),
                  () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => PopQuiz())));
        }
      });
    } else {
      //if user not login than move to intro screen
      Future.delayed(
          Duration(seconds: 6),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => IntroScreen())));
    }
  }

  @override
  void initState() {
    getUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        decoration: boxDecoration,
        child: Center(
            child: Text(
          'finshark',
          style: GoogleFonts.workSans(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
