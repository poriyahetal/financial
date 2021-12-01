import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/ProfilePage.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

//ignore: must_be_immutable
class GameScorePage extends StatefulWidget {
  var document;
  String level = '';

  GameScorePage({Key? key, this.document, required this.level})
      : super(key: key);

  @override
  _GameScorePageState createState() => _GameScorePageState();
}

class _GameScorePageState extends State<GameScorePage> {
  //to get user state value
  var userId;
  String? level;

  int? _gameSco ;

  getUserValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    DocumentSnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("User").doc(userId).get();
    setState(() {
      _gameSco = querySnapshot.get('game_score');
      level = querySnapshot.get('previous_session_info');
    });
  }

  @override
  void initState() {

    getUserValue();
    //  level = widget.level;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: forPortrait * .08,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: forPortrait * .10,
                width: displayWidth(context) * .56,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(displayWidth(context) * .10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: displayWidth(context) * .02),
                      child: Container(
                          child: Image.asset(
                        'assets/star.png',
                        width: displayWidth(context) * .10,
                        fit: BoxFit.contain,
                      )),
                    ),
                    Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.only(right: displayWidth(context) * .01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text('GAME SCORE',
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  color: Color(0xff3D2F91))),
                          Spacer(),
                          _gameScore(),
                          Spacer(),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: displayWidth(context) * .06,
                    right: displayWidth(context) * .06),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child:  Image.asset(
                    'assets/fish.png',
                    width: displayWidth(context) * .10,
                    fit: BoxFit.contain,
                  )

                ),
              ),
            ],
          ),
        ),
        if (level == 'Level_2_Pop_Quiz')
          Padding(
              padding: EdgeInsets.only(
            top: displayHeight(context) * .00,
          )),
        if ((level == "Level_1" || level == "") &&
            widget.document['card_type'] == 'GameQuestion')
          Padding(
              padding: EdgeInsets.only(
                top: displayHeight(context) * .02,
              ),
              child: widget.document['day'] == 0
                  ? Text('Day 1')
                  : Text(
                      'Day ' + widget.document['day'].toString(),
                      style: GoogleFonts.workSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )),
        if ((level == "Level_2" || level == 'Level_3') &&
            (widget.document.toString() == 'GameQuestion' ||
                widget.document['card_type'] == 'GameQuestion'))
          Padding(
              padding: EdgeInsets.only(
                top: displayHeight(context) * .02,
              ),
              child: widget.document.toString() == 'GameQuestion'
                  ? Text(
                      'Week 1',
                      style: GoogleFonts.workSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : widget.document['week'] == null
                      ? Text(
                          'Week 1',
                          style: GoogleFonts.workSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Week ' + widget.document['week'].toString(),
                          style: GoogleFonts.workSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
      ],
    );
  }

  _gameScore() {
    return _gameSco.toString().isEmpty
        ? Center(
            child: SizedBox(
              height: displayHeight(context) * .05,
              width: displayWidth(context) * .08,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white12,
                color: Color(0xff5978f3),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(right: displayWidth(context) * .02),
            child: Container(
              child: StreamBuilder<DocumentSnapshot>(
                stream: firestore.collection('User').doc(userId).snapshots(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Text('It\'s Error!');
                  }
                  if (!streamSnapshot.hasData || !streamSnapshot.data!.exists)
                    return Center(
                      child: SizedBox(
                        height: displayHeight(context) * .05,
                        width: displayWidth(context) * .08,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white12,
                          color: Colors.white12,
                        ),
                      ),
                    );
                  //  switch (streamSnapshot.connectionState) {
                  //    case ConnectionState.waiting:
                  // return Center(
                  //   child: SizedBox(
                  //     height: displayHeight(context) * .05,
                  //     width: displayWidth(context) * .08,
                  //     child: CircularProgressIndicator(
                  //       backgroundColor: Colors.white12,
                  //       color: Colors.white12,
                  //     ),
                  //   ),
                  // );
                  //default:
                  return Container(
                    child: GradientText(
                        text: '${'${streamSnapshot.data!['game_score']}'}'
                            .toString(),
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        gradient: const LinearGradient(
                            colors: [Color(0xff4D5DDD), Color(0xff6D00C2)],
                            transform: GradientRotation(math.pi / 2))),
                  );
                  // }
                },
              ),
            ),
          );
  }
}
