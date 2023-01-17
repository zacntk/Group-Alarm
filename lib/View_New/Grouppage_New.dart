import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:o_popup/o_popup.dart';
import 'dart:math';

import 'package:projectsf341/View_New/Eventpage_New.dart';
import 'package:projectsf341/View_New/Homepage_New.dart';
import 'package:projectsf341/View_New/Signinpage_New.dart';

GoogleSignIn _googleSignIn = getGoogleSignIn();
GoogleSignInAccount? _currentUser;

late TextEditingController controller_gp, controller_ev;
var username, useremail, dt, user, time_date, time_hm;

TimeOfDay _time = TimeOfDay.now();

var event, time, status, rank, pickDate, time_ev, index_to_eventpage;

List<DateTime?> _dialogCalendarPickerValue = [DateTime.now()];
List<DateTime?> _selectedDate = [DateTime.now()];
List<DateTime?> _selectedDateList = [DateTime.now()];

var date_show = _selectedDateList.last;
var formattedDate = "${date_show!.day}-${date_show!.month}-${date_show!.year}";

int index = -1;
Random random = new Random();

class Grouppage_New extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Grouppage_New_Statefulwidget(),
      ),
    );
  }
}

class Grouppage_New_Statefulwidget extends StatefulWidget {
  State<Grouppage_New_Statefulwidget> createState() =>
      _Grouppage_New_Statefulwidget();
}

