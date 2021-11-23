// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:financial/ReusableScreen/ExpandedBottomDrawer.dart';
// import 'package:financial/ReusableScreen/GameScorePage.dart';
// import 'package:financial/ReusableScreen/GlobleVariable.dart';
// import 'package:financial/ReusableScreen/PreviewOfBottomDrawer.dart';
// import 'package:financial/Screens/devicesSizePage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
//
// //ignore: must_be_immutable
// class PopQuiz extends StatefulWidget {
//   PopQuiz({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _PopQuizState createState() => _PopQuizState();
// }
//
// class _PopQuizState extends State<PopQuiz> {
//   var level;
//   var document;
//
//   @override
//   Widget build(BuildContext context) {
//     //var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//     var portrait = displayHeight(context);
//     var bottomHeightPotrait = displayHeight(context) * .14;
//     var forPortrait = portrait - bottomHeightPotrait;
//
//     return SafeArea(
//         child: Container(
//             width: displayWidth(context),
//             height: displayHeight(context),
//             decoration: boxDecoration,
//             child: Scaffold(
//                 backgroundColor: Colors.transparent,
//                 body: DoubleBackToCloseApp(
//                   snackBar: const SnackBar(
//                     content: Text('Tap back again to leave'),
//                   ),
//                   child: DraggableBottomSheet(
//                     backgroundWidget: Container(
//                       width: displayWidth(context),
//                       height: forPortrait,
//                       decoration: boxDecoration,
//                       child: Column(
//                         children: [
//                           GameScorePage(level: level, document: document),
//                           SizedBox(
//                             height: forPortrait * .04,
//                           ),
//                           Flexible(
//                               child: Stack(
//                             children: [
//
//                               Container(
//                                 alignment: Alignment.center,
//                                 height: forPortrait * .86 - bottomHeightPotrait,
//                                 child: Container(
//                                   alignment: Alignment.center,
//                                   width: displayWidth(context) * .80,
//                                   height:
//                                       forPortrait * .81 - bottomHeightPotrait,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(
//                                         displayWidth(context) * .08,
//                                       ),
//                                       color: Colors.white),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                             top: displayHeight(context) * .04,
//                                             left: displayWidth(context) * .05,
//                                             right: displayWidth(context) * .05,
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'Suppose you had \$100 in a savings account and the interest rate was 2 percent per year. After five years, how much do you think you would have in the account if you left the money to grow? ',
//                                               style: GoogleFonts.workSans(
//                                                 fontSize: 16.sp,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.black,
//                                               ),
//                                               textAlign: TextAlign.justify,
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: displayHeight(context) *
//                                                     .03),
//                                             child: Container(
//                                               alignment: Alignment.topRight,
//                                               width:
//                                                   displayWidth(context) * .70,
//                                               height:
//                                                   displayHeight(context) * .07,
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xffEBEBEB),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           displayWidth(
//                                                                   context) *
//                                                               .02)),
//                                               child: TextButton(
//                                                   onPressed: () {},
//                                                   child: Center(
//                                                     child: FittedBox(
//                                                       child: RichText(
//                                                         overflow:
//                                                             TextOverflow.clip,
//                                                         text: TextSpan(
//                                                           text:
//                                                               'A. more than \$102',
//                                                           style: GoogleFonts
//                                                               .workSans(
//                                                                   color: Color(
//                                                                       0xff3D2F91),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   fontSize:
//                                                                       15.sp),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             )),
//                                         Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: displayHeight(context) *
//                                                     .01),
//                                             child: Container(
//                                               alignment: Alignment.topRight,
//                                               width:
//                                                   displayWidth(context) * .70,
//                                               height:
//                                                   displayHeight(context) * .07,
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xffEBEBEB),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           displayWidth(
//                                                                   context) *
//                                                               .02)),
//                                               child: TextButton(
//                                                   onPressed: () {},
//                                                   child: Center(
//                                                     child: FittedBox(
//                                                       child: RichText(
//                                                         overflow:
//                                                             TextOverflow.clip,
//                                                         text: TextSpan(
//                                                           text:
//                                                               'A. more than \$102',
//                                                           style: GoogleFonts
//                                                               .workSans(
//                                                                   color: Color(
//                                                                       0xff3D2F91),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   fontSize:
//                                                                       15.sp),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             )),
//                                         Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: displayHeight(context) *
//                                                     .01),
//                                             child: Container(
//                                               alignment: Alignment.topRight,
//                                               width:
//                                                   displayWidth(context) * .70,
//                                               height:
//                                                   displayHeight(context) * .07,
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xffEBEBEB),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           displayWidth(
//                                                                   context) *
//                                                               .02)),
//                                               child: TextButton(
//                                                   onPressed: () {},
//                                                   child: Center(
//                                                     child: FittedBox(
//                                                       child: RichText(
//                                                         overflow:
//                                                             TextOverflow.clip,
//                                                         text: TextSpan(
//                                                           text:
//                                                               'A. more than \$102',
//                                                           style: GoogleFonts
//                                                               .workSans(
//                                                                   color: Color(
//                                                                       0xff3D2F91),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   fontSize:
//                                                                       15.sp),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             )),
//                                         Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: displayHeight(context) *
//                                                     .01),
//                                             child: Container(
//                                               alignment: Alignment.topRight,
//                                               width:
//                                                   displayWidth(context) * .70,
//                                               height:
//                                                   displayHeight(context) * .07,
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xffEBEBEB),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           displayWidth(
//                                                                   context) *
//                                                               .02)),
//                                               child: TextButton(
//                                                   onPressed: () {},
//                                                   child: Center(
//                                                     child: FittedBox(
//                                                       child: RichText(
//                                                         overflow:
//                                                             TextOverflow.clip,
//                                                         text: TextSpan(
//                                                           text:
//                                                               'A. more than \$102',
//                                                           style: GoogleFonts
//                                                               .workSans(
//                                                                   color: Color(
//                                                                       0xff3D2F91),
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   fontSize:
//                                                                       15.sp),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             )),
//                                         SizedBox(
//                                           height: displayHeight(context) * .01,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                   bottom: displayHeight(context) * .55,
//                                   left: displayWidth(context) * .16 ,
//                                   child: Container(
//                                       height: displayHeight(context) * .05,
//                                       width: displayWidth(context) * .30,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffEF645B),
//                                           borderRadius: BorderRadius.circular(
//                                               displayWidth(context) * .08)),
//                                       child: Center(
//                                           child: Text(
//                                         'POP QUIZ',
//                                         style: GoogleFonts.robotoCondensed(
//                                             color: Colors.white,fontWeight: FontWeight.w700,fontSize: 14.sp),
//                                       )))),
//                             ],
//                           ))
//                         ],
//                       ),
//                     ),
//                     previewChild: PreviewOfBottomDrawer(),
//                     expandedChild: ExpandedBottomDrawer(),
//                     minExtent: displayHeight(context) * .14,
//                     maxExtent: level == 'Level_3'
//                         ? displayHeight(context) * .33
//                         : displayHeight(context) * .26,
//                     expansionExtent: level == 'Level_3' ? 90 : 50,
//                   ),
//                 ))));
//   }
// }
// main.dart

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/Model/QueModel.dart';
import 'package:financial/ReusableScreen/GameScorePage.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/Screens/LevelOneSetUpPage.dart';
import 'package:financial/Screens/LevelThreeSetUpPage.dart';
import 'package:financial/Screens/LevelTwoSetUpPage.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class PopQuiz extends StatefulWidget {
  const PopQuiz({Key? key}) : super(key: key);

  @override
  _PopQuizState createState() => _PopQuizState();
}

