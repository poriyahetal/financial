// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:financial/ReusableScreen/GlobleVariable.dart';
// import 'package:financial/Screens/AllQueLevelOne.dart';
// import 'package:financial/Screens/LevelFourHouseRent.dart';
// import 'package:financial/Screens/LevelThreeSetUpPage.dart';
// import 'package:financial/Screens/LevelTwoSetUpPage.dart';
// import 'package:financial/Screens/PopQuiz.dart';
// import 'package:financial/Screens/devicesSizePage.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   var userId;
//   String level = ' ';
//   int lev = 0;
//   int i = 0;
//
//   getLevel() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     userId = pref.getString('uId');
//     DocumentSnapshot documentSnapshot =
//         await firestore.collection('User').doc(userId).get();
//     level = documentSnapshot.get('last_level');
//     print(level.toString().substring(6, 7));
//     level = level.toString().substring(6, 7);
//     setState(() {
//       lev = int.parse(level);
//     });
//   }
//
//   @override
//   void initState() {
//     getLevel();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         alignment: Alignment.center,
//         width: displayWidth(context),
//         height: displayHeight(context),
//         decoration: boxDecoration,
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: DoubleBackToCloseApp(
//             snackBar: const SnackBar(
//               content: Text('Tap back again to leave'),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: lev >= 1
//                           ? MaterialStateProperty.all(Colors.green)
//                           : MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                       i = 1;
//                       lev >= 1 ? _showDialog(i) : Container();
//                     },
//                     child: Text(
//                       'Level 1 : Smart Money',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: lev >= 2
//                           ? MaterialStateProperty.all(Colors.green)
//                           : MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                       print('yes');
//                       lev >= 2 ? _showDialog(2) : Container();
//                     },
//                     child: Text(
//                       'Level 2 : Smart Savers',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: lev >= 2
//                           ? MaterialStateProperty.all(Colors.green)
//                           : MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                       lev >= 2
//                           ? firestore.collection('User').doc(userId).update({
//                               'previous_session_info': 'Level_2_Pop_Quiz',
//                               'replay_level': true,
//                             }).then((value) {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => PopQuiz()));
//                             })
//                           : Container();
//                     },
//                     child: Text(
//                       'Level 2 Pop Quiz',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: lev >= 3
//                           ? MaterialStateProperty.all(Colors.green)
//                           : MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                       print('yes');
//                       lev >= 3 ? _showDialog(3) : Container();
//                     },
//                     child: Text(
//                       'Level 3 : Building Credit',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: lev >= 3
//                           ? MaterialStateProperty.all(Colors.green)
//                           : MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                       lev >= 3
//                           ? firestore.collection('User').doc(userId).update({
//                               'previous_session_info': 'Level_3_Pop_Quiz',
//                               'replay_level': true,
//                             }).then((value) {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => PopQuiz()));
//                             })
//                           : Container();
//                     },
//                     child: Text(
//                       'Level 3 Pop Quiz',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 lev >= 4
//                     ? TextButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.green),
//                         ),
//                         onPressed: () {
//                           print('yes');
//                           _showDialog(4);
//                         },
//                         child: Text(
//                           'Level 4 : Building Assets',
//                           style: TextStyle(color: Colors.white),
//                         ))
//                     : TextButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.grey),
//                         ),
//                         onPressed: () {},
//                         child: Text(
//                           'Level 4 : Building Assets',
//                           style: TextStyle(color: Colors.white),
//                         )),
//                 lev >= 5
//                     ? TextButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.green),
//                         ),
//                         onPressed: () {
//                           print('yes');
//                           _showDialog(5);
//                         },
//                         child: Text(
//                           'Level 5 : Stock Play',
//                           style: TextStyle(color: Colors.white),
//                         ))
//                     : TextButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.grey),
//                         ),
//                         onPressed: () {},
//                         child: Text(
//                           'Level 5 : Stock Play',
//                           style: TextStyle(color: Colors.white),
//                         )),
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LevelFourHouseRent()));
//                     },
//                     child: Text(
//                       'Level 4 setUp Page',
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _showDialog(int i) async {
//     DocumentSnapshot document =
//         await firestore.collection('User').doc(userId).get();
//     gameScore = document.get('game_score');
//     print('i $i');
//     return showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             // actionsPadding: EdgeInsets.all(8.0),
//             backgroundColor: Color(0xff6646E6),
//             title: Text(
//               'Replay Level ?',
//               style: TextStyle(color: Colors.white, fontSize: 16.sp),
//             ),
//             actions: [
//               ElevatedButton(
//                   onPressed: () {
//                     print('ii $i');
//                     if (i == 1) {
//                       FirebaseFirestore.instance
//                           .collection('User')
//                           .doc(userId)
//                           .update({
//                         'replay_level': true,
//                         'credit_score': 0,
//                         'score': 0,
//                         'account_balance': 200,
//                         'quality_of_life': 0,
//                         'bill_payment': 0,
//                         'credit_card_balance': 0,
//                         'credit_card_bill': 0,
//                         'payable_bill': 0,
//                         'level_id': 0,
//                         'previous_session_info': 'Level_1',
//                         'need': 0,
//                         'want': 0,
//                       }).then((value) => Navigator.pushReplacement(
//                               context,
//                               PageTransition(
//                                   child: AllQueLevelOne(
//                                     billPayment: 0,
//                                     gameScore: gameScore,
//                                     level: 'Level_1',
//                                     levelId: 0,
//                                     qOl: 0,
//                                     savingBalance: 200,
//                                     creditCardBalance: 0,
//                                     creditCardBill: 0,
//                                     payableBill: 0,
//                                   ),
//                                   duration: Duration(milliseconds: 500),
//                                   type: PageTransitionType.bottomToTop)));
//                     }
//
//                     if (i == 2) {
//                       _updateValue(i);
//                       Navigator.pushReplacement(
//                           context,
//                           PageTransition(
//                               child: LevelTwoSetUpPage(
//                                 controller: PageController(),
//                               ),
//                               duration: Duration(milliseconds: 500),
//                               type: PageTransitionType.bottomToTop));
//                     }
//
//                     if (i == 3) {
//                       _updateValue(i);
//                       Navigator.pushReplacement(
//                           context,
//                           PageTransition(
//                               child: LevelThreeSetUpPage(
//                                 controller: PageController(),
//                               ),
//                               duration: Duration(milliseconds: 500),
//                               type: PageTransitionType.bottomToTop));
//                     }
//                   },
//                   child: Text(
//                     'Yes',
//                     style: TextStyle(color: Colors.white, fontSize: 14.sp),
//                   )),
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('No',
//                       style: TextStyle(color: Colors.white, fontSize: 14.sp))),
//             ],
//           );
//         });
//   }
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/Model/ProfilePageModel.dart';
import 'package:financial/Model/QueModel.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/AllQueLevelOne.dart';
import 'package:financial/Screens/LevelThreeSetUpPage.dart';
import 'package:financial/Screens/LevelTwoSetUpPage.dart';
import 'package:financial/Screens/PopQuiz.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //for model
  QueModel? queModel;
  var userId;
  List<QueModel> list = [];
  int level1Id = 0;
  int level2Id = 0;
  int level3Id = 0;
  int level4Id = 0;
  int level5Id = 0;
  int level6Id = 0;
  int level2popQuizId = 0;
  int level3popQuizId = 0;
  int level1totalQue = 0;
  int level2totalQue = 0;
  int level3totalQue = 0;
  int level4totalQue = 0;
  int level5totalQue = 0;
  int level6totalQue = 0;
  int level2popQuizQue = 0;
  int level3popQuizQue = 0;
  String? level;
  int lev = 0;

  Future<QueModel?> getLevelId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    print('UserId $userId');
    QuerySnapshot<Map<String, dynamic>>? l1 =
        await firestore.collection('Level_1').get();
    QuerySnapshot<Map<String, dynamic>>? l2 =
        await firestore.collection('Level_2').get();
    QuerySnapshot<Map<String, dynamic>>? l3 =
        await firestore.collection('Level_3').get();
    QuerySnapshot<Map<String, dynamic>>? l2PopQuiz =
        await firestore.collection('Level_2_Pop_Quiz').get();
    QuerySnapshot<Map<String, dynamic>>? l3PopQuiz =
        await firestore.collection('Level_3_Pop_Quiz').get();
    DocumentSnapshot shot =
        await FirebaseFirestore.instance.collection("User").doc(userId).get();
    setState(() {
      level1Id = shot.get('level_1_id');
      level2Id = shot.get('level_2_id');
      level3Id = shot.get('level_3_id');
      level4Id = shot.get('level_4_id');
      level5Id = shot.get('level_5_id');
      level6Id = shot.get('level_6_id');
      level2popQuizId = shot.get('level_2_popQuiz_id');
      level3popQuizId = shot.get('level_3_popQuiz_id');
      level1totalQue = l1.size;
      level2totalQue = l2.size;
      level3totalQue = l3.size;
      print(level3totalQue);
      level2popQuizQue = l2PopQuiz.size;
      level3popQuizQue = l3PopQuiz.size;
      level = shot.get('last_level');
    });
    lev = int.parse(level.toString().substring(6, 7));
  }

  List<ProfilePageModel> levelList = [
    ProfilePageModel(
        id: 1,
        description:
            'Be smart with your money. Learn to differentiate between Needs and Wants.',
        level: 'Honey Pot',
        goal: 'Goal : Don’t run out of your \$200 budget.',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 2,
        description:
            'Master the art of budgeting by learning a simple framework for allocating your cash.',
        level: 'Smart Savers',
        goal: 'Goal : Save 20% of your monthly income.',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 3,
        description:
            'Understand how Credit Scores work and learn to build a good Credit Rating.',
        level: 'Credit Karma',
        goal: 'Goal : Reach a Credit Score of 750.',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 4,
        description:
            'Learn the concept of Time Value of Money and to use Compounding to grow your money.',
        level: 'Building Up',
        goal: '',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 5,
        description: 'Learn to Invest in Stocks and to build a portfolio.',
        level: 'Stock Play',
        goal: '',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 6,
        description: 'Play in multiplayer mode and outscore your friends.',
        level: 'Super Sprint',
        goal: '',
        levelProgress: '10',
        popQuizProgress: '10'),
  ];

  @override
  void initState() {
    getLevelId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: boxDecoration,
          child: level == null
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(backgroundColor: Color(0xff4D6EF2)))
              : ListView(
                  children: [
                    SizedBox(
                      height: displayHeight(context) * .02,
                    ),
                    Center(
                      child: Container(
                        height: displayHeight(context) * .08,
                        width: displayWidth(context) * .50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              displayWidth(context) * .14),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: displayWidth(context) * .12,
                              height: displayHeight(context) * .08,
                              child: Image.asset(
                                'assets/profile.png',
                              ),
                            ),
                            GradientText(
                                text: 'Profile',
                                style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w600),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff4D5DDD),
                                    Color(0xff6D00C2),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * .03,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: levelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: levelList[index].id == 1
                              ? displayHeight(context) * .27
                              : displayHeight(context) * .34,
                          width: displayWidth(context) * .99,
                          //color: Colors.red,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: levelList[index].id == 1
                                    ? displayHeight(context) * .22
                                    :displayHeight(context) * .29,
                                width: displayWidth(context) * .86,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    displayWidth(context) * .06,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:  displayWidth(context) * .05,
                                        left: displayWidth(context) * .02,
                                        right: displayWidth(context) * .02,
                                      ),
                                      child: Text(
                                        '${levelList[index].description}',
                                        style: GoogleFonts.roboto(
                                            color: Color(0xff563DC1),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                   if(levelList[index].id! <= 3)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: displayWidth(context) * .01,
                                          bottom: displayWidth(context) * .02,
                                          //bottom: displayWidth(context) * .02,
                                        ),
                                        child: Text(
                                          '${levelList[index].goal}',
                                          style: GoogleFonts.roboto(
                                              color: Color(0xff818186),
                                              fontSize: 09.sp,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    if(levelList[index].id! > 3)  SizedBox(height: displayWidth(context) * .03,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        LinearPercentIndicator(
                                          animation: true,
                                          lineHeight:
                                              displayHeight(context) * .04,
                                          width: displayWidth(context) * .60,
                                          animationDuration: 1000,
                                          percent: levelList[index].id == 1
                                              ? (level1Id.toDouble() /
                                                  level1totalQue)
                                              : levelList[index].id == 2
                                                  ? (level2Id.toDouble() /
                                                      level2totalQue)
                                                  : levelList[index].id == 3
                                                      ? (level3Id.toDouble() /
                                                          level3totalQue)
                                                      : levelList[index].id == 4
                                                          ? (level4Id
                                                                  .toDouble() /
                                                              50)
                                                          : levelList[index]
                                                                      .id ==
                                                                  5
                                                              ? (level5Id
                                                                      .toDouble() /
                                                                  36)
                                                              : (level6Id
                                                                      .toDouble() /
                                                                  80),
                                          center: Text(
                                            'LEVEL PROGRESS',
                                            style: GoogleFonts.roboto(
                                                fontSize: 10.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor:
                                              levelList[index].id! > lev
                                                  ? Color(0xffFFDAF0)
                                                  : Color(0xffFF3D8E),
                                          backgroundColor: Color(0xffFFDAF0),
                                        ),
                                        GestureDetector(
                                          child: Image.asset(
                                            'assets/replay.png',
                                            width: displayWidth(context) * .08,
                                            height:
                                                displayHeight(context) * .05,
                                          ),
                                          onTap: () {
                                            levelList[index].id! <= lev
                                                ? _updateValue(
                                                    levelList[index].id)
                                                : Container();
                                          },
                                        ),
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                right: displayWidth(context) *
                                                    .22),
                                            child: Text(
                                              levelList[index].id == 1
                                                  ? '${((level1Id * 100) / level1totalQue).ceil()}% COMPLETED'
                                                  : levelList[index].id == 2
                                                      ? '${((level2Id * 100) / level2totalQue).ceil()}% COMPLETED'
                                                      : levelList[index].id == 3
                                                          ? '${((level3Id * 100) / level3totalQue).ceil()}% COMPLETED'
                                                          : levelList[index]
                                                                      .id ==
                                                                  4
                                                              ? '${((level4Id * 100) / 50).ceil()}% COMPLETED'
                                                              : levelList[index]
                                                                          .id ==
                                                                      5
                                                                  ? '${((level5Id * 100) / 36).ceil()}% COMPLETED'
                                                                  : '${((level6Id * 100) / 80).ceil()}% COMPLETED',
                                              style: GoogleFonts.workSans(
                                                  color: Color(0xffC4C4C4),
                                                  fontSize: 08.sp),
                                            ))),
                                    // SizedBox(
                                    //   height: displayHeight(context) * .01,
                                    // ),
                                    levelList[index].id == 1
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              LinearPercentIndicator(
                                                animation: true,
                                                lineHeight:
                                                    displayHeight(context) *
                                                        .04,
                                                width:
                                                    displayWidth(context) * .60,
                                                animationDuration: 1000,
                                                percent: levelList[index].id ==
                                                        2
                                                    ? (level2popQuizId
                                                            .toDouble() /
                                                        level2popQuizQue)
                                                    : levelList[index].id == 3
                                                        ? (level3popQuizId
                                                                .toDouble() /
                                                            level3popQuizQue)
                                                        : levelList[index].id ==
                                                                4
                                                            ? (level4Id
                                                                    .toDouble() /
                                                                50)
                                                            : levelList[index]
                                                                        .id ==
                                                                    5
                                                                ? (level5Id
                                                                        .toDouble() /
                                                                    36)
                                                                : (level6Id
                                                                        .toDouble() /
                                                                    80),
                                                center: Text(
                                                  'POP QUIZ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 10.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                progressColor:
                                                    levelList[index].id! > lev
                                                        ? Color(0xffCDE4FD)
                                                        : Color(0xff409AFF),
                                                backgroundColor:
                                                    Color(0xffCDE4FD),
                                              ),
                                              GestureDetector(
                                                child: levelList[index].id ==
                                                                2 &&
                                                            (((level2popQuizId *
                                                                            100) /
                                                                        level2popQuizQue)
                                                                    .ceil() ==
                                                                100) ||
                                                        levelList[index].id ==
                                                                3 &&
                                                            (((level3popQuizId *
                                                                            100) /
                                                                        level3popQuizQue)
                                                                    .ceil() ==
                                                                100)
                                                    ? Image.asset(
                                                        'assets/right.png',
                                                        width: displayWidth(
                                                                context) *
                                                            .07,
                                                        height: displayHeight(
                                                                context) *
                                                            .05,
                                                      )
                                                    : Image.asset(
                                                        'assets/popQuiz.png',
                                                        width: displayWidth(
                                                                context) *
                                                            .08,
                                                        height: displayHeight(
                                                                context) *
                                                            .05,
                                                      ),
                                                onTap: () {
                                                  levelList[index].id! <= lev
                                                      ? _updatePopQuizValue(
                                                          levelList[index].id,
                                                          true)
                                                      : Container();
                                                },
                                              ),
                                            ],
                                          ),
                                    levelList[index].id == 1
                                        ? Container()
                                        : Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: displayWidth(context) *
                                                      .22),
                                              child: Text(
                                                levelList[index].id == 2
                                                    ? '${((level2popQuizId * 100) / level2popQuizQue).ceil()}% COMPLETED'
                                                    : levelList[index].id == 3
                                                        ? '${((level3popQuizId * 100) / level3popQuizQue).ceil()}% COMPLETED'
                                                        : levelList[index].id ==
                                                                4
                                                            ? '${((level4Id * 100) / 50).ceil()}% COMPLETED'
                                                            : levelList[index]
                                                                        .id ==
                                                                    5
                                                                ? '${((level5Id * 100) / 36).ceil()}% COMPLETED'
                                                                : '${((level6Id * 100) / 80).ceil()}% COMPLETED',
                                                style: GoogleFonts.workSans(
                                                    color: Color(0xffC4C4C4),
                                                    fontSize: 08.sp),
                                              ),
                                            )),
                                     SizedBox(
                                      height: displayHeight(context) * .01,
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: displayHeight(context) * .00,
                                left: displayWidth(context) * .14,
                                child: Container(
                                  width: displayWidth(context) * .48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        displayWidth(context) * .06),
                                    color: Color(0xffFFF1ED),
                                    border:
                                        Border.all(color: Color(0xffFF8762)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: displayWidth(context) * .03),
                                    child: Text(
                                      '${levelList[index].level}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        color: Color(0xffFE845E),
                                      ),
                                    ),
                                  ),
                                ),
                                height: displayHeight(context) * .06,
                              ),
                              Positioned(
                                top: displayHeight(context) * .00,
                                left: displayWidth(context) * .10,
                                width: displayWidth(context) * .18,
                                child: Container(
                                  width: displayWidth(context) * .42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFBC712),
                                  ),
                                  child: levelList[index].id! <= lev
                                      ? Text(
                                          '${levelList[index].id}',
                                          style: GoogleFonts.balooDa(
                                              fontSize: 20.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Container(
                                          height: displayHeight(context) * .04,
                                          child:
                                              Image.asset('assets/lock.png')),
                                ),
                                height: displayHeight(context) * .06,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _updateValue(int? i) async {
    DocumentSnapshot document =
        await firestore.collection('User').doc(userId).get();
    gameScore = document.get('game_score');
    print('i $i');
    firestore.collection('User').doc(userId).update({
      'replay_level': true,
      'account_balance': 0,
      'bill_payment': 0,
      'credit_card_balance': 0,
      'credit_card_bill': 0,
      'credit_score': 0,
      'level_id': 0,
      'payable_bill': 0,
      'previous_session_info': i == 1 ? 'Level_1' : 'Level_$i\_setUp_page',
      'quality_of_life': 0,
      'score': 0,
      'level_1_id': i == 1 ? 0 : level1Id,
      'level_2_id': i == 2 ? 0 : level2Id,
      'level_3_id': i == 3 ? 0 : level3Id,
      'level_4_id': i == 4 ? 0 : level4Id,
      'level_5_id': i == 5 ? 0 : level5Id,
      'level_6_id': i == 6 ? 0 : level6Id,
    }).then((value) {
      if (i == 1)
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
      if (i == 2)
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: LevelTwoSetUpPage(
                  controller: PageController(),
                ),
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.bottomToTop));
      if (i == 3)
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: LevelThreeSetUpPage(
                  controller: PageController(),
                ),
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.bottomToTop));
      if (i == 4)
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
      if (i == 5)
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
      if (i == 6)
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
    });
  }

  _updatePopQuizValue(
    int? i,
    bool value,
  ) async {
    DocumentSnapshot document =
        await firestore.collection('User').doc(userId).get();
    gameScore = document.get('game_score');
    print('i $i');
    firestore.collection('User').doc(userId).update({
      'replay_level': true,
      'account_balance': 0,
      'bill_payment': 0,
      'credit_card_balance': 0,
      'credit_card_bill': 0,
      'credit_score': 0,
      'level_id': 0,
      'payable_bill': 0,
      'previous_session_info': 'Level_$i\_Pop_Quiz',
      'quality_of_life': 0,
      'score': 0,
      'level_1_id': i == 1 ? 0 : level1Id,
      'level_2_id': value == true
          ? level2Id
          : i == 2
              ? 0
              : level2Id,
      'level_3_id': value == true
          ? level3Id
          : i == 3
              ? 0
              : level3Id,
      'level_4_id': i == 4 ? 0 : level4Id,
      'level_5_id': i == 5 ? 0 : level5Id,
      'level_6_id': i == 6 ? 0 : level6Id,
      'level_2_popQuiz_id': i == 2 ? 0 : level2popQuizId,
      'level_3_popQuiz_id': i == 3 ? 0 : level3popQuizId,
    }).then((value) {
      if (i == 2)
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: PopQuiz(levelId: 0),
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 250)));
      if (i == 3)
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: PopQuiz(levelId: 0),
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.bottomToTop));
      if (i == 4)
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
      if (i == 5)
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
      if (i == 6)
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
    });
  }
}
