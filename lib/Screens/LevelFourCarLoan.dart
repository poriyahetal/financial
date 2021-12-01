import 'dart:async';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:financial/ReusableScreen/GlobleVariable.dart';
import 'package:financial/ReusableScreen/GradientText.dart';
import 'package:financial/Screens/ProfilePage.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class LevelFourCardLoan extends StatefulWidget {
  LevelFourCardLoan({Key? key}) : super(key: key);

  @override
  _LevelFourCardLoanState createState() => _LevelFourCardLoanState();
}

class _LevelFourCardLoanState extends State<LevelFourCardLoan>
    with SingleTickerProviderStateMixin {
  //animation controller and for selected option
  late AnimationController _animationController;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;

  double _value = 5;

  String _text =
      'Rent a Studio Apartment in downtown.Close to Stores, Gym, Restaurants & Work.';
  String _image = 'assets/studioApartment.png';
  int _rent = 200;
  int _emi = 300;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Timer(Duration(milliseconds: 500), () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var forPortrait = displayHeight(context);
    var bottomHeightPotrait = displayHeight(context) * .14;
    forPortrait = forPortrait - bottomHeightPotrait;

    return SafeArea(
      child: Scaffold(
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
                    // SlideTransition(
                    //   position:
                    //       Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                    //           .animate(_animationController),
                    // child:
                    Column(
                      children: [
                        SizedBox(
                          height: displayHeight(context) * .04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Container(
                                height: displayHeight(context) * .06,
                                width: displayWidth(context) * .40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      displayWidth(context) * .14),
                                  color: Color(0xffEF645B),
                                ),
                                child: Center(
                                    child: Text(
                                      'STEP 01',
                                      style: GoogleFonts.workSans(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: displayWidth(context) * .13,
                                  right: displayWidth(context) * .07),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()));
                                },
                                child: Image.asset(
                                  'assets/fish.png',
                                  width: displayWidth(context) * .10,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: displayHeight(context) * .04,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: displayWidth(context) * .12,
                                left: displayWidth(context) * .12),
                            child: Text(
                              'WHERE WILL YOU LIVE?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * .02,
                        ),
                        Container(
                          width: displayWidth(context) * .80,
                          height: displayHeight(context) * .64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              displayWidth(context) * .06,
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: displayWidth(context) * .01),
                                child: Image.asset(
                                  _image,
                                  width: displayWidth(context) * .60,
                                  height: displayHeight(context) * .18,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color(0xffE6E2F6),
                                  inactiveTrackColor: Color(0xffE6E2F6),
                                  trackShape: RoundedRectSliderTrackShape(),
                                  trackHeight: displayWidth(context) * .02,
                                  thumbColor: Color(0xff563DC1),
                                  overlayColor: Color(0xffE6E2F6),
                                  tickMarkShape: RoundSliderTickMarkShape(),
                                  activeTickMarkColor: Colors.white,
                                  inactiveTickMarkColor: Colors.white,
                                  valueIndicatorColor: Color(0xff563DC1),
                                  valueIndicatorTextStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                child: Slider(
                                  value: _value,
                                  min: 0,
                                  max: 100,
                                  divisions: 4,
                                  onChanged: (value) {
                                    setState(
                                          () {
                                        _value = value;
                                        print('Finish value is ' +
                                            _value.toString());
                                        if (_value.toString() == '0.0') {
                                          _text =
                                          'Rent a Studio Apartment in downtown.Close to Stores, Gym, Restaurants & Work.';
                                          _image = 'assets/studioApartment.png';
                                          _rent = 200;
                                          _emi = 300;
                                        }
                                        if (_value.toString() == '25.0') {
                                          _text =
                                          'Rent a 1 Bedroom Apartment in Downtown. Walkable distance from Grocery stores, Restaurants, Local Gym & Work.';
                                          _image =
                                          'assets/midRiseApartment.png';
                                          _rent = 300;
                                          _emi = 400;
                                        }
                                        if (_value.toString() == '50.0') {
                                          _text =
                                          'Rent a 2 Bedroom Apartment in Upscale Building. Has a Gym, Sports facilities & shared pool. Medium distance from Work';
                                          _image =
                                          'assets/upscaleApartment.png';
                                          _rent = 500;
                                          _emi = 650;
                                        }
                                        if (_value.toString() == '75.0') {
                                          _text =
                                          'Luxury house in Posh Suburb. Close to shopping center, Gym & Hospital. Far from Work';
                                          _image = 'assets/luxuryHouse.png';
                                          _rent = 400;
                                          _emi = 600;
                                        }
                                        if (_value.toString() == '100.0') {
                                          _text =
                                          '3 bedroom  house in upcoming Suburb. No Facilities nearby. Far from Work.';
                                          _image = 'assets/suburbanHouse.png';
                                          _rent = 300;
                                          _emi = 350;
                                        }
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: displayWidth(context) * .01),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Studio \nApartment ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          color: Color(0xff563DC1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      'Mid-Rise \nApartment ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          color: Color(0xff563DC1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      'Upscale \nCondo ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          color: Color(0xff563DC1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      'Luxury \nHouse ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          color: Color(0xff563DC1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      'Suburban \nHouse',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          color: Color(0xff563DC1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: displayHeight(context) * .02,
                              ),
                              Padding(
                                padding:
                                EdgeInsets.all(displayWidth(context) * .01),
                                child: Container(
                                  height: displayHeight(context) * .08,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        displayWidth(context) * .03),
                                    color: Color(0xffF6F7FE),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          displayHeight(context) * .01),
                                      child: Text(
                                        _text,
                                        style: GoogleFonts.workSans(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.sp,
                                            color: Color(0xff3D3D3D)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: displayHeight(context) * .01,
                              ),
                              Container(
                                  height: displayHeight(context) * .06,
                                  width: displayWidth(context) * .55,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff7655E8),
                                          Color(0xff8C46ED),
                                          Color(0xff8C46ED),
                                          Color(0xff7655E8)
                                        ],
                                        // begin: Alignment.bottomLeft,
                                        // end: Alignment.topRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          displayWidth(context) * .04)),
                                  child: Center(
                                    child: Text(
                                      'Rent \$ $_rent/month',
                                      style: GoogleFonts.workSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    ),
                                  )),
                              SizedBox(
                                height: displayHeight(context) * .02,
                                child: Center(
                                    child: Text(
                                      'OR',
                                      style: GoogleFonts.workSans(fontSize: 08.sp),
                                    )),
                              ),
                              Container(
                                  height: displayHeight(context) * .06,
                                  width: displayWidth(context) * .55,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff7655E8),
                                          Color(0xff8C46ED),
                                          Color(0xff8C46ED),
                                          Color(0xff7655E8)
                                        ],
                                        // begin: Alignment.bottomLeft,
                                        // end: Alignment.topRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          displayWidth(context) * .04)),
                                  child: Center(
                                    child: Text(
                                      'EMI  \$ $_emi/month',
                                      style: GoogleFonts.workSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    ),
                                  )),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: displayWidth(context) * .06,
                                ),
                                child: Text(
                                  'Tip: Distance from amenities & work will impact your monthly transport expense',
                                  style: GoogleFonts.workSans(
                                    fontSize: 08.sp,
                                    color: Color(0xffcccccc),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * .02,
                        ),
                      ],
                    ),
                    //  ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TvAndInternetPlan()));
                        },
                        child: Container(
                          width: displayWidth(context) * .35,
                          height: displayHeight(context) * .07,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28.0),
                                bottomLeft: Radius.circular(28.0),
                              )),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: displayWidth(context) * .04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientText(
                                    text: 'Next',
                                    style: GoogleFonts.workSans(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Color(0xff6D00C2)
                                        ],
                                        transform:
                                        GradientRotation(math.pi / 2))),
                                SizedBox(
                                  width: displayWidth(context) * .03,
                                ),
                                Container(
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 18.0,
                                      color: Color(0xff6D00C2),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        //   SlideTransition(
                        //     position: Tween<Offset>(
                        //             begin: Offset(1, 0), end: Offset.zero)
                        //         .animate(_animationController),
                        //     child: FadeTransition(
                        //       opacity: _animationController,
                        //       child: Container(
                        //         width: displayWidth(context) * .35,
                        //         height: displayHeight(context) * .07,
                        //         decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(28.0),
                        //               bottomLeft: Radius.circular(28.0),
                        //             )),
                        //         child: Padding(
                        //           padding: EdgeInsets.only(
                        //               left: displayWidth(context) * .04),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               GradientText(
                        //                   text: 'Next',
                        //                   style: GoogleFonts.workSans(
                        //                       fontSize: 16.sp,
                        //                       fontWeight: FontWeight.w500,
                        //                       color: Colors.white),
                        //                   gradient: const LinearGradient(
                        //                       colors: [
                        //                         Colors.white,
                        //                         Color(0xff6D00C2)
                        //                       ],
                        //                       transform:
                        //                           GradientRotation(math.pi / 2))),
                        //               SizedBox(
                        //                 width: displayWidth(context) * .03,
                        //               ),
                        //               Container(
                        //                   child: Icon(
                        //                 Icons.arrow_forward_ios_outlined,
                        //                 size: 18.0,
                        //                 color: Color(0xff6D00C2),
                        //               )),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: displayHeight(context) * .01,
                    )
                  ],
                ))),
      ),
    );
  }
}
