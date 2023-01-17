import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:projectsf341/Model/Data_Sign_In.dart';

import 'package:projectsf341/View_New/Grouppage_New.dart';
import 'package:projectsf341/View_New/Notification_New.dart';
import 'package:projectsf341/View_New/Signinpage_New.dart';
import 'package:projectsf341/View_New/Tablepage_New.dart';

GoogleSignIn _googleSignIn = getGoogleSignIn();
GoogleSignInAccount? _currentUser;

late TextEditingController controller;
var username,
    useremail,
    email_con,
    dt,
    user,
    count_m,
    count_s,
    number_member,
    subject,
    leader,
    index;

Random random = Random();

class Homepage_New extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Homepage_New_Statefulwidget(),
      ),
    );
  }
}

class Homepage_New_Statefulwidget extends StatefulWidget {
  State<Homepage_New_Statefulwidget> createState() =>
      _Homepage_New_Statefulwidget();
}

class _Homepage_New_Statefulwidget extends State<Homepage_New_Statefulwidget> {
  String nameGroup = "";
  GoogleSignInAccount? _currentUser = getUserFsn().getCurrentUser;
  final Future<FirebaseApp> firebase_homepage = Firebase.initializeApp();

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

  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  Future<String?> createGroup() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(child: Text("Create Group")),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: "Group Name"),
            controller: controller,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () async {
                  email_sj =
                      _currentUser?.email.replaceAll("@gmail.com", "_SJ");
                  QuerySnapshot _myDoc = await FirebaseFirestore.instance
                      .collection(email_sj!)
                      .get();
                  List<DocumentSnapshot> _myDocCount = _myDoc.docs;
                  count_s = _myDocCount.length;

                  setState(
                    () {
                      dt = controller.text;
                      CollectionReference _addSubject =
                          FirebaseFirestore.instance.collection(email_con);
                      _addSubject.add({
                        "ID_SJ": dt.toString(),
                      });

                      CollectionReference _createSubject =
                          FirebaseFirestore.instance.collection(dt.toString());
                      _createSubject.add({
                        "NAME_SJ": dt.toString(),
                        "AMOUNT_MB": 1,
                        "EVENT_DB": dt.toString() + "_EV",
                        "INDEX": random.nextInt(99) + 1,
                        "LEADER": _currentUser?.email,
                        "MEMBER_DB": dt.toString() + "_MB",
                      });
                      // var time = Timestamp.fromDate(DateTime.now());
                      // var subject_EV = dt + "_EV";
                      // CollectionReference _createSJEV =
                      //     FirebaseFirestore.instance.collection(subject_EV);
                      // _createSJEV
                      //     .add({"NAME_EV": "GROUP START", "TIME_EV": time});
                      var subject_MB = dt + "_MB";
                      CollectionReference _createSJMB =
                          FirebaseFirestore.instance.collection(subject_MB);
                      _createSJMB.add(
                        {
                          "EMAIL_MB":
                              _currentUser?.email.replaceAll("@gmail.com", ""),
                          "RANK_MB": "LEADER",
                          "TIME_MB": 0
                        },
                      );
                      // var user_EV =
                      //     _currentUser?.email.replaceAll("@gmail.com", "_EV");
                      // CollectionReference _adduser_EV =
                      //     FirebaseFirestore.instance.collection(user_EV!);
                      // _adduser_EV.add({
                      //   "ID_SJ": dt.toString(),
                      //   "NAME_EV": "GROUP START",
                      //   "TIME_EV": time
                      // });
                      Navigator.pop(context);
                    },
                  );
                },
                child: Text("CONFIRM",
                    style: TextStyle(fontSize: 15, color: Colors.blue)),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("NO THANK",
                    style: TextStyle(fontSize: 10, color: Colors.black)),
              ),
            )
          ],
        ),
      );

  Widget build(BuildContext context) {
    user = _currentUser;
    if (user != null) {
      username = user?.displayName ?? '';
      useremail = user?.email;
      email_con = useremail.replaceAll("@gmail.com", "_SJ");
      return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          elevation: 1.5,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: ListTile(
                  leading: GoogleUserCircleAvatar(identity: user),
                  title: Text(username, style: TextStyle(color: Colors.indigo)),
                  subtitle:
                      Text(useremail, style: TextStyle(color: Colors.indigo)),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: Text("Home"),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return Homepage_New();
                            }),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text("Schedule"),
                      leading: Icon(Icons.table_chart),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return Tablepage_New();
                            }),
                          ),
                        );
                      },
                    ),
                    ListTile(
                        title: Text("Notify"),
                        leading: Icon(Icons.notifications_active),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return Notificationpage_New();
                              }),
                            ),
                          );
                        })
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 1.h,
              ),
              ListTile(
                title: Text("Sign out"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  signout(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            "Homepage",
            style: TextStyle(color: Colors.black, fontSize: 60.sp),
          ),
          actions: [],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  Stack(children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 60.h, right: 10.w, left: 45.w),
                      child: Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 50.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 45.0.w, top: 160.h),
                      child: Text(
                        'Group Alarm',
                        style: TextStyle(
                          fontSize: 70.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(left: 150.0),
                    child: Image(
                      image: AssetImage('assets/images/homepage_icon.png'),
                      width: 500.w,
                      height: 500.h,
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(left: 700.w, top: 0),
                  child: SizedBox(
                    width: 215.0.w,
                    height: 105.0.h,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 0, 0, 0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      'New',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 45.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0.w, top: 0),
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 45.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        final nameGroup = await createGroup();
                        if (nameGroup == null || nameGroup.isEmpty) {
                          return;
                        }
                        setState(() {
                          this.nameGroup = nameGroup;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 1350.h,
                  child: FutureBuilder(
                    future: firebase_homepage,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(email_con)
                              .orderBy("ID_SJ")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> snapshot_1) {
                            if (!snapshot_1.hasData) {
                              return Center();
                            } else {
                              if (snapshot_1.data!.docs.isEmpty) {
                                return Center(
                                  child: Text("You don't yet have a group."),
                                );
                              } else {
                                final docs_1 = snapshot_1.data!.docs;
                                return SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                    itemCount: docs_1.length,
                                    itemBuilder: (_, i) {
                                      final data = Map.from(docs_1[i].data()
                                          as Map<String, dynamic>);

                                      subject = data["ID_SJ"];

                                      return StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection(subject)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot_2) {
                                          if (snapshot_2.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center();
                                          } else {
                                            final docs_2 =
                                                snapshot_2.data?.docs;
                                            var length_2 = docs_2!.length;
                                            if (length_2 != 0) {
                                              final data_2 = Map.from(
                                                  docs_2![length_2 - 1].data()
                                                      as Map<String, dynamic>);
                                              index = (data_2["INDEX"] * 10);
                                              while (index > 8) {
                                                index -= 7;
                                              }
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 40.w,
                                                    right: 40.w,
                                                    top: 30.h),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromARGB(
                                                                255,
                                                                155,
                                                                155,
                                                                155)
                                                            .withOpacity(0.5),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: SizedBox(
                                                    height: 460.0.h,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    colors[
                                                                        index]),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    Container(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      data_2["NAME_SJ"]
                                                                              [
                                                                              0] +
                                                                          data_2["NAME_SJ"]
                                                                              [
                                                                              1],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            254,
                                                                            254),
                                                                        fontSize:
                                                                            80.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  width: 330.w,
                                                                  height: 330.h,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: colors1[
                                                                        index],
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          60),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          150.h,
                                                                      left: 180
                                                                          .w),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    data_2[
                                                                        "NAME_SJ"],
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontSize:
                                                                          80.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 5,
                                                                        left:
                                                                            5),
                                                                    child: Text(
                                                                      data_2["AMOUNT_MB"]
                                                                              .toString() +
                                                                          " Member",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        fontSize:
                                                                            45.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          subject =
                                                              data_2["NAME_SJ"];
                                                          leader =
                                                              data_2["LEADER"];
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  ((context) {
                                                                return Grouppage_New();
                                                              }),
                                                            ),
                                                          );
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center();
                                            }
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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

String getSubject() {
  return subject;
}

String getLeader() {
  return leader;
}

Data_Sign_In getUser() {
  return DSI;
}
