import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import 'package:projectsf341/Model/Data_Sign_In.dart';

import 'package:projectsf341/View_New/Homepage_New.dart';
import 'package:projectsf341/View_New/Notification_New.dart';
import 'package:projectsf341/View_New/Signinpage_New.dart';

final Future<FirebaseApp> firebase_tablepage = Firebase.initializeApp();

GoogleSignIn _googleSignIn = getGoogleSignIn();
GoogleSignInAccount? _currentUser;

var email_ev = _currentUser?.email.replaceAll("@gmail.com", "_EV");
var username = _currentUser?.displayName ?? '';
var useremail = _currentUser?.email;

int index = -1;

class Tablepage_New extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Tablepage_New_Statefulwidget(),
      ),
    );
  }
}

class Tablepage_New_Statefulwidget extends StatefulWidget {
  State<Tablepage_New_Statefulwidget> createState() =>
      _Tablepage_New_Statefulwidget();
}

class _Tablepage_New_Statefulwidget
    extends State<Tablepage_New_Statefulwidget> {
  GoogleSignInAccount? _currentUser = getUserFsn().getCurrentUser;

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
    var email_ev = _currentUser?.email.replaceAll("@gmail.com", "_EV");
    var username = _currentUser?.displayName ?? '';
    var useremail = _currentUser?.email;
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
                    Text(useremail!, style: TextStyle(color: Colors.indigo)),
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
          "Schedule",
          style: TextStyle(color: Colors.black, fontSize: 60.sp),
        ),
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 2100.h,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(email_ev!)
                    .orderBy("ID_SJ")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("There has been no activity."),
                      );
                    } else {
                      return ListView(
                        padding: EdgeInsets.all(10),
                        children: snapshot.data!.docs.map((document) {
                          print(document["INDEX"]);
                          int index = document["INDEX"];
                          while (index > 8) {
                            index -= 9;
                          }
                          Timestamp t = document["TIME_EV"] as Timestamp;
                          DateTime d = t.toDate();
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 40.w, right: 40.w, top: 40.h),
                            child: Container(
                              height: 375.h,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                document["NAME_EV"],
                                                style: TextStyle(
                                                  fontSize: 60.sp,
                                                  color: colors[index],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 15.0.h),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Text(
                                              'Work date : ' +
                                                  DateFormat.yMMMd().format(d),
                                              style: TextStyle(
                                                fontSize: 40.sp,
                                                color: Color.fromARGB(
                                                    255, 162, 162, 162),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.0.h),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Work start : ' +
                                                      DateFormat.Hm().format(d),
                                                  style: TextStyle(
                                                    fontSize: 40.sp,
                                                    color: Color.fromARGB(
                                                        255, 162, 162, 162),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 15.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60.h,
                                              width: 60.h,
                                              decoration: BoxDecoration(
                                                color: colors1[index],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  document["ID_SJ"][0] +
                                                      document["ID_SJ"][1],
                                                  style: TextStyle(
                                                    fontSize: 30.sp,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                document["ID_SJ"],
                                                style: TextStyle(
                                                  fontSize: 45.sp,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Container(
                                        color:
                                            Color.fromARGB(255, 206, 206, 206),
                                        height: 1,
                                        width: 400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  }
                },
              ),
            ),
          ],
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