class _Grouppage_New_Statefulwidget
    extends State<Grouppage_New_Statefulwidget> {
  GoogleSignInAccount? _currentUser = getUserFsn().getCurrentUser;
  final Future<FirebaseApp> firebase_grouppage = Firebase.initializeApp();

  String nameGroup = "";
  String subject = getSubject();
  String subject_mb = getSubject() + "_MB";
  String subject_ev = getSubject() + "_EV";
  String leader = getLeader();

  void initState() {
    super.initState();
    controller = TextEditingController();
    controller_gp = TextEditingController();
    controller_ev = TextEditingController();
    Firebase.initializeApp().whenComplete(
      () {},
    );
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    user = _currentUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: firebase_grouppage,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(subject)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot_1) {
                        if (snapshot_1.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (_currentUser?.email.replaceAll("", "") ==
                              leader) {
                            final docs_1 = snapshot_1.data?.docs;
                            var length = docs_1!.length;
                            if (length != 0) {
                              final data_1 = Map.from(docs_1![length - 1].data()
                                  as Map<String, dynamic>);
                              var index = (data_1["INDEX"] * 10);
                              while (index > 8) {
                                index -= 7;
                              }

                              return Column(
                                children: [
                                  Container(
                                    height: 900.h,
                                    decoration: BoxDecoration(
                                      color: colors[index],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.h),
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
                                                      return Homepage_New();
                                                    }),
                                                  ),
                                                );
                                              },
                                              color: Colors.white,
                                            ),
                                          ),
                                          Spacer(),
                                          Spacer(),
                                          Spacer(),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 20.h,
                                            ),
                                            child: Text(
                                              'Group and Events',
                                              style: TextStyle(
                                                fontSize: 50.sp,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Spacer(),
                                          Spacer(),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: SizedBox(
                                              child: PopupMenuButton(
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      PopupMenuItem<int>(
                                                          value: 1,
                                                          child: Text(
                                                              "Delete Group")),
                                                    ];
                                                  },
                                                  child: Icon(
                                                    Icons.settings,
                                                    color: Colors.white,
                                                    size: 50.sp,
                                                  ),
                                                  onSelected: (value) {
                                                    if (value == 1) {
                                                      delete(context, subject);
                                                    } else {}
                                                  }),
                                            ),
                                          ),
                                          Spacer(),
                                        ]),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 80.h),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 30.h,
                                                      left: 0,
                                                      right: 0,
                                                      bottom: 16.h),
                                                  child: Text(
                                                    subject,
                                                    style: TextStyle(
                                                      fontSize: 100.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                    ),
                                                    maxLines: 3,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                data_1["AMOUNT_MB"].toString() +
                                                    ' members',
                                                style: TextStyle(
                                                  fontSize: 40.sp,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30.0.h),
                                                child: SizedBox(
                                                  width: 350.0.w,
                                                  height: 140.0.h,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  colors1[
                                                                      index]),
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: OPopupTrigger(
                                                        barrierColor:
                                                            colors[index]
                                                                .withOpacity(
                                                                    0.9),
                                                        barrierDismissible:
                                                            true, // by default barrier is dismissible, you can change it though
                                                        triggerWidget:
                                                            Container(
                                                          height: 40,
                                                          width: 130,
                                                          child: Center(
                                                            child: Text(
                                                              "Add Member",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      40.sp,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                        ),
                                                        popupHeader: OPopupContent
                                                            .standardizedHeader(
                                                                'Press Around To Exit'),
                                                        popupContent: Center(
                                                          child:
                                                              SingleChildScrollView(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(30
                                                                              .w),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        350.h,
                                                                    width:
                                                                        750.w,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.w)),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              100.h,
                                                                          width:
                                                                              500.w,
                                                                          child:
                                                                              TextField(
                                                                            style:
                                                                                TextStyle(color: colors[index]),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            autofocus:
                                                                                true,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Input Email User",
                                                                              hintStyle: TextStyle(color: colors[index].withOpacity(0.3), fontSize: 40.sp),
                                                                            ),
                                                                            controller:
                                                                                controller_gp,
                                                                          ),
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            CollectionReference
                                                                                _addMember =
                                                                                FirebaseFirestore.instance.collection(controller_gp.text.replaceAll("@gmail.com", "_IV"));
                                                                            _addMember.add({
                                                                              "ID_SJ": getSubject(),
                                                                              "Inviter": _currentUser?.email,
                                                                              "Time_IV": Timestamp.fromDate(DateTime.now()),
                                                                              "INDEX": index
                                                                            });
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: ((context) {
                                                                                  return Grouppage_New();
                                                                                }),
                                                                              ),
                                                                            );
                                                                            controller_gp.clear();
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                colors1[index],
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            "ADD",
                                                                            style:
                                                                                TextStyle(fontSize: 40.sp),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Spacer(),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 50.0.h),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 50.0.h),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Members',
                                                style: TextStyle(
                                                  fontSize: 55.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5.0.h),
                                          child: SizedBox(
                                            height: 500.h,
                                            child: StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection(subject_mb)
                                                    .orderBy("RANK_MB")
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapshot_2) {
                                                  if (!snapshot_2.hasData) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  } else {
                                                    //Leader
                                                    return ListView(
                                                      padding:
                                                          EdgeInsets.all(10.w),
                                                      children: snapshot_2
                                                          .data!.docs
                                                          .map((document) {
                                                        //set rank value
                                                        if (_currentUser?.email
                                                                .replaceAll(
                                                                    "@gmail.com",
                                                                    "") ==
                                                            document[
                                                                "EMAIL_MB"]) {
                                                          rank = document[
                                                              "RANK_MB"];
                                                        }
                                                        //check rank is leader??
                                                        if (document[
                                                                "RANK_MB"] ==
                                                            "LEADER") {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 0.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 15
                                                                              .h,
                                                                          left:
                                                                              60.w),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            120.w,
                                                                        height:
                                                                            120.h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            document["EMAIL_MB"][0] +
                                                                                document["EMAIL_MB"][1],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 50.sp,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 40.0.w,
                                                                              right: 20.w,
                                                                              top: 10.h),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                360.w,
                                                                            child:
                                                                                Text(
                                                                              document["EMAIL_MB"][0] + document["EMAIL_MB"][1] + document["EMAIL_MB"][2] + document["EMAIL_MB"][3] + document["EMAIL_MB"][4] + document["EMAIL_MB"][5] + " (Leader)",
                                                                              style: TextStyle(
                                                                                fontSize: 50.h,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 10.0.w,
                                                                              top: 2.h),
                                                                          child:
                                                                              Text(
                                                                            'Number of participants : ' +
                                                                                document["TIME_MB"].toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 30.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                        //If not leader
                                                        else {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 0.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 15
                                                                              .h,
                                                                          left:
                                                                              60.w),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            120.w,
                                                                        height:
                                                                            120.h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.black,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            document["EMAIL_MB"][0] +
                                                                                document["EMAIL_MB"][1],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 50.sp,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 40.0.w,
                                                                              right: 20.w,
                                                                              top: 10.h),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                335.w,
                                                                            child:
                                                                                Text(
                                                                              document["EMAIL_MB"][0] + document["EMAIL_MB"][1] + document["EMAIL_MB"][2] + document["EMAIL_MB"][3] + document["EMAIL_MB"][4] + document["EMAIL_MB"][5],
                                                                              style: TextStyle(
                                                                                fontSize: 50.h,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 35.0.w,
                                                                              top: 2.h),
                                                                          child:
                                                                              Text(
                                                                            'Number of participants : ' +
                                                                                document["TIME_MB"].toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 30.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Spacer(),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              300.0.w),
                                                                      child:
                                                                          SizedBox(
                                                                        child: PopupMenuButton(
                                                                            itemBuilder: (BuildContext context) {
                                                                              return [
                                                                                PopupMenuItem<int>(value: 1, child: Text("Remove Member")),
                                                                              ];
                                                                            },
                                                                            child: Icon(
                                                                              Icons.more_horiz,
                                                                              size: 70.sp,
                                                                            ),
                                                                            onSelected: (value) {
                                                                              if (value == 1) {
                                                                                removeMember(document["EMAIL_MB"], subject);
                                                                              } else {}
                                                                            }),
                                                                      ),
                                                                    ),
                                                                    Spacer()
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      }).toList(),
                                                    );
                                                  }
                                                }),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 50.0.w,
                                                  right: 0.0,
                                                  top: 5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Event',
                                                    style: TextStyle(
                                                      fontSize: 55.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 550.w,
                                                  ),
                                                  OPopupTrigger(
                                                    barrierColor: colors[index]
                                                        .withOpacity(0.9),
                                                    triggerWidget: Container(
                                                      height: 100.h,
                                                      width: 250.w,
                                                      decoration: BoxDecoration(
                                                          color: colors1[index],
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset:
                                                                  Offset(0, 3),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Center(
                                                        child: Text(
                                                          "Add Event",
                                                          style: TextStyle(
                                                              fontSize: 40.sp,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                        ),
                                                      ),
                                                    ),
                                                    popupHeader: OPopupContent
                                                        .standardizedHeader(
                                                            'Press Around To Exit'),
                                                    popupContent: Center(
                                                      child:
                                                          SingleChildScrollView(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(30),
                                                              child: Container(
                                                                height: 700.h,
                                                                width: 750.w,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          50.h,
                                                                      width:
                                                                          500.w,
                                                                      child:
                                                                          TextField(
                                                                        style: TextStyle(
                                                                            color:
                                                                                colors[index]),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        autofocus:
                                                                            true,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          hintText:
                                                                              "Input Event Name",
                                                                          hintStyle: TextStyle(
                                                                              color: colors1[index].withOpacity(0.3),
                                                                              fontSize: 40.sp),
                                                                        ),
                                                                        controller:
                                                                            controller_ev,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          60.h,
                                                                    ),
                                                                    Row(
                                                                        children: [
                                                                          Spacer(),
                                                                          Spacer(),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              var _selectedDate = await showCalendarDatePicker2Dialog(
                                                                                context: context,
                                                                                config: CalendarDatePicker2WithActionButtonsConfig(shouldCloseDialogAfterCancelTapped: true),
                                                                                dialogSize: Size(325, 400),
                                                                                initialValue: _dialogCalendarPickerValue,
                                                                                borderRadius: BorderRadius.circular(15),
                                                                              );
                                                                              setState(() {
                                                                                _selectedDateList.add(_selectedDate?.last);
                                                                              });
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.calendar_month,
                                                                              color: colors1[index],
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).push(
                                                                                showPicker(context: context, value: _time, onChange: onTimeChanged, iosStylePicker: true, is24HrFormat: true),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.watch_later_outlined,
                                                                              color: colors1[index],
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          Spacer(),
                                                                        ]),
                                                                    SizedBox(
                                                                      height:
                                                                          60.h,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        var time_ev_sent;
                                                                        var time_select = new DateTime(
                                                                            _selectedDateList.last!.year,
                                                                            _selectedDateList.last!.month,
                                                                            _selectedDateList.last!.day,
                                                                            _time.hour,
                                                                            _time.minute);
                                                                        var time_select_format =
                                                                            DateFormat('yyyy-MM-dd hh:mm:ss').format(time_select);
                                                                        setState(
                                                                            () {
                                                                          time_ev =
                                                                              DateTime.parse(time_select_format);
                                                                        });

                                                                        time_ev_sent =
                                                                            Timestamp.fromDate(time_ev);

                                                                        CollectionReference
                                                                            _addEvent =
                                                                            FirebaseFirestore.instance.collection("${getSubject()}_EV");
                                                                        while (controller_ev.text.length <
                                                                            5) {
                                                                          controller_ev.text +=
                                                                              "_";
                                                                        }
                                                                        _addEvent
                                                                            .add({
                                                                          "NAME_EV":
                                                                              controller_ev.text,
                                                                          "TIME_EV":
                                                                              time_ev_sent,
                                                                          "STATUS_EV":
                                                                              true,
                                                                        });
                                                                        var user_EV = _currentUser?.email.replaceAll(
                                                                            "@gmail.com",
                                                                            "_EV");
                                                                        CollectionReference
                                                                            _adduser_EV =
                                                                            FirebaseFirestore.instance.collection(user_EV!);
                                                                        _adduser_EV
                                                                            .add({
                                                                          "ID_SJ":
                                                                              getSubject(),
                                                                          "STATUS_EV":
                                                                              false,
                                                                          "NAME_EV":
                                                                              controller_ev.text,
                                                                          "TIME_EV":
                                                                              time_ev_sent,
                                                                          "INDEX":
                                                                              random.nextInt(100)
                                                                        });
                                                                        addEventEveryone(
                                                                            controller_ev.text);

                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder:
                                                                                ((context) {
                                                                              return Grouppage_New();
                                                                            }),
                                                                          ),
                                                                        );
                                                                        controller_ev
                                                                            .clear();
                                                                      },
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            colors1[index],
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        "CREATE",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                40.sp),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 50.h, left: 0),
                                          child: Container(
                                            height: 425.h,
                                            width: 1000.w,
                                            child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection(subject_ev)
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot_3) {
                                                if (!snapshot_3.hasData) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else {
                                                  return ListView(
                                                    padding:
                                                        EdgeInsets.all(0.w),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: snapshot_3
                                                        .data!.docs
                                                        .map((document) {
                                                      index += 1;
                                                      if (index > 6) {
                                                        index = 0;
                                                      }
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10.w),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              width: 300.0.w,
                                                              height: 300.0.h,
                                                              child:
                                                                  ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                              Color>(
                                                                          colors[
                                                                              index]),
                                                                  shape:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    document["NAME_EV"]
                                                                            [
                                                                            0] +
                                                                        document["NAME_EV"]
                                                                            [1],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontSize:
                                                                          70.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    index_to_eventpage =
                                                                        index;
                                                                    event = document[
                                                                        "NAME_EV"];
                                                                    Timestamp
                                                                        t =
                                                                        document["TIME_EV"]
                                                                            as Timestamp;
                                                                    DateTime d =
                                                                        t.toDate();
                                                                    time_date = DateFormat
                                                                            .yMMMd()
                                                                        .format(
                                                                            d);
                                                                    time_hm = DateFormat
                                                                            .Hm()
                                                                        .format(
                                                                            d);
                                                                    status =
                                                                        document[
                                                                            "STATUS_EV"];
                                                                  });
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          ((context) {
                                                                        return Eventpage_New();
                                                                      }),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.h),
                                                              child: Text(
                                                                document[
                                                                    "NAME_EV"],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      30.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                ),
                                                                maxLines: 3,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            final docs_1 = snapshot_1.data?.docs;
                            final length = docs_1!.length;
                            final data_1 = Map.from(docs_1![length - 1].data()
                                as Map<String, dynamic>);
                            var leader_check = data_1["LEADER"];
                            var index = (data_1["INDEX"] * 10);
                            while (index > 8) {
                              index -= 7;
                            }
                            return Column(
                              children: [
                                Container(
                                  height: 900.h,
                                  decoration: BoxDecoration(
                                    color: colors[index],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
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
                                                    return Homepage_New();
                                                  }),
                                                ),
                                              );
                                            },
                                            color: Colors.white,
                                          ),
                                        ),
                                        Spacer(),
                                        Spacer(),
                                        Spacer(),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 20.h,
                                          ),
                                          child: Text(
                                            'Group and Events',
                                            style: TextStyle(
                                              fontSize: 50.sp,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Spacer(),
                                        Spacer(),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: SizedBox(
                                            child: PopupMenuButton(
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return [
                                                    PopupMenuItem<int>(
                                                        value: 1,
                                                        child: Text(
                                                            "Leave Group")),
                                                  ];
                                                },
                                                child: Icon(
                                                  Icons.logout,
                                                  color: Colors.white,
                                                  size: 50.sp,
                                                ),
                                                onSelected: (value) {
                                                  if (value == 1) {
                                                    memberleaveGroup(
                                                        _currentUser?.email
                                                            .replaceAll(
                                                                "@gmail.com",
                                                                ""),
                                                        subject);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: ((context) {
                                                          return Homepage_New();
                                                        }),
                                                      ),
                                                    );
                                                  } else {}
                                                }),
                                          ),
                                        ),
                                        Spacer(),
                                      ]),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(top: 80.h),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 30.h,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 16.h),
                                                child: Text(
                                                  subject,
                                                  style: TextStyle(
                                                    fontSize: 150.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              data_1["AMOUNT_MB"].toString() +
                                                  ' members',
                                              style: TextStyle(
                                                fontSize: 50.sp,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 50.0.h),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 50.0.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Members',
                                              style: TextStyle(
                                                fontSize: 55.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0.h),
                                        child: SizedBox(
                                          height: 500.h,
                                          child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection(subject_mb)
                                                  .orderBy("RANK_MB")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot_2) {
                                                if (!snapshot_2.hasData) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else {
                                                  //Leader
                                                  return ListView(
                                                    padding:
                                                        EdgeInsets.all(10.w),
                                                    children: snapshot_2
                                                        .data!.docs
                                                        .map((document) {
                                                      //set rank value
                                                      if (_currentUser?.email
                                                              .replaceAll(
                                                                  "@gmail.com",
                                                                  "") ==
                                                          document[
                                                              "EMAIL_MB"]) {
                                                        rank =
                                                            document["RANK_MB"];
                                                      }
                                                      //check rank is leader??
                                                      if (document[
                                                              "EMAIL_MB"] ==
                                                          leader_check
                                                              .replaceAll(
                                                                  "@gmail.com",
                                                                  "")) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 15
                                                                            .h,
                                                                        left: 60
                                                                            .w),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          120.w,
                                                                      height:
                                                                          120.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          document["EMAIL_MB"][0] +
                                                                              document["EMAIL_MB"][1],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                50.sp,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                40.0.w,
                                                                            right: 20.w,
                                                                            top: 10.h),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              360.w,
                                                                          child:
                                                                              Text(
                                                                            document["EMAIL_MB"][0] +
                                                                                document["EMAIL_MB"][1] +
                                                                                document["EMAIL_MB"][2] +
                                                                                document["EMAIL_MB"][3] +
                                                                                document["EMAIL_MB"][4] +
                                                                                document["EMAIL_MB"][5] +
                                                                                " (Leader)",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 50.h,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                10.0.w,
                                                                            top: 2.h),
                                                                        child:
                                                                            Text(
                                                                          'Number of participants : ' +
                                                                              document["TIME_MB"].toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                30.sp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                      //If not leader
                                                      else {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 0.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 15
                                                                            .h,
                                                                        left: 60
                                                                            .w),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          120.w,
                                                                      height:
                                                                          120.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          document["EMAIL_MB"][0] +
                                                                              document["EMAIL_MB"][1],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                50.sp,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                40.0.w,
                                                                            right: 20.w,
                                                                            top: 10.h),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              335.w,
                                                                          child:
                                                                              Text(
                                                                            document["EMAIL_MB"][0] +
                                                                                document["EMAIL_MB"][1] +
                                                                                document["EMAIL_MB"][2] +
                                                                                document["EMAIL_MB"][3] +
                                                                                document["EMAIL_MB"][4] +
                                                                                document["EMAIL_MB"][5],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 50.h,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                35.0.w,
                                                                            top: 2.h),
                                                                        child:
                                                                            Text(
                                                                          'Number of participants : ' +
                                                                              document["TIME_MB"].toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                30.sp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                    }).toList(),
                                                  );
                                                }
                                              }),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 50.0.w,
                                                right: 0.0,
                                                top: 5.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Event',
                                                  style: TextStyle(
                                                    fontSize: 55.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 50.h, left: 0),
                                        child: Container(
                                          height: 425.h,
                                          width: 1000.w,
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection(subject_ev)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot_3) {
                                              if (!snapshot_3.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                return ListView(
                                                  padding: EdgeInsets.all(0.w),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: snapshot_3
                                                      .data!.docs
                                                      .map((document) {
                                                    index += 1;
                                                    if (index > 6) {
                                                      index = 0;
                                                    }
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10.w),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            width: 300.0.w,
                                                            height: 300.0.h,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        colors[
                                                                            index]),
                                                                shape:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  document["NAME_EV"]
                                                                          [0] +
                                                                      document[
                                                                          "NAME_EV"][1],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    fontSize:
                                                                        70.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  index_to_eventpage =
                                                                      index;
                                                                  event = document[
                                                                      "NAME_EV"];
                                                                  Timestamp t =
                                                                      document[
                                                                              "TIME_EV"]
                                                                          as Timestamp;
                                                                  DateTime d = t
                                                                      .toDate();
                                                                  time_date =
                                                                      DateFormat
                                                                              .yMMMd()
                                                                          .format(
                                                                              d);
                                                                  time_hm = DateFormat
                                                                          .Hm()
                                                                      .format(
                                                                          d);
                                                                  status = document[
                                                                      "STATUS_EV"];
                                                                });
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        ((context) {
                                                                      return Eventpage_New();
                                                                    }),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10.h),
                                                            child: Text(
                                                              document[
                                                                  "NAME_EV"],
                                                              style: TextStyle(
                                                                fontSize: 30.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                              ),
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}

