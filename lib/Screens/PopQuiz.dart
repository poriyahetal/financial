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
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
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

  //for model
  QueModel? queModel;
  List<QueModel> list = [];

  //page controller
  PageController controller = PageController();

  Future<QueModel?> getLevelId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('uId');
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Level_2_Pop_Quiz").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      queModel = QueModel();
      queModel?.id = a['id'];
      setState(() {
        list.add(queModel!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLevelId();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds:  1));
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
      child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('Level_2_Pop_Quiz')
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
                                        height: displayHeight(context) * .62,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
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
                                                  top: displayHeight(context) *
                                                      .01,
                                                  left: displayWidth(context) *
                                                      .05,
                                                  right: displayWidth(context) *
                                                      .05,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    document['description'],
                                                    style: GoogleFonts.workSans(
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
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top:
                                                        displayHeight(context) *
                                                            .03),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (_status ==
                                                        AnimationStatus
                                                            .dismissed) {
                                                    _controller
                                                              .forward();
                                                    } else {
                                                      _controller
                                                              .reverse();
                                                    }
                                                    // controller.nextPage(
                                                    //     duration:
                                                    //         Duration(
                                                    //             seconds:
                                                    //                 1),
                                                    //     curve: Curves
                                                    //         .easeIn);
                                                  },
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        displayWidth(context) *
                                                            .70,
                                                    height:
                                                        displayHeight(context) *
                                                            .07,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffEBEBEB),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displayWidth(
                                                                        context) *
                                                                    .03)),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                displayWidth(
                                                                        context) *
                                                                    .04,
                                                            vertical:
                                                                displayWidth(
                                                                        context) *
                                                                    .02),
                                                        child: Text(
                                                          document['option_1'],
                                                          style: GoogleFonts
                                                              .workSans(
                                                                  color: Color(
                                                                      0xff3D2F91),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: displayHeight(
                                                              context) *
                                                          .02),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_status ==
                                                          AnimationStatus
                                                              .dismissed) {
                                                         _controller
                                                                .forward();
                                                      } else {
                                                      _controller
                                                                .reverse();
                                                      }
                                                      // controller.nextPage(
                                                      //     duration:
                                                      //         Duration(
                                                      //             seconds:
                                                      //                 1),
                                                      //     curve: Curves
                                                      //         .easeIn);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: displayWidth(
                                                              context) *
                                                          .70,
                                                      height: displayHeight(
                                                              context) *
                                                          .07,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEBEBEB),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayWidth(
                                                                          context) *
                                                                      .03)),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  displayWidth(
                                                                          context) *
                                                                      .04,
                                                              vertical:
                                                                  displayWidth(
                                                                          context) *
                                                                      .02),
                                                          child: Text(
                                                            document[
                                                                'option_2'],
                                                            style: GoogleFonts.workSans(
                                                                color: Color(
                                                                    0xff3D2F91),
                                                                fontWeight:
                                                                    FontWeight
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
                                                          .02),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_status ==
                                                          AnimationStatus
                                                              .dismissed) {
                                                         _controller
                                                                .forward();
                                                      } else {
                                                        _controller
                                                                .reverse();
                                                      }
                                                      // controller.nextPage(
                                                      //     duration:
                                                      //         Duration(
                                                      //             seconds:
                                                      //                 1),
                                                      //     curve: Curves
                                                      //         .easeIn);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: displayWidth(
                                                              context) *
                                                          .70,
                                                      height: displayHeight(
                                                              context) *
                                                          .07,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEBEBEB),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayWidth(
                                                                          context) *
                                                                      .03)),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  displayWidth(
                                                                          context) *
                                                                      .04,
                                                              vertical:
                                                                  displayWidth(
                                                                          context) *
                                                                      .02),
                                                          child: Text(
                                                            document[
                                                                'option_3'],
                                                            style: GoogleFonts.workSans(
                                                                color: Color(
                                                                    0xff3D2F91),
                                                                fontWeight:
                                                                    FontWeight
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
                                                    top:
                                                        displayHeight(context) *
                                                            .02,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_status ==
                                                          AnimationStatus
                                                              .dismissed) {
                                                         _controller
                                                                .forward();
                                                      } else {
                                                         _controller
                                                                .reverse();
                                                      }
                                                      // controller.nextPage(
                                                      //     duration:
                                                      //         Duration(
                                                      //             seconds:
                                                      //                 1),
                                                      //     curve: Curves
                                                      //         .easeIn);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: displayWidth(
                                                              context) *
                                                          .70,
                                                      height: displayHeight(
                                                              context) *
                                                          .07,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffEBEBEB),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayWidth(
                                                                          context) *
                                                                      .03)),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  displayWidth(
                                                                          context) *
                                                                      .04,
                                                              vertical:
                                                                  displayWidth(
                                                                          context) *
                                                                      .02),
                                                          child: Text(
                                                            document[
                                                                'option_4'],
                                                            style: GoogleFonts.workSans(
                                                                color: Color(
                                                                    0xff3D2F91),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    14.sp),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: displayHeight(context) *
                                                    .01,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: displayWidth(context) * .80,
                                        height: displayHeight(context) * .62,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
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
                                              Transform(
                                                  alignment:
                                                      FractionalOffset.center,
                                                  transform: Matrix4.identity()
                                                    ..setEntry(3, 2, 0.001)
                                                    ..rotateY(
                                                        pi * _animation.value),
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
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      // ElevatedButton(
                                                      //     onPressed: () {
                                                      //       if (_status ==
                                                      //           AnimationStatus
                                                      //               .dismissed) {
                                                      //         _controller
                                                      //             .forward();
                                                      //       } else {
                                                      //         _controller
                                                      //             .reverse();
                                                      //       }
                                                      //       // controller.nextPage(
                                                      //       //     duration:
                                                      //       //         Duration(
                                                      //       //             seconds:
                                                      //       //                 1),
                                                      //       //     curve: Curves
                                                      //       //         .easeIn);
                                                      //     },
                                                      //     child: Text('Tap')),
                                                    ],
                                                  ))

                                              // Padding(
                                              //   padding: EdgeInsets.only(
                                              //     top: displayHeight(context) * .00,
                                              //     left: displayWidth(context) * .05,
                                              //     right: displayWidth(context) * .05,
                                              //   ),
                                              //   child: Center(
                                              //     child: Text(
                                              //       'Suppose you had \$100 in a savings account and the interest rate was 2 percent per year. After five years, how much do you think you would have in the account if you left the money to grow? ',
                                              //       style: GoogleFonts.workSans(
                                              //         fontSize: 16.sp,
                                              //         fontWeight: FontWeight.w500,
                                              //         color: Colors.black,
                                              //       ),
                                              //       textAlign: TextAlign.justify,
                                              //     ),
                                              //   ),
                                              // ),
                                              // Padding(
                                              //     padding: EdgeInsets.only(
                                              //         top: displayHeight(context) *
                                              //             .03),
                                              //     child: Container(
                                              //       alignment: Alignment.topRight,
                                              //       width:
                                              //           displayWidth(context) * .70,
                                              //       height:
                                              //           displayHeight(context) * .07,
                                              //       decoration: BoxDecoration(
                                              //           color: Color(0xffEBEBEB),
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   displayWidth(
                                              //                           context) *
                                              //                       .02)),
                                              //       child: TextButton(
                                              //           onPressed: () {},
                                              //           child: Center(
                                              //             child: FittedBox(
                                              //               child: RichText(
                                              //                 overflow:
                                              //                     TextOverflow.clip,
                                              //                 text: TextSpan(
                                              //                   text:
                                              //                       'A. more than \$102',
                                              //                   style: GoogleFonts
                                              //                       .workSans(
                                              //                           color: Color(
                                              //                               0xff3D2F91),
                                              //                           fontWeight:
                                              //                               FontWeight
                                              //                                   .w500,
                                              //                           fontSize:
                                              //                               15.sp),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           )),
                                              //     )),
                                              // Padding(
                                              //     padding: EdgeInsets.only(
                                              //         top: displayHeight(context) *
                                              //             .01),
                                              //     child: Container(
                                              //       alignment: Alignment.topRight,
                                              //       width:
                                              //           displayWidth(context) * .70,
                                              //       height:
                                              //           displayHeight(context) * .07,
                                              //       decoration: BoxDecoration(
                                              //           color: Color(0xffEBEBEB),
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   displayWidth(
                                              //                           context) *
                                              //                       .02)),
                                              //       child: TextButton(
                                              //           onPressed: () {},
                                              //           child: Center(
                                              //             child: FittedBox(
                                              //               child: RichText(
                                              //                 overflow:
                                              //                     TextOverflow.clip,
                                              //                 text: TextSpan(
                                              //                   text:
                                              //                       'A. more than \$102',
                                              //                   style: GoogleFonts
                                              //                       .workSans(
                                              //                           color: Color(
                                              //                               0xff3D2F91),
                                              //                           fontWeight:
                                              //                               FontWeight
                                              //                                   .w500,
                                              //                           fontSize:
                                              //                               15.sp),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           )),
                                              //     )),
                                              // Padding(
                                              //     padding: EdgeInsets.only(
                                              //         top: displayHeight(context) *
                                              //             .01),
                                              //     child: Container(
                                              //       alignment: Alignment.topRight,
                                              //       width:
                                              //           displayWidth(context) * .70,
                                              //       height:
                                              //           displayHeight(context) * .07,
                                              //       decoration: BoxDecoration(
                                              //           color: Color(0xffEBEBEB),
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   displayWidth(
                                              //                           context) *
                                              //                       .02)),
                                              //       child: TextButton(
                                              //           onPressed: () {},
                                              //           child: Center(
                                              //             child: FittedBox(
                                              //               child: RichText(
                                              //                 overflow:
                                              //                     TextOverflow.clip,
                                              //                 text: TextSpan(
                                              //                   text:
                                              //                       'A. more than \$102',
                                              //                   style: GoogleFonts
                                              //                       .workSans(
                                              //                           color: Color(
                                              //                               0xff3D2F91),
                                              //                           fontWeight:
                                              //                               FontWeight
                                              //                                   .w500,
                                              //                           fontSize:
                                              //                               15.sp),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           )),
                                              //     )),
                                              // Padding(
                                              //     padding: EdgeInsets.only(
                                              //         top: displayHeight(context) *
                                              //             .01),
                                              //     child: Container(
                                              //       alignment: Alignment.topRight,
                                              //       width:
                                              //           displayWidth(context) * .70,
                                              //       height:
                                              //           displayHeight(context) * .07,
                                              //       decoration: BoxDecoration(
                                              //           color: Color(0xffEBEBEB),
                                              //           borderRadius:
                                              //               BorderRadius.circular(
                                              //                   displayWidth(
                                              //                           context) *
                                              //                       .02)),
                                              //       child: TextButton(
                                              //           onPressed: () {},
                                              //           child: Center(
                                              //             child: FittedBox(
                                              //               child: RichText(
                                              //                 overflow:
                                              //                     TextOverflow.clip,
                                              //                 text: TextSpan(
                                              //                   text:
                                              //                       'A. more than \$102',
                                              //                   style: GoogleFonts
                                              //                       .workSans(
                                              //                           color: Color(
                                              //                               0xff3D2F91),
                                              //                           fontWeight:
                                              //                               FontWeight
                                              //                                   .w500,
                                              //                           fontSize:
                                              //                               15.sp),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           )),
                                              //     )),
                                              // SizedBox(
                                              //   height: displayHeight(context) * .01,
                                              // )
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
                                            if (_status ==
                                                AnimationStatus.dismissed) {
                                              _controller.forward();
                                            } else {
                                              _controller.reverse();
                                            }
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color:
                                                            Color(0xff4D6EF2),
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
                                          onPressed: () {
                                            // print('my index $index');
                                            // index = index;
                                            // if (_status ==
                                            //     AnimationStatus.dismissed) {
                                            //   _controller.forward();
                                            // } else {
                                            //   _controller.reverse();
                                            // }
                                            controller.nextPage(
                                                duration: Duration(seconds: 1),
                                                curve: Curves.easeIn);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color:
                                                            Color(0xff4D6EF2),
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
                                          ))
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       print('my index $index');
                                  //       index = index;
                                  //       if (_status ==
                                  //           AnimationStatus.dismissed) {
                                  //         _controller.forward();
                                  //       } else {
                                  //         _controller.reverse();
                                  //       }
                                  //     },
                                  //     style: ButtonStyle(
                                  //         backgroundColor: MaterialStateProperty
                                  //             .all(Colors.white),
                                  //         shape: MaterialStateProperty.all(
                                  //             RoundedRectangleBorder(
                                  //                 side: BorderSide(
                                  //                   color: Color(0xff4D6EF2),
                                  //                 ),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         displayWidth(context) *
                                  //                             .04)))),
                                  //     child: _animation.value <= 0.5
                                  //         ? Text(
                                  //             'Tap To Move Next Question',
                                  //             style: GoogleFonts.workSans(
                                  //                 color: Color(0xff3D2F91),
                                  //                 fontWeight: FontWeight.w500,
                                  //                 fontSize: 12.sp),
                                  //           )
                                  //         : Text(
                                  //             'Tap To See Question',
                                  //             style: GoogleFonts.workSans(
                                  //                 color: Color(0xff3D2F91),
                                  //                 fontWeight: FontWeight.w500,
                                  //                 fontSize: 12.sp),
                                  //           )),
                                  )
                            ],
                          ),
                        ),
                      ));
                });
          }
          //},
          ),
    );

    //   Scaffold(
    //   appBar: AppBar(
    //     title: Text('Kindacode.com'),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Center(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           // SizedBox(
    //           //   height: 30,
    //           // ),
    //           // // Horizontal Flipping
    //           // Transform(
    //           //   alignment: FractionalOffset.center,
    //           //   transform: Matrix4.identity()
    //           //     ..setEntry(3, 2, 0.0015)
    //           //     ..rotateY(pi * _animation.value),
    //           //   child: Card(
    //           //     child: _animation.value <= 0.5
    //           //         ? Container(
    //           //         color: Colors.deepOrange,
    //           //         width: 240,
    //           //         height: 300,
    //           //         child: Center(
    //           //             child: Text(
    //           //               '?',
    //           //               style: TextStyle(fontSize: 100, color: Colors.white),
    //           //             )))
    //           //         : Container(
    //           //         width: 240,
    //           //         height: 300,
    //           //         color: Colors.grey,
    //           //         child: Image.network(
    //           //           'https://www.kindacode.com/wp-content/uploads/2021/09/girl.jpeg',
    //           //           fit: BoxFit.cover,
    //           //         )),
    //           //   ),
    //           // ),
    //           // // Vertical Flipping
    //           // ElevatedButton(
    //           //     onPressed: () {
    //           //       if (_status == AnimationStatus.dismissed) {
    //           //         _controller.forward();
    //           //       } else {
    //           //         _controller.reverse();
    //           //       }
    //           //     },
    //           //     child: Text('Reveal The Secrets'))
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
