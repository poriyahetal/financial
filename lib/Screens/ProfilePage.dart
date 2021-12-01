// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:financial/ReusableScreen/GlobleVariable.dart';
// import 'package:financial/Screens/LevelFourHouseRent.dart';
// import 'package:financial/Screens/LevelOneSetUpPage.dart';
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
//
//                 TextButton(
//                     style: ButtonStyle(
//                       backgroundColor:  MaterialStateProperty.all(Colors.grey),
//                     ),
//                     onPressed: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LevelFourHouseRent()));
//
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
//   _showDialog(int i) {
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
//                       _updateValue(i);
//                       Navigator.pushReplacement(
//                           context,
//                           PageTransition(
//                               child: LevelOneSetUpPage(
//                                 controller: PageController(),
//                               ),
//                               duration: Duration(milliseconds: 500),
//                               type: PageTransitionType.bottomToTop));
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
//   _updateValue(int i) {
//     print('i $i');
//     firestore.collection('User').doc(userId).update({
//       'replay_level': true,
//       'account_balance': 0,
//       'bill_payment': 0,
//       'credit_card_balance': 0,
//       'credit_card_bill': 0,
//       'credit_score': 0,
//       'level_id': 0,
//       'payable_bill': 0,
//       'previous_session_info': 'Level_$i\_setUp_page',
//       'quality_of_life': 0,
//       'score': 0
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/Model/ProfilePageModel.dart';
import 'package:financial/Model/QueModel.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int id = 0;
  String? level ;

  Future<QueModel?> getLevelId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Level_1").get();
    DocumentSnapshot shot =
        await FirebaseFirestore.instance.collection("User").doc(userId).get();
    id = shot.get('level_id');
    level = shot.get('previous_session_info');
    level = level.toString().substring(6,7);
    print('Level $level');
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      queModel = QueModel();
      queModel?.id = a['id'];
      setState(() {
        list.add(queModel!);
        print(queModel?.id);
      });
    }
  }

  List<ProfilePageModel> levelList = [
    ProfilePageModel(
        id: 1,
        description:
            'Be smart with your money. Learn to differentiate between Needs and Wants.',
        level: 'Honey Pot',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 2,
        description:
            'Master the art of budgeting by learning a simple framework for allocating your cash.',
        level: 'Smart Savers',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 3,
        description:
            'Understand how Credit Scores work and learn to build a good Credit Rating.',
        level: 'Credit Karma',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 4,
        description:
            'Learn the concept of Time Value of Money and to use Compounding to grow your money.',
        level: 'Building Up',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 5,
        description: 'Learn to Invest in Stocks and to build a portfolio.',
        level: 'Stock Play',
        levelProgress: '10',
        popQuizProgress: '10'),
    ProfilePageModel(
        id: 6,
        description: 'Play in multiplayer mode and outscore your friends.',
        level: 'Super Sprint',
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
        body: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: boxDecoration,
          child: ListView(
            children: [
              SizedBox(
                height: displayHeight(context) * .03,
              ),
              Center(
                child: Container(
                  height: displayHeight(context) * .08,
                  width: displayWidth(context) * .50,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(displayWidth(context) * .14),
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
                  print('Level $level');
                  print('id ${levelList[index].id}');
                  return Container(
                    height: displayHeight(context) * .39,
                    width: displayWidth(context) * .99,
                    //color: Colors.red,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: displayHeight(context) * .33,
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
                                  top: displayWidth(context) * .06,
                                  left: displayWidth(context) * .02,
                                  right: displayWidth(context) * .02,
                                  bottom: displayWidth(context) * .02,
                                ),
                                child: Text(
                                  '${levelList[index].description}',
                                  style: GoogleFonts.roboto(
                                      color: Color(0xff563DC1),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LinearPercentIndicator(
                                    animation: true,
                                    lineHeight: displayHeight(context) * .04,
                                    width: displayWidth(context) * .60,
                                    animationDuration: 2500,
                                    percent: (id.toDouble() / 11),
                                    center: Text(
                                      'LEVEL PROGRESS',
                                      style: GoogleFonts.roboto(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xffFF3D8E),
                                    backgroundColor: Color(0xffFFDAF0),
                                  ),
                                  Container(
                                    width: displayWidth(context) * .08,
                                    height: displayHeight(context) * .05,
                                    child: Image.asset(
                                      'assets/replay.png',
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: displayWidth(context) * .22),
                                    child: Text(
                                      '${((id * 100) / 11).ceil()}',
                                      style: GoogleFonts.workSans(
                                          color: Color(0xffC4C4C4),
                                          fontSize: 12.sp),
                                    ),
                                  )),
                              SizedBox(
                                height: displayHeight(context) * .01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LinearPercentIndicator(
                                    animation: true,
                                    lineHeight: displayHeight(context) * .04,
                                    width: displayWidth(context) * .60,
                                    animationDuration: 2500,
                                    percent: (id.toDouble() / 11),
                                    center: Text(
                                      'POP QUIZ',
                                      style: GoogleFonts.roboto(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff409AFF),
                                    backgroundColor: Color(0xffCDE4FD),
                                  ),
                                  Container(
                                    width: displayWidth(context) * .08,
                                    height: displayHeight(context) * .05,
                                    child: Image.asset(
                                      'assets/popQuiz.png',
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: displayWidth(context) * .22),
                                    child: Text(
                                      '${((id * 100) / 11).ceil()}',
                                      style: GoogleFonts.workSans(
                                          color: Color(0xffC4C4C4),
                                          fontSize: 12.sp),
                                    ),
                                  )),
                              SizedBox(
                                height: displayHeight(context) * .01,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: displayHeight(context) * .00,
                          left: displayWidth(context) * .08,
                          child: Container(
                            width: displayWidth(context) * .45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  displayWidth(context) * .04),
                              color: Color(0xffFFF1ED),
                              border: Border.all(color: Color(0xffFF8762)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: displayWidth(context) * .03),
                              child: Text(
                                '${levelList[index].level}',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: Color(0xffFE3D02),
                                ),
                              ) ,
                            ),
                          ),
                          height: displayHeight(context) * .07,
                        ),
                        Positioned(
                          top: displayHeight(context) * .00,
                          left: displayWidth(context) * .01,
                          width: displayWidth(context) * .18,
                          child: Container(
                            width: displayWidth(context) * .42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffFBC712),
                            ),
                            child: levelList[index].id == int.parse(level!) ?  Text(
                              '${levelList[index].id}',
                              style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ) : Container(
                                height: displayHeight(context) * .04,
                                child: Image.asset('assets/lock.png')),
                          ),
                          height: displayHeight(context) * .07,
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
}