Future<void> signout(context) async {
  _googleSignIn.disconnect();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) {
        return Signinpage_New();
      }),
    ),
  );
}

Future<void> addEventEveryone(eventName) async {
  var _collection_1 = FirebaseFirestore.instance.collection(subject_mb);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(subject_mb)
        .doc(documentID)
        .update({eventName: false});
  }
}

Future<void> removeMember(email, subject) async {
  var _collection_1 = FirebaseFirestore.instance.collection(subject_mb);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(subject_mb)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        if (value["EMAIL_MB"] == email) {
          var _collection_2 = FirebaseFirestore.instance.collection(subject_mb);
          _collection_2
              .doc(documentID) // <-- Doc ID where data should be updated.
              .delete();

          var email_delete_sj = email + "_SJ";
          var _collection_3 =
              FirebaseFirestore.instance.collection(email_delete_sj);
          var querySnapshots_2 = await _collection_3.get();
          for (var snapshot_2 in querySnapshots_2.docs) {
            var documentID_2 = snapshot_2.id;
            FirebaseFirestore.instance
                .collection(email_delete_sj)
                .doc(documentID_2)
                .get()
                .then((DocumentSnapshot documentSnapshot_2) {
              if (documentSnapshot_2.exists) {
                var value2 =
                    Map.from(documentSnapshot_2.data() as Map<String, dynamic>);
                if (value2["ID_SJ"] == subject) {
                  var _collection_4 =
                      FirebaseFirestore.instance.collection(email_delete_sj);
                  _collection_4
                      .doc(
                          documentID_2) // <-- Doc ID where data should be updated.
                      .delete();
                }
              } else {}
            });
          }
        } else {
          var email_remove_count_member = value["EMAIL_MB"] + "_SJ";
          var _collection_3 =
              FirebaseFirestore.instance.collection(email_remove_count_member);
          var querySnapshots_2 = await _collection_3.get();
          for (var snapshot_2 in querySnapshots_2.docs) {
            var documentID_2 = snapshot_2.id;
            FirebaseFirestore.instance
                .collection(email_remove_count_member)
                .doc(documentID_2)
                .get()
                .then((DocumentSnapshot documentSnapshot_2) {
              if (documentSnapshot_2.exists) {
                var value2 =
                    Map.from(documentSnapshot_2.data() as Map<String, dynamic>);
                if (value2["ID_SJ"] == subject) {
                  var count_member = value2["MEMBER"] - 1;
                  var _collection_4 = FirebaseFirestore.instance
                      .collection(email_remove_count_member);
                  _collection_4
                      .doc(
                          documentID_2) // <-- Doc ID where data should be updated.
                      .update({"MEMBER": count_member});
                }
              } else {}
            });
          }
        }
      } else {}
    });
  }
}

