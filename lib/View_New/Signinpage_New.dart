import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:projectsf341/Model/Data_Sign_In.dart';
import 'package:projectsf341/View_New/Homepage_New.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
Data_Sign_In DSI = new Data_Sign_In();
GoogleSignInAccount? _currentUser;

class Signinpage_New extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Signinpage_New_Statefulwidget(),
      ),
    );
  }
}

class Signinpage_New_Statefulwidget extends StatefulWidget {
  State<Signinpage_New_Statefulwidget> createState() =>
      _Signinpage_New_Statefulwidget();
}

class _Signinpage_New_Statefulwidget
    extends State<Signinpage_New_Statefulwidget> {
  String nameGroup = "";

  void initState() {}

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: false),
                child: Container(
                  height: 1400.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 203, 238, 249),
                    image: DecorationImage(
                      image: AssetImage('assets/images/Logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 1450.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.h, left: 0.w, right: 267.w),
                    child: Text("Let's Get",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 150.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.h, left: 0.w, right: 347.w),
                    child: Text("Started",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 150.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.w, left: 0.w, right: 125.w),
                    child: Text("We  work together, Everything will  better.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      _googleSignIn.onCurrentUserChanged.listen((account) {
                        _currentUser = account;
                        setState(() {
                          DSI.setCurrentUser(_currentUser);
                        });
                      });
                      _googleSignIn.signInSilently();
                      signin(context);
                    },
                    child: Ink(
                      height: 288.h,
                      width: 900.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/googleicon.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // reset of your code
          ],
        ),
      ),
    );
  }
}

Future<void> signin(context) async {
  try {
    await _googleSignIn.signIn();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) {
          return Homepage_New();
        }),
      ),
    );
  } catch (e) {}
}

Data_Sign_In getUserFsn() {
  return DSI;
}

GoogleSignIn getGoogleSignIn() {
  return _googleSignIn;
}
