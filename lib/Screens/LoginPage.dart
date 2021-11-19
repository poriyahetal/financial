import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_auth/email_auth.dart';
import 'package:financial/Screens/LevelOneSetUpPage.dart';
import 'package:financial/Screens/devicesSizePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showLoading = false;
  String? dropdownvalue = '+91';
  FirebaseAuth _auth = FirebaseAuth.instance;

  EmailAuth emailAuth = new EmailAuth(sessionName: "Financial App");

  String? text;

  //function for user login
  Future<bool?> loginUser(String phone, BuildContext context) async {
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
          Fluttertoast.showToast(msg: exception.code.toString());
          Fluttertoast.showToast(msg: 'Please try later');
          Navigator.pop(context);
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          showLoading = false;
          Fluttertoast.showToast(msg: "Code send to your device");
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext bContext) {
                return AlertDialog(
                  contentPadding: EdgeInsets.only(
                      top: 12.0, left: 15.0, bottom: 12.0, right: 15.0),
                  title: Column(
                    children: [
                      Center(
                          child: Text(
                        'ENTER OTP',
                        style: GoogleFonts.workSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4D6EF2),
                        ),
                      )),
                      SizedBox(
                        height: 4.0,
                      ),
                      Divider(thickness: 2.0, color: Colors.black26),
                    ],
                  ),
                  elevation: 1.0,
                  content: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'OTP',
                        labelStyle: GoogleFonts.workSans(color: Colors.black)),
                    controller: _codeController,
                    style: GoogleFonts.workSans(
                        fontSize: 12.sp, color: Colors.red),
                    keyboardType: TextInputType.number,
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            // PhoneAuthCredential? authCredential;
                            // print(authCredential?.smsCode);
                            try {
                              final code = _codeController.text.trim();
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: code,
                              );
                              UserCredential result =
                                  await _auth.signInWithCredential(credential);
                              User? user = result.user;
                              Navigator.of(context).pop();
                              if (user != null) {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setString('uId', user.uid);
                                print('Sign in ');
                                print(user.uid);
                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection("User");
                                users
                                    .doc(user.uid)
                                    .set({
                                      'credit_card_bill': 0,
                                      'payable_bill': 0,
                                      'credit_card_balance': 0,
                                      'level_id': 0,
                                      'bill_payment': 0,
                                      'credit_score': 0,
                                      'game_score': 0,
                                      'mobile_number': user.phoneNumber,
                                      'net_worth': 0,
                                      'previous_session_info': '',
                                      'quality_of_life': 0,
                                      'account_balance': 0,
                                      'score': 0,
                                      'replay_level': false,
                                      'last_level': 'Level_1',
                                      'need': 0,
                                      'want': 0
                                    })
                                    .then((value) => print('add'))
                                    .catchError((error) => print('$error'));
                                print(users.id);
                                Navigator.of(context).pop();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LevelOneSetUpPage(
                                              user: user,
                                              controller: PageController(),
                                            )),
                                    (Route<dynamic> route) => false);
                              } else {
                                print("Error");
                              }
                            } catch (e) {
                              print('${e.toString()}');
                              // Fluttertoast.showToast(msg: e.toString());
                              Fluttertoast.showToast(
                                  msg: 'Please enter valid OTP');
                            }
                          },
                          child: Container(
                            height: displayHeight(context) * .08,
                            width: displayWidth(context) * .60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff4D6EF2),
                                  Color(0xff6448E8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(
                                  displayWidth(context) * .12),
                            ),
                            child: Center(
                              child: Text(
                                'Send',
                                style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        verificationCompleted: (AuthCredential credential) async {
          Fluttertoast.showToast(msg: 'Verification Completed');
          Fluttertoast.showToast(msg: 'You are Logged In succesfully');
          UserCredential result = await _auth.signInWithCredential(credential);
          User? user = result.user;
          if (user != null) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('uId', user.uid);
            pref.setString('number', user.phoneNumber.toString());
            CollectionReference users =
                FirebaseFirestore.instance.collection("User");
            users
                .doc(user.uid)
                .set({
                  'credit_card_bill': 0,
                  'payable_bill': 0,
                  'credit_card_balance': 0,
                  'level_id': 0,
                  'bill_payment': 0,
                  'credit_score': 0,
                  'game_score': 0,
                  'mobile_number': user.phoneNumber,
                  'net_worth': 0,
                  'previous_session_info': '',
                  'quality_of_life': 0,
                  'account_balance': 0,
                  'score': 0,
                  'replay_level': false,
                  'last_level': 'Level_1',
                  'need': 0,
                  'want': 0
                })
                .then((value) => print('add'))
                .catchError((error) => print('$error'));

            print(user.uid);
            print(user.phoneNumber);
            Navigator.of(context).pop();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => LevelOneSetUpPage(
                          user: user,
                          controller: PageController(),
                        )),
                (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(msg: "Failed to Verify Phone Number");
          }
          //This callback would gets called when verification is done auto maticlly
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(msg: "codeAutoRetrievalTimeout");
        },
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  void sendOtp() async {
    print(_emailController.text);
    var res =
        await emailAuth.sendOtp(recipientMail: _emailController.text);
    print('REEEE $res');
    try {
      if (res) {
        Fluttertoast.showToast(msg: "Code send to your device");
        showDialog(
            context: context,
            builder: (BuildContext bContext) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(
                    top: 12.0, left: 15.0, bottom: 12.0, right: 15.0),
                title: Column(
                  children: [
                    Center(
                        child: Text(
                      'ENTER OTP',
                      style: GoogleFonts.workSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4D6EF2),
                      ),
                    )),
                    SizedBox(
                      height: 4.0,
                    ),
                    Divider(thickness: 2.0, color: Colors.black26),
                  ],
                ),
                elevation: 1.0,
                content: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'OTP',
                      labelStyle: GoogleFonts.workSans(color: Colors.black)),
                  controller: _codeController,
                  style:
                      GoogleFonts.workSans(fontSize: 12.sp, color: Colors.red),
                  keyboardType: TextInputType.number,
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          verifyOtp();
                        },
                        child: Container(
                          height: displayHeight(context) * .08,
                          width: displayWidth(context) * .60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff4D6EF2),
                                Color(0xff6448E8),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(
                                displayWidth(context) * .12),
                          ),
                          child: Center(
                            child: Text(
                              'Send',
                              style: GoogleFonts.workSans(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      } else {
        Fluttertoast.showToast(msg: 'We could not send OTP');
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      Navigator.pop(context);
      // Fluttertoast.showToast(
      //     msg: 'Please enter valid Email');
    }
  }

  Future<void> verifyOtp() async {
    print('email ${_emailController.text}');
    print('otp ${_codeController.text}');
    var res = emailAuth.validateOtp(
        recipientMail: _emailController.text, userOtp: _codeController.text);
    print('My res $res');
    if (res) {
      try {
        FirebaseAuth _auth = FirebaseAuth.instance;
        final code = _codeController.text.trim();
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: code);
        print('my cred $credential');
        User? user = credential.user;
        print('My User ${credential.user}');
        Navigator.of(context).pop();
        if (user != null) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('uId', user.uid);
          print('Sign in ');
          print(user.uid);
          CollectionReference users =
              FirebaseFirestore.instance.collection("User");
          users
              .doc(user.uid)
              .set({
                'credit_card_bill': 0,
                'payable_bill': 0,
                'credit_card_balance': 0,
                'level_id': 0,
                'bill_payment': 0,
                'credit_score': 0,
                'game_score': 0,
                'mobile_number': _emailController.text,
                'net_worth': 0,
                'previous_session_info': '',
                'quality_of_life': 0,
                'account_balance': 0,
                'score': 0,
                'replay_level': false,
                'last_level': 'Level_1',
                'need': 0,
                'want': 0
              })
              .then((value) => print('add'))
              .catchError((error) => print('$error'));
          print(users.id);
          Navigator.of(context).pop();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => LevelOneSetUpPage(
                        user: user,
                        controller: PageController(),
                      )),
              (Route<dynamic> route) => false);
        } else {
          print("Error");
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
        Navigator.pop(context);
        // Fluttertoast.showToast(
        //     msg: 'Please enter valid OTP');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please enter valid OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: displayHeight(context) * .01.h,
                ),
                Image.asset('assets/login.png'),
                SizedBox(
                  height: displayHeight(context) * .01.h,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: displayWidth(context) * .32,
                        child: CountryCodePicker(
                          onChanged: _onCountryChange,
                          showCountryOnly: false,
                          initialSelection: 'IN',
                          favorite: ['+91', 'IN'],
                          showFlagMain: true,
                          textStyle: GoogleFonts.workSans(
                              color: Colors.black, fontSize: 12.sp),
                          dialogSize: Size(displayWidth(context) * .80,
                              displayHeight(context) * .80),
                          padding: EdgeInsets.symmetric(
                              vertical: displayHeight(context) * .02,
                              horizontal: displayHeight(context) * .02),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey)),
                      ),
                      SizedBox(
                        width: displayWidth(context) * .02,
                      ),
                      Container(
                        width: displayWidth(context) * .60,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: displayHeight(context) * .03,
                                  horizontal: displayHeight(context) * .03),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          displayWidth(context) * .02)),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          displayWidth(context) * .02)),
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintStyle:
                                  GoogleFonts.workSans(color: Colors.black),
                              hintText: "Enter mobile Number"),
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .05,
                  child: Center(child: Text('OR')),
                ),
                Container(
                  width: displayWidth(context) * .92,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: displayHeight(context) * .03,
                            horizontal: displayHeight(context) * .03),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(displayWidth(context) * .02)),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(displayWidth(context) * .02)),
                            borderSide: BorderSide(color: Colors.grey)),
                        hintStyle: GoogleFonts.workSans(color: Colors.black),
                        hintText: "Enter Email Address"),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * .02,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      String pattern = r'^([0-9]{10})$';
                      String patternEmail =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      if (_phoneController.text.isEmpty &&
                          _emailController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Please enter your phone number or email');
                      } else {
                        if (_phoneController.text.isNotEmpty &&
                            _emailController.text.isEmpty) {
                          if (dropdownvalue!.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please select your country code');
                            return null;
                          }
                          if (_phoneController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter your phone number');
                            return null;
                          } else {

                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(_phoneController.text)) {
                              Fluttertoast.showToast(
                                  msg: 'Please enter valid  phone number');
                              return null;
                            }
                          }
                          if (dropdownvalue!.isNotEmpty &&
                              _phoneController.text.isNotEmpty) {
                            showLoading = true;
                            if (showLoading)
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  );
                                },
                              );
                          }
                          print("drop " + dropdownvalue.toString());
                          final phone =
                              dropdownvalue! + _phoneController.text.trim();
                          PhoneAuthCredential? authCredential;
                          loginUser(phone, context).then((value) {
                            showLoading = false;
                          });
                        }
                        if (_emailController.text.isNotEmpty &&
                            _phoneController.text.isEmpty) {
                          if (_emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please enter your email');
                            return null;
                          } else {
                            RegExp regExp = RegExp(patternEmail);
                            if (!regExp.hasMatch(_emailController.text)) {
                              Fluttertoast.showToast(
                                  msg: 'Please enter valid  email ');
                              return null;
                            }
                          }
                          print(_emailController.text);
                          sendOtp();
                        }
                      }
                      if (_phoneController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty) {
                        RegExp regExp = RegExp(pattern);
                        RegExp regExpEmail = RegExp(patternEmail);
                        if(!regExp.hasMatch(_phoneController.text) ){
                          Fluttertoast.showToast(
                              msg: 'Please enter valid  phone number');
                          return null;
                        } else {
                          final phone =
                              dropdownvalue! + _phoneController.text.trim();
                          PhoneAuthCredential? authCredential;
                          loginUser(phone, context).then((value) {
                            showLoading = false;
                          });
                        }
                      }
                    },
                    child: Container(
                      height: displayHeight(context) * .08,
                      width: displayWidth(context) * .60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff4D6EF2),
                            Color(0xff6448E8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * .12),
                      ),
                      child: Center(
                        child: Text(
                          'Send otp',
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    // this.phoneNumber =  countryCode.toString();
    setState(() {
      dropdownvalue = countryCode.toString();
    });
    print("New Country selected: " + countryCode.toString());
  }
}
