import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:projectsf341/View_New/Grouppage_New.dart';
import 'package:projectsf341/View_New/Homepage_New.dart';
import 'package:projectsf341/View_New/Signinpage_New.dart';

final Future<FirebaseApp> firebase_notificationpage = Firebase.initializeApp();

GoogleSignIn _googleSignIn = getGoogleSignIn();
GoogleSignInAccount? _currentUser;

var subject = getSubject();
var subject_mb = getSubject() + "_MB";
var subject_ev = getSubject() + "_EV";

DateTime d = DateTime.now();

class Eventpage_New extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Eventpage_New_Statefulwidget(),
      ),
    );
  }
}

class Eventpage_New_Statefulwidget extends StatefulWidget {
  State<Eventpage_New_Statefulwidget> createState() =>
      _Eventpage_New_Statefulwidget();
}

class _Eventpage_New_Statefulwidget
    extends State<Eventpage_New_Statefulwidget> {
  GoogleSignInAccount? _currentUser = getUserFsn().getCurrentUser;

  var event = getEvent();
  var rank = getRank();
  var status = getStatus();
  var time_date = getTimedate();
  var time_hm = getTimehm();

  var time_end_fm;

  List<Color> colors = [
    Color.fromARGB(255, 237, 191, 191),
    Color.fromARGB(255, 71, 211, 139),
    Color.fromARGB(255, 162, 0, 255),
    Colors.amber,
    Colors.blueAccent,
    Color.fromARGB(255, 20, 209, 209),
    Colors.pinkAccent,
    Colors.greenAccent,
    Colors.indigoAccent,
  ];
  List<Color> colors1 = [
    Color.fromARGB(255, 205, 165, 165),
    Color.fromARGB(255, 58, 170, 112),
    Color.fromARGB(255, 114, 4, 177),
    Color.fromARGB(255, 211, 160, 8),
    Color.fromARGB(255, 55, 111, 207),
    Color.fromARGB(255, 19, 172, 172),
    Color.fromARGB(255, 216, 56, 109),
    Color.fromARGB(255, 90, 208, 151),
    Color.fromARGB(255, 69, 91, 210),
  ];

  Widget build(BuildContext context) {
    //LEADER RANK
    if (rank == "LEADER") {
      //EVENT IS NOT END
      if (status != false) {
        return Scaffold(
          backgroundColor: Colors.white24,
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipPath(
                        clipper: WaveClipperTwo(reverse: false),
                        child: Container(
                          height: 950.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colors[getIndex()],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 50.sp,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return Grouppage_New();
                                            }),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 6,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.h, bottom: 10.h),
                                    child: Text(
                                      'Events',
                                      style: TextStyle(
                                        fontSize: 50.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 6,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete_forever,
                                        size: 50.sp,
                                      ),
                                      onPressed: () {
                                        removeEvent(event);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return Grouppage_New();
                                            }),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.0.h),
                                child: Container(
                                  height: 500.h,
                                  width: 975.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  right: 0,
                                                  bottom: 4.h),
                                              child: Text(
                                                event[0] +
                                                    event[1] +
                                                    event[2] +
                                                    event[3] +
                                                    event[4],
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 115.0,
                                                  height: 40.0,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      225,
                                                                      225,
                                                                      225)),
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Text(
                                                              'End event',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        124,
                                                                        124,
                                                                        124),
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      ev_status_change();
                                                      setState(() {
                                                        status = false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, right: 0, bottom: 19),
                                              child: Text(
                                                'Time : ' + time_hm,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 55,
                                                  right: 0,
                                                  bottom: 19),
                                              child: Text(
                                                'Date : ' + time_date,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(flex: 2),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 30.h, right: 650.w, bottom: 30.h),
                  child: Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 60.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1150.h,
                  width: 950.w,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(subject_mb)
                          .orderBy("RANK_MB")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            padding: EdgeInsets.all(20.w),
                            children: snapshot.data!.docs.map((document) {
                              if (document[event] == false &&
                                  document["RANK_MB"] != "LEADER") {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Container(
                                    height: 150.h,
                                    width: 300.w,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0.h),
                                          child: Container(
                                            width: 100.w,
                                            height: 100.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                document["EMAIL_MB"][0] +
                                                    document["EMAIL_MB"][1],
                                                style: TextStyle(
                                                  fontSize: 50.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 7.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 200.w,
                                                child: Text(
                                                  document["EMAIL_MB"][0] +
                                                      document["EMAIL_MB"][1] +
                                                      document["EMAIL_MB"][2] +
                                                      document["EMAIL_MB"][3] +
                                                      document["EMAIL_MB"][4] +
                                                      document["EMAIL_MB"][5],
                                                  style: TextStyle(
                                                    fontSize: 45.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, top: 3.h),
                                          child: SizedBox(
                                            width: 210.0.w,
                                            height: 100.0.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 27, 174, 11)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                      ),
                                                      child: Text(
                                                        'Present',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                present(document["EMAIL_MB"]);
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, top: 3.h),
                                          child: SizedBox(
                                            width: 210.0.w,
                                            height: 100.0.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 223, 14, 14)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                      ),
                                                      child: Text(
                                                        'Absent',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                absent(document["EMAIL_MB"]);
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                );
                              }
                            }).toList(),
                          );
                        }
                      }),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      //EVENT END
      else {
        return Scaffold(
          backgroundColor: Colors.white24,
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipPath(
                        clipper: WaveClipperTwo(reverse: false),
                        child: Container(
                          height: 950.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colors[getIndex()],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 50.sp,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return Grouppage_New();
                                            }),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 6,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.h, bottom: 10.h),
                                    child: Text(
                                      'Events',
                                      style: TextStyle(
                                        fontSize: 50.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(flex: 6),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete_forever,
                                        size: 50.sp,
                                      ),
                                      onPressed: () {
                                        removeEvent(event);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return Grouppage_New();
                                            }),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.0.h),
                                child: Container(
                                  height: 500.h,
                                  width: 975.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  right: 0,
                                                  bottom: 4.h),
                                              child: Text(
                                                event[0] +
                                                    event[1] +
                                                    event[2] +
                                                    event[3] +
                                                    event[4],
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0, bottom: 10.h),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 280.0.w,
                                                  height: 80.0.h,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15.h),
                                                    child: Text(
                                                      "Event is OVER!",
                                                      style: TextStyle(
                                                          fontSize: 40.sp,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, right: 0, bottom: 19),
                                              child: Text(
                                                'Time : ' + time_hm,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 55,
                                                  right: 0,
                                                  bottom: 19),
                                              child: Text(
                                                'Date : ' + time_date,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.h, right: 650.w, bottom: 0.h),
                  child: Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 60.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1150.h,
                  width: 950.w,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(subject_mb)
                          .orderBy("RANK_MB")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            padding: EdgeInsets.all(10.w),
                            children: snapshot.data!.docs.map((document) {
                              if (document[event] == false &&
                                  document["RANK_MB"] != "LEADER") {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Container(
                                    height: 150.h,
                                    width: 300.w,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0.h),
                                          child: Container(
                                            width: 100.w,
                                            height: 100.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                document["EMAIL_MB"][0] +
                                                    document["EMAIL_MB"][1],
                                                style: TextStyle(
                                                  fontSize: 50.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 7.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 200.w,
                                                child: Text(
                                                  document["EMAIL_MB"][0] +
                                                      document["EMAIL_MB"][1] +
                                                      document["EMAIL_MB"][2] +
                                                      document["EMAIL_MB"][3] +
                                                      document["EMAIL_MB"][4] +
                                                      document["EMAIL_MB"][5],
                                                  style: TextStyle(
                                                    fontSize: 45.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, top: 3.h),
                                          child: SizedBox(
                                            width: 210.0.w,
                                            height: 100.0.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 27, 174, 11)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                      ),
                                                      child: Text(
                                                        'Present',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                present(document["EMAIL_MB"]);
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, top: 3.h),
                                          child: SizedBox(
                                            width: 210.0.w,
                                            height: 100.0.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 223, 14, 14)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                      ),
                                                      child: Text(
                                                        'Absent',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                absent(document["EMAIL_MB"]);
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                );
                              }
                            }).toList(),
                          );
                        }
                      }),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    //ANOTHER RANK
    else {
      //EVENT IS NOT END
      if (status != false) {
        return Scaffold(
          backgroundColor: Colors.white24,
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipPath(
                        clipper: WaveClipperTwo(reverse: false),
                        child: Container(
                          height: 950.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colors[getIndex()],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 50.sp,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return Grouppage_New();
                                            }),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 6,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.h, bottom: 10.h),
                                    child: Text(
                                      'Events',
                                      style: TextStyle(
                                        fontSize: 50.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.0.h),
                                child: Container(
                                  height: 500.h,
                                  width: 975.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  right: 0,
                                                  bottom: 4.h),
                                              child: Text(
                                                event[0] +
                                                    event[1] +
                                                    event[2] +
                                                    event[3] +
                                                    event[4],
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(
                                            flex: 4,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0, bottom: 10.h),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 350.0.w,
                                                  height: 80.0.h,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15.h),
                                                    child: Text(
                                                      "Event is RUNNING!",
                                                      style: TextStyle(
                                                          fontSize: 40.sp,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, right: 0, bottom: 19),
                                              child: Text(
                                                'Time : ' + time_hm,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 55,
                                                  right: 0,
                                                  bottom: 19),
                                              child: Text(
                                                'Date : ' + time_date,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 30.h, right: 650.w, bottom: 30.h),
                  child: Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 60.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1150.h,
                  width: 950.w,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(subject_mb)
                          .orderBy("RANK_MB")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            padding: EdgeInsets.all(20.w),
                            children: snapshot.data!.docs.map((document) {
                              if (document[event] == false &&
                                  document["RANK_MB"] != "LEADER") {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Container(
                                    height: 150.h,
                                    width: 300.w,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0.h),
                                          child: Container(
                                            width: 100.w,
                                            height: 100.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                document["EMAIL_MB"][0] +
                                                    document["EMAIL_MB"][1],
                                                style: TextStyle(
                                                  fontSize: 50.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 7.h),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 200.w,
                                                child: Text(
                                                  document["EMAIL_MB"][0] +
                                                      document["EMAIL_MB"][1] +
                                                      document["EMAIL_MB"][2] +
                                                      document["EMAIL_MB"][3] +
                                                      document["EMAIL_MB"][4] +
                                                      document["EMAIL_MB"][5],
                                                  style: TextStyle(
                                                    fontSize: 45.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, top: 3.h),
                                          child: SizedBox(
                                            width: 210.0.w,
                                            height: 100.0.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 27, 174, 11)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                      ),
                                                      child: Text(
                                                        'Present',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                present(document["EMAIL_MB"]);
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0, top: 3.h),
                                          child: SizedBox(
                                            width: 210.0.w,
                                            height: 100.0.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color.fromARGB(
                                                            255, 223, 14, 14)),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                      ),
                                                      child: Text(
                                                        'Absent',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 33.5.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                absent(document["EMAIL_MB"]);
                                              },
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                );
                              }
                            }).toList(),
                          );
                        }
                      }),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      //EVENT END
      else {
        return Scaffold(
          backgroundColor: Colors.white24,
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipPath(
                        clipper: WaveClipperTwo(reverse: false),
                        child: Container(
                          height: 950.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colors[getIndex()],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 50.sp,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) {
                                              return Grouppage_New();
                                            }),
                                          ),
                                        );
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 6,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.h, bottom: 10.h),
                                    child: Text(
                                      'Events',
                                      style: TextStyle(
                                        fontSize: 50.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.0.h),
                                child: Container(
                                  height: 500.h,
                                  width: 975.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  right: 0,
                                                  bottom: 4.h),
                                              child: Text(
                                                event[0] +
                                                    event[1] +
                                                    event[2] +
                                                    event[3] +
                                                    event[4],
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(
                                            flex: 2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0, bottom: 10.h),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 280.0.w,
                                                  height: 80.0.h,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15.h),
                                                    child: Text(
                                                      "Event is OVER!",
                                                      style: TextStyle(
                                                          fontSize: 40.sp,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, right: 0, bottom: 19),
                                              child: Text(
                                                'Time : ' + time_hm,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 55,
                                                  right: 0,
                                                  bottom: 19),
                                              child: Text(
                                                'Date : ' + time_date,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 30.h, right: 650.w, bottom: 30.h),
                  child: Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 60.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 1150.h,
                  width: 950.w,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(subject_mb)
                          .orderBy("RANK_MB")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                            padding: EdgeInsets.all(20.w),
                            children: snapshot.data!.docs.map((document) {
                              return Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Container(
                                  height: 150.h,
                                  width: 300.w,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.0.h),
                                        child: Container(
                                          width: 100.w,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              document["EMAIL_MB"][0] +
                                                  document["EMAIL_MB"][1],
                                              style: TextStyle(
                                                fontSize: 50.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(top: 7.h),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200.w,
                                              child: Text(
                                                document["EMAIL_MB"][0] +
                                                    document["EMAIL_MB"][1] +
                                                    document["EMAIL_MB"][2] +
                                                    document["EMAIL_MB"][3] +
                                                    document["EMAIL_MB"][4] +
                                                    document["EMAIL_MB"][5],
                                                style: TextStyle(
                                                  fontSize: 45.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(
                                        flex: 12,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      }),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}

Future<void> present(current_email) async {
  var _collection_1 = FirebaseFirestore.instance.collection(subject_mb);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    var collection = FirebaseFirestore.instance.collection(subject_mb);
    var docSnapshot = await collection.doc(documentID).get();
    Map<String, dynamic>? data = docSnapshot.data();
    final Map<String, dynamic> convertedData = jsonDecode(jsonEncode(data));
    if (convertedData["EMAIL_MB"] == current_email) {
      var time = convertedData["TIME_MB"];
      time += 1;
      var _collection_3 = FirebaseFirestore.instance.collection(subject_mb);
      _collection_3.doc(documentID) // <-- Doc ID where data should be updated.
          .update({"TIME_MB": time, event: true});
    }
  }
}

Future<void> absent(current_email) async {
  var _collection_1 = FirebaseFirestore.instance.collection(subject_mb);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    var collection = FirebaseFirestore.instance.collection(subject_mb);
    var docSnapshot = await collection.doc(documentID).get();
    Map<String, dynamic>? data = docSnapshot.data();
    final Map<String, dynamic> convertedData = jsonDecode(jsonEncode(data));
    if (convertedData["EMAIL_MB"] == current_email) {
      var _collection_3 = FirebaseFirestore.instance.collection(subject_mb);
      _collection_3.doc(documentID) // <-- Doc ID where data should be updated.
          .update({event: true});
    }
  }
}

Future<void> ev_status_change() async {
  var _collection_1 = FirebaseFirestore.instance.collection(subject_ev);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(subject_ev)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        if (value["NAME_EV"] == event) {
          var _collection_2 = FirebaseFirestore.instance.collection(subject_ev);
          _collection_2
              .doc(documentID) // <-- Doc ID where data should be updated.
              .update({"STATUS_EV": false});
        }
      } else {}
    });
  }

  Timestamp t = Timestamp.now();
  d = t.toDate();
}

Future<void> removeEvent(name_event) async {
  var _collection_1 = FirebaseFirestore.instance.collection(subject_ev);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(subject_ev)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        if (value["NAME_EV"] == name_event) {
          var _collection_2 = FirebaseFirestore.instance.collection(subject_ev);
          _collection_2
              .doc(documentID) // <-- Doc ID where data should be updated.
              .delete();
        }
      } else {}
    });
  }
}
