import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/LevelOneSetUpPage.dart';
import 'package:financial/Screens/LevelThreeSetUpPage.dart';
import 'package:financial/Screens/LevelTwoSetUpPage.dart';
import 'package:financial/Screens/PopQuiz.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userId;
  String level = ' ';
  int lev = 0;
  int i = 0;

  getLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    DocumentSnapshot documentSnapshot =
        await firestore.collection('User').doc(userId).get();
    level = documentSnapshot.get('last_level');
    print(level.toString().substring(6, 7));
    level = level.toString().substring(6, 7);
    setState(() {
      lev = int.parse(level);
    });
  }

  @override
  void initState() {
    getLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: lev >= 1
                          ? MaterialStateProperty.all(Colors.green)
                          : MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      i = 1;
                      lev >= 1 ? _showDialog(i) : Container();
                    },
                    child: Text(
                      'Level 1 : Smart Money',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: lev >= 2
                          ? MaterialStateProperty.all(Colors.green)
                          : MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      print('yes');
                      lev >= 2 ? _showDialog(2) : Container();
                    },
                    child: Text(
                      'Level 2 : Smart Savers',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: lev >= 2
                          ? MaterialStateProperty.all(Colors.green)
                          : MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      lev >= 2
                          ? firestore.collection('User').doc(userId).update({
                              'previous_session_info': 'Level_2_Pop_Quiz',
                              'replay_level': true,
                            }).then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PopQuiz()));
                            })
                          : Container();
                    },
                    child: Text(
                      'Level 2 Pop Quiz',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: lev >= 3
                          ? MaterialStateProperty.all(Colors.green)
                          : MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      print('yes');
                      lev >= 3 ? _showDialog(3) : Container();
                    },
                    child: Text(
                      'Level 3 : Building Credit',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: lev >= 3
                          ? MaterialStateProperty.all(Colors.green)
                          : MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      lev >= 3
                          ? firestore.collection('User').doc(userId).update({
                              'previous_session_info': 'Level_3_Pop_Quiz',
                              'replay_level': true,
                            }).then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PopQuiz()));
                            })
                          : Container();
                    },
                    child: Text(
                      'Level 3 Pop Quiz',
                      style: TextStyle(color: Colors.white),
                    )),
                lev >= 4
                    ? TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          print('yes');
                          _showDialog(4);
                        },
                        child: Text(
                          'Level 4 : Building Assets',
                          style: TextStyle(color: Colors.white),
                        ))
                    : TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Level 4 : Building Assets',
                          style: TextStyle(color: Colors.white),
                        )),
                lev >= 5
                    ? TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          print('yes');
                          _showDialog(5);
                        },
                        child: Text(
                          'Level 5 : Stock Play',
                          style: TextStyle(color: Colors.white),
                        ))
                    : TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Level 5 : Stock Play',
                          style: TextStyle(color: Colors.white),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(int i) {
    print('i $i');
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            // actionsPadding: EdgeInsets.all(8.0),
            backgroundColor: Color(0xff6646E6),
            title: Text(
              'Replay Level ?',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    print('ii $i');
                    if (i == 1) {
                      _updateValue(i);
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LevelOneSetUpPage(
                                controller: PageController(),
                              ),
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.bottomToTop));
                    }

                    if (i == 2) {
                      _updateValue(i);
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LevelTwoSetUpPage(
                                controller: PageController(),
                              ),
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.bottomToTop));
                    }

                    if (i == 3) {
                      _updateValue(i);
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LevelThreeSetUpPage(
                                controller: PageController(),
                              ),
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.bottomToTop));
                    }
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp))),
            ],
          );
        });
  }

  _updateValue(int i) {
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
      'previous_session_info': 'Level_$i\_setUp_page',
      'quality_of_life': 0,
      'score': 0
    });
  }
}