class _PopQuizState extends State with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;
  var document;
  String level = '';
  int myIndex = 0;
  var userId;
  Color? color1;
  Color? color2;
  Color? color3;
  Color? color4;

  //for model
  QueModel? queModel;
  List<QueModel> list = [];
  String? popQuiz ;
  //page controller
  PageController controller = PageController();

  Future<QueModel?> getLevelId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    DocumentSnapshot snap =
        await firestore.collection('User').doc(userId).get();
    popQuiz = snap.get('previous_session_info');
    print(popQuiz);
    QuerySnapshot querySnapshot;
    if (popQuiz == 'Level_2_Pop_Quiz') {
      querySnapshot = await firestore.collection("Level_2_Pop_Quiz").get();
    }
    else {
      querySnapshot = await firestore.collection("Level_3_Pop_Quiz").get();
    }
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      queModel = QueModel();
      queModel?.id = a['id'];
      setState(() {
        list.add(queModel!);
        print('List ${queModel?.id})');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLevelId();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: list.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ))
          : StreamBuilder<QuerySnapshot>(
              stream: popQuiz == 'Level_2_Pop_Quiz' ? firestore
                  .collection('Level_2_Pop_Quiz')
                  .orderBy('id')
                  .snapshots() : firestore
                  .collection('Level_3_Pop_Quiz')
                  .orderBy('id')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('It\'s Error!');
                }
                if (!snapshot.hasData)
                  return Container(
                    decoration: boxDecoration,
                    child: Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                // switch (snapshot.connectionState) {
                //   case ConnectionState.waiting:
                //   // return Container(
                //   //   decoration: boxDecoration,
                //   //   child: Center(
                //   //     child: SizedBox(
                //   //       child: CircularProgressIndicator(
                //   //         color: Colors.black,
                //   //       ),
                //   //     ),
                //   //   ),
                //   // );
                //   default:
                return PageView.builder(
                    itemCount: snapshot.data?.docs.length,
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    onPageChanged: (value) {},
                    itemBuilder: (context, index) {
                      myIndex = index;
                      document = snapshot.data?.docs[myIndex];
                      return Scaffold(
                          backgroundColor: Colors.transparent,
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
                                  GameScorePage(level: level),
                                  SizedBox(
                                    height: displayHeight(context) * .03,
                                  ),
                                  Transform(
                                    alignment: FractionalOffset.center,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.001)
                                      ..rotateY(pi * _animation.value),
                                    child: _animation.value <= 0.5
                                        ? Container(
                                            alignment: Alignment.center,
                                            width: displayWidth(context) * .80,
                                            height:
                                                displayHeight(context) * .62,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  displayWidth(context) * .06,
                                                ),
                                                color: Colors.white),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: displayHeight(
                                                              context) *
                                                          .01,
                                                      left: displayWidth(
                                                              context) *
                                                          .05,
                                                      right: displayWidth(
                                                              context) *
                                                          .05,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        document['description'],
                                                        style: GoogleFonts
                                                            .workSans(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ),
                                                  ),
                                                  StatefulBuilder(builder:
                                                      (context, setState) {
                                                    String ans = '';
                                                    return Column(
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: displayHeight(
                                                                        context) *
                                                                    .03),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  ans = document[
                                                                      'correct_ans'];
                                                                });
                                                                list[index].isSelected1 == true ||
                                                                        list[index].isSelected2 ==
                                                                            true ||
                                                                        list[index].isSelected3 ==
                                                                            true ||
                                                                        list[index].isSelected4 ==
                                                                            true
                                                                    ? _flipCard()
                                                                    : _checkCorrectAnswer(
                                                                        ans,
                                                                        setState,
                                                                        index,
                                                                        1);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: displayWidth(
                                                                        context) *
                                                                    .70,
                                                                height: displayHeight(
                                                                        context) *
                                                                    .07,
                                                                decoration: BoxDecoration(
                                                                    color: list[index].isSelected1 ==
                                                                            true
                                                                        ? color1
                                                                        : Color(
                                                                            0xffEBEBEB),
                                                                    borderRadius:
                                                                        BorderRadius.circular(displayWidth(context) *
                                                                            .03)),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            displayWidth(context) *
                                                                                .04,
                                                                        vertical:
                                                                            displayWidth(context) *
                                                                                .02),
                                                                    child: Text(
                                                                      document[
                                                                          'option_1'],
                                                                      style: GoogleFonts.workSans(
                                                                          color: list[index].isSelected1 == true
                                                                              ? Colors
                                                                                  .white
                                                                              : Color(
                                                                                  0xff3D2F91),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: displayHeight(
                                                                        context) *
                                                                    .01),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  ans = document[
                                                                      'correct_ans'];
                                                                });
                                                                list[index].isSelected1 == true ||
                                                                        list[index].isSelected2 ==
                                                                            true ||
                                                                        list[index].isSelected3 ==
                                                                            true ||
                                                                        list[index].isSelected4 ==
                                                                            true
                                                                    ? _flipCard()
                                                                    : _checkCorrectAnswer(
                                                                        ans,
                                                                        setState,
                                                                        index,
                                                                        2);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: displayWidth(
                                                                        context) *
                                                                    .70,
                                                                height: displayHeight(
                                                                        context) *
                                                                    .07,
                                                                decoration: BoxDecoration(
                                                                    color: list[index].isSelected2 ==
                                                                            true
                                                                        ? color2
                                                                        : Color(
                                                                            0xffEBEBEB),
                                                                    borderRadius:
                                                                        BorderRadius.circular(displayWidth(context) *
                                                                            .03)),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            displayWidth(context) *
                                                                                .04,
                                                                        vertical:
                                                                            displayWidth(context) *
                                                                                .02),
                                                                    child: Text(
                                                                      document[
                                                                          'option_2'],
                                                                      style: GoogleFonts.workSans(
                                                                          color: list[index].isSelected2 == true
                                                                              ? Colors
                                                                                  .white
                                                                              : Color(
                                                                                  0xff3D2F91),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: displayHeight(
                                                                        context) *
                                                                    .01),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  ans = document[
                                                                      'correct_ans'];
                                                                });
                                                                list[index].isSelected1 == true ||
                                                                        list[index].isSelected2 ==
                                                                            true ||
                                                                        list[index].isSelected3 ==
                                                                            true ||
                                                                        list[index].isSelected4 ==
                                                                            true
                                                                    ? _flipCard()
                                                                    : _checkCorrectAnswer(
                                                                        ans,
                                                                        setState,
                                                                        index,
                                                                        3);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: displayWidth(
                                                                        context) *
                                                                    .70,
                                                                height: displayHeight(
                                                                        context) *
                                                                    .07,
                                                                decoration: BoxDecoration(
                                                                    color: list[index].isSelected3 ==
                                                                            true
                                                                        ? color3
                                                                        : Color(
                                                                            0xffEBEBEB),
                                                                    borderRadius:
                                                                        BorderRadius.circular(displayWidth(context) *
                                                                            .03)),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            displayWidth(context) *
                                                                                .04,
                                                                        vertical:
                                                                            displayWidth(context) *
                                                                                .02),
                                                                    child: Text(
                                                                      document[
                                                                          'option_3'],
                                                                      style: GoogleFonts.workSans(
                                                                          color: list[index].isSelected3 == true
                                                                              ? Colors
                                                                                  .white
                                                                              : Color(
                                                                                  0xff3D2F91),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: displayHeight(
                                                                        context) *
                                                                    .01),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  ans = document[
                                                                      'correct_ans'];
                                                                });
                                                                list[index].isSelected1 == true ||
                                                                        list[index].isSelected2 ==
                                                                            true ||
                                                                        list[index].isSelected3 ==
                                                                            true ||
                                                                        list[index].isSelected4 ==
                                                                            true
                                                                    ? _flipCard()
                                                                    : _checkCorrectAnswer(
                                                                        ans,
                                                                        setState,
                                                                        index,
                                                                        4);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: displayWidth(
                                                                        context) *
                                                                    .70,
                                                                height: displayHeight(
                                                                        context) *
                                                                    .07,
                                                                decoration: BoxDecoration(
                                                                    color: list[index].isSelected4 ==
                                                                            true
                                                                        ? color4
                                                                        : Color(
                                                                            0xffEBEBEB),
                                                                    borderRadius:
                                                                        BorderRadius.circular(displayWidth(context) *
                                                                            .03)),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            displayWidth(context) *
                                                                                .04,
                                                                        vertical:
                                                                            displayWidth(context) *
                                                                                .02),
                                                                    child: Text(
                                                                      document[
                                                                          'option_4'],
                                                                      style: GoogleFonts.workSans(
                                                                          color: list[index].isSelected4 == true
                                                                              ? Colors
                                                                                  .white
                                                                              : Color(
                                                                                  0xff3D2F91),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    );
                                                  }),
                                                  SizedBox(
                                                    height:
                                                        displayHeight(context) *
                                                            .01,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: displayWidth(context) * .80,
                                            height:
                                                displayHeight(context) * .62,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  displayWidth(context) * .06,
                                                ),
                                                color: Colors.white),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Transform(
                                                      alignment:
                                                          FractionalOffset
                                                              .center,
                                                      transform: Matrix4
                                                          .identity()
                                                        ..setEntry(3, 2, 0.001)
                                                        ..rotateY(pi *
                                                            _animation.value),
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: displayWidth(
                                                                          context) *
                                                                      .06,
                                                                  right: displayWidth(
                                                                          context) *
                                                                      .06,
                                                                  top: displayWidth(
                                                                          context) *
                                                                      .08,
                                                                  bottom: displayWidth(
                                                                          context) *
                                                                      .03),
                                                              child: Text(
                                                                document[
                                                                    'answer_exp'],
                                                                style: GoogleFonts
                                                                    .workSans(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * .03,
                                  ),
                                  Container(
                                      width: displayWidth(context) * .76,
                                      height: displayHeight(context) * .07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            displayHeight(context) * .08),
                                      ),
                                      child: _animation.value >= 0.5
                                          ? ElevatedButton(
                                              onPressed: () {
                                                print('my index $index');
                                                index = index;
                                                _flipCard();
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: Color(
                                                                0xff4D6EF2),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayWidth(context) *
                                                                      .04)))),
                                              child: Text(
                                                'Tap To See Question',
                                                style: GoogleFonts.workSans(
                                                    color: Color(0xff3D2F91),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp),
                                              ))
                                          : ElevatedButton(
                                              onPressed: () async {
                                                if (index ==
                                                    snapshot.data!.docs.length -
                                                        1) {
                                                  DocumentSnapshot
                                                      documentSnapshot =
                                                      await firestore
                                                          .collection('User')
                                                          .doc(userId)
                                                          .get();

                                                  bool value = documentSnapshot
                                                      .get('replay_level');
                                                  level = documentSnapshot
                                                      .get('last_level');
                                                  int myBal = documentSnapshot
                                                      .get('account_balance');
                                                  print('My bal $myBal');
                                                  level = level
                                                      .toString()
                                                      .substring(6, 7);
                                                  int lev = int.parse(level);

                                                  if (value == true) {
                                                    Future.delayed(
                                                        Duration(seconds: 1),
                                                        () => showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) {
                                                              return WillPopScope(
                                                                onWillPop: () {
                                                                  return Future
                                                                      .value(
                                                                          false);
                                                                },
                                                                child:
                                                                    AlertDialog(
                                                                  elevation:
                                                                      3.0,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(displayWidth(context) *
                                                                              .04)),
                                                                  titlePadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  title:
                                                                      Container(
                                                                    width: displayWidth(
                                                                        context),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'Congratulations! You have completed this level successfully',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: GoogleFonts.workSans(
                                                                            fontSize:
                                                                                14.sp,
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(displayWidth(context) * .04),
                                                                              topLeft: Radius.circular(displayWidth(context) * .04),
                                                                            ),
                                                                            color: Color(0xffE9E5FF)),
                                                                  ),
                                                                  content:
                                                                      Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      if (lev >
                                                                          1)
                                                                        Text(
                                                                          'Which level you want play ?',
                                                                          style: GoogleFonts.workSans(
                                                                              fontSize: 12.sp,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      if (lev >
                                                                          1)
                                                                        _level1(
                                                                            lev),
                                                                      if (lev >
                                                                          2)
                                                                        _level2(
                                                                            lev),
                                                                      if (lev >
                                                                          3)
                                                                        _level3(
                                                                            lev),
                                                                      if (lev >
                                                                          4)
                                                                        _level4(
                                                                            lev),
                                                                      if (lev >
                                                                          5)
                                                                        _level5(
                                                                            lev),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: displayHeight(context) * .03),
                                                                        child:
                                                                            Text(
                                                                          'Want to play current level ?',
                                                                          style: GoogleFonts.workSans(
                                                                              fontSize: 12.sp,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                      if (lev ==
                                                                          1)
                                                                        _level1(
                                                                            lev),
                                                                      if (lev ==
                                                                          2)
                                                                        _level2(
                                                                            lev),
                                                                      if (lev ==
                                                                          3)
                                                                        _level3(
                                                                            lev),
                                                                      if (lev ==
                                                                          4)
                                                                        _level4(
                                                                            lev),
                                                                      if (lev ==
                                                                          5)
                                                                        _level5(
                                                                            lev),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }));
                                                  } else {
                                                    firestore
                                                        .collection('User')
                                                        .doc(userId)
                                                        .update({
                                                      'previous_session_info':
                                                          'Level_3_setUp_page',
                                                      'level_id': 0,
                                                      'bill_payment': 0,
                                                      'credit_card_balance': 0,
                                                      'credit_card_bill': 0,
                                                      'credit_score': 0,
                                                      'payable_bill': 0,
                                                      'score': 0,
                                                      'replay_level': false,
                                                      'last_level':
                                                          'Level_3_setUp_page',
                                                      'need': 0,
                                                      'want': 0,
                                                    });
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () => Navigator
                                                            .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      LevelThreeSetUpPage(
                                                                          controller:
                                                                              PageController()),
                                                                )));
                                                  }
                                                } else {
                                                  controller.nextPage(
                                                      duration:
                                                          Duration(seconds: 1),
                                                      curve: Curves.easeIn);
                                                }
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: Color(
                                                                0xff4D6EF2),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayWidth(context) *
                                                                      .04)))),
                                              child: Text(
                                                'Tap To Move Next Question',
                                                style: GoogleFonts.workSans(
                                                    color: Color(0xff3D2F91),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp),
                                              )))
                                ],
                              ),
                            ),
                          ));
                    });
              }
              //},
              ),
    );
  }

  _checkCorrectAnswer(String ans, StateSetter setState, int index, int i) {
    setState(() {
      if (ans == 'a') {
        list[index].isSelected1 = true;
        color1 = Color(0xff04AA6D);
      } else {
        list[index].isSelected1 = true;
        if (i == 1)
          color1 = Color(0xffff3333);
        else
          color1 = Color(0xffbfbfbf);
      }
      if (ans == 'b') {
        list[index].isSelected2 = true;
        color2 = Color(0xff04AA6D);
      } else {
        list[index].isSelected2 = true;
        if (i == 2)
          color2 = Color(0xffff3333);
        else
          color2 = Color(0xffbfbfbf);
      }
      if (ans == 'c') {
        list[index].isSelected3 = true;
        color3 = Color(0xff04AA6D);
      } else {
        list[index].isSelected3 = true;
        if (i == 3)
          color3 = Color(0xffff3333);
        else
          color3 = Color(0xffbfbfbf);
      }
      if (ans == 'd') {
        list[index].isSelected4 = true;
        color4 = Color(0xff04AA6D);
      } else {
        list[index].isSelected4 = true;
        if (i == 4)
          color4 = Color(0xffff3333);
        else
          color4 = Color(0xffbfbfbf);
      }
    });
    _flipCard();
  }

  _flipCard() {
    if (_status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  _level1(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .03),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {
              if (lev == 1) {
                firestore.collection('User').doc(userId).update({
                  'replay_level': false,
                  'previous_session_info': 'Level_1_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0,
                  'last_level': 'Level_1_setUp_page',
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelOneSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              } else {
                firestore.collection('User').doc(userId).update({
                  'previous_session_info': 'Level_1_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelOneSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              }
            },
            child: Text('Level 1'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }

  _level2(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .01),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {
              if (lev == 2) {
                firestore.collection('User').doc(userId).update({
                  'replay_level': false,
                  'previous_session_info': 'Level_2_setUp_page',
                  'last_level': 'Level_2_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelTwoSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              } else {
                firestore.collection('User').doc(userId).update({
                  'previous_session_info': 'Level_2_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelTwoSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              }
            },
            child: Text('Level 2'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }

  _level3(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .02),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {
              if (lev == 3) {
                firestore.collection('User').doc(userId).update({
                  'replay_level': false,
                  'previous_session_info': 'Level_3_setUp_page',
                  'last_level': 'Level_3_setUp_page',
                  'account_balance': 0,
                  'bill_payment': 0,
                  'credit_card_balance': 0,
                  'credit_card_bill': 0,
                  'credit_score': 0,
                  'level_id': 0,
                  'payable_bill': 0,
                  'quality_of_life': 0,
                  'score': 0
                });
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: LevelThreeSetUpPage(
                          controller: PageController(),
                        ),
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop));
              }
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: LevelThreeSetUpPage(
                        controller: PageController(),
                      ),
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.bottomToTop));
            },
            child: Text('Level 3'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }

  _level4(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .02),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Level 4'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }

  _level5(int lev) {
    return Padding(
        padding: EdgeInsets.only(top: displayWidth(context) * .02),
        child: Container(
          width: displayWidth(context) * .40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(displayWidth(context) * .12)),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Level 5'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color(0xff828FCE),
            )),
          ),
        ));
  }
}