Future<void> memberleaveGroup(email, subject) async {
  var sj_to_remove = subject + "_MB";
  var _collection_1 = FirebaseFirestore.instance.collection(sj_to_remove);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(sj_to_remove)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        if (value["EMAIL_MB"] == email) {
          var _collection_2 =
              FirebaseFirestore.instance.collection(sj_to_remove);
          _collection_2
              .doc(documentID) // <-- Doc ID where data should be updated.
              .delete();

          var email_delete_sj = email + "_SJ";
          var _collection_3 =
              FirebaseFirestore.instance.collection(email_delete_sj);
          var querySnapshots_2 = await _collection_3.get();
          for (var snapshot_2 in querySnapshots_2.docs) {
            var documentID_2 = snapshot_2.id;
            FirebaseFirestore.instance
                .collection(email_delete_sj)
                .doc(documentID_2)
                .get()
                .then((DocumentSnapshot documentSnapshot_2) {
              if (documentSnapshot_2.exists) {
                var value2 =
                    Map.from(documentSnapshot_2.data() as Map<String, dynamic>);
                if (value2["ID_SJ"] == subject) {
                  var _collection_4 =
                      FirebaseFirestore.instance.collection(email_delete_sj);
                  _collection_4
                      .doc(
                          documentID_2) // <-- Doc ID where data should be updated.
                      .delete();
                }
              } else {}
            });
          }
        }
      } else {}
    });
  }

  var _collection_10 = FirebaseFirestore.instance.collection(subject);
  var querySnapshots_10 = await _collection_10.get();
  for (var snapshot_10 in querySnapshots_10.docs) {
    var documentID = snapshot_10.id;
    FirebaseFirestore.instance
        .collection(subject)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot_10) async {
      if (documentSnapshot_10.exists) {
        var value =
            Map.from(documentSnapshot_10.data() as Map<String, dynamic>);
        if (value["NAME_SJ"] == subject) {
          var _collection_200 = FirebaseFirestore.instance.collection(subject);
          var member_count = value["AMOUNT_MB"] - 1;
          _collection_200
              .doc(documentID) // <-- Doc ID where data should be updated.
              .update({"AMOUNT_MB": member_count});
        }
      } else {}
    });
  }
}

Future<void> delete(context, subject) async {
  var delete_sj_mb = subject + "_MB";
  var delete_sj_ev = subject + "_EV";
  var delete_sj = subject;
  var _collection_1 = FirebaseFirestore.instance.collection(delete_sj_mb);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(delete_sj_mb)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        var _collection_2 =
            FirebaseFirestore.instance.collection(value["EMAIL_MB"] + "_SJ");
        var querySnapshots_2 = await _collection_2.get();
        for (var snapshot_2 in querySnapshots_2.docs) {
          var documentID_2 = snapshot_2.id;
          FirebaseFirestore.instance
              .collection(value["EMAIL_MB"] + "_SJ")
              .doc(documentID_2)
              .get()
              .then((DocumentSnapshot documentSnapshot_2) async {
            if (documentSnapshot_2.exists) {
              var value_2 =
                  Map.from(documentSnapshot_2.data() as Map<String, dynamic>);
              if (value_2["ID_SJ"] == subject) {
                _collection_2.doc(documentID_2).delete();
              }
            } else {}
          });
        }
      } else {}
    });
  }
  // var _collection_3 = FirebaseFirestore.instance.collection(delete_sj_mb);
  // _collection_3.doc().delete();
  // var snapshots_3 = await _collection_3.get();
  // for (var doc in snapshots_3.docs) {
  //   await doc.reference.delete();
  // }

  var _collection_3 = FirebaseFirestore.instance.collection(delete_sj_mb);
  var snapshots_3 = await _collection_3.get();
  for (var doc in snapshots_3.docs) {
    await doc.reference.delete();
  }

  var _collection_4 = FirebaseFirestore.instance.collection(delete_sj_ev);
  var snapshots_4 = await _collection_4.get();
  for (var doc in snapshots_4.docs) {
    await doc.reference.delete();
  }
  var _collection_5 = FirebaseFirestore.instance.collection(delete_sj);
  var snapshots_5 = await _collection_5.get();
  for (var doc in snapshots_5.docs) {
    await doc.reference.delete();
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) {
        return Homepage_New();
      }),
    ),
  );
}

String getEvent() {
  return event;
}

String getRank() {
  return rank;
}

bool getStatus() {
  return status;
}

int getIndex() {
  return index_to_eventpage;
}

String getTimedate() {
  return time_date;
}

String getTimehm() {
  return time_hm;
}
