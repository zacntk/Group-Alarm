import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:projectsf341/View_New/Homepage_New.dart';
import 'package:projectsf341/View_New/Signinpage_New.dart';
import 'package:projectsf341/View_New/Tablepage_New.dart';

final Future<FirebaseApp> firebase_notificationpage = Firebase.initializeApp();

GoogleSignIn _googleSignIn = getGoogleSignIn();
GoogleSignInAccount? _currentUser;

var username;
var useremail;

var email;
var email_iv;
var email_sj;

Random random = new Random();

class Notificationpage_New extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Notificationpage_New_Statefulwidget(),
      ),
    );
  }
}

class Notificationpage_New_Statefulwidget extends StatefulWidget {
  State<Notificationpage_New_Statefulwidget> createState() =>
      _Notificationpage_New_Statefulwidget();
}

class _Notificationpage_New_Statefulwidget
    extends State<Notificationpage_New_Statefulwidget> {
  String namegroup = "";
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

  Widget build(BuildContext context) {
    username = _currentUser?.displayName ?? '';
    useremail = _currentUser?.email;

    email = _currentUser?.email.replaceAll("@gmail.com", "");
    email_iv = _currentUser?.email.replaceAll("@gmail.com", "_IV");
    email_sj = _currentUser?.email.replaceAll("@gmail.com", "_SJ");
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("zack.natakit_IV")
          .orderBy("ID_SJ")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
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
                      title: Text(username,
                          style: TextStyle(color: Colors.indigo)),
                      subtitle: Text(useremail!,
                          style: TextStyle(color: Colors.indigo)),
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
                "Notify",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    clear();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "CLEAR",
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(Icons.layers_clear_rounded)
                    ],
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(email_iv!)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("You haven't received an invitation."),
                      );
                    } else {
                      return ListView(
                        padding: EdgeInsets.all(10),
                        children: snapshot.data!.docs.map((document) {
                          var index = (document["INDEX"] * 10);
                          while (index > 8) {
                            index -= 7;
                          }
                          Timestamp t = document["Time_IV"] as Timestamp;
                          DateTime d = t.toDate();
                          final differrent = d.difference(DateTime.now());
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0.h),
                            child: Container(
                              height: 450.h,
                              // ignore: sort_child_properties_last
                              child: Padding(
                                padding: EdgeInsets.all(50.0.w),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 100.sp,
                                      child: Text(
                                        document["Inviter"][0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 60.sp),
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    Spacer(),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.all(5.w),
                                          child: Text(
                                            document["Inviter"],
                                            style: TextStyle(
                                              fontSize: 40.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.all(5.w),
                                          child: Text(
                                            ' invite you to join group ' +
                                                document["ID_SJ"],
                                            style: TextStyle(
                                              fontSize: 40.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 25.h,
                                                  right: 50.w,
                                                  left: 30.w),
                                              child: Text(
                                                ((differrent.inHours) * -1)
                                                        .toString() +
                                                    " hour ago",
                                                style: TextStyle(
                                                    fontSize: 40.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 22.w, top: 39.h),
                                              child: SizedBox(
                                                width: 200.0.w,
                                                height: 80.0.h,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    27,
                                                                    174,
                                                                    11)),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                          ),
                                                          child: Text(
                                                            'Accept',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    accept(
                                                      document["ID_SJ"],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 39.h),
                                              child: SizedBox(
                                                width: 200.0.w,
                                                height: 80.0.h,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    223,
                                                                    14,
                                                                    14)),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                          ),
                                                          child: Text(
                                                            'Decline',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    decline(document["ID_SJ"]);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 60, 60, 60)
                                        .withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
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
          );
        }
      },
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

Future<void> accept(name_group) async {
  var _collection_1 = FirebaseFirestore.instance.collection(email_iv!);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(email_iv!)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        if (value["ID_SJ"] == name_group) {
          int randomNumber = random.nextInt(100);
          var _collection_3 = FirebaseFirestore.instance.collection(email_sj!);
          _collection_3.add({"ID_SJ": name_group});
          var name_group_mb = name_group + "_MB";
          var _collection_4 =
              FirebaseFirestore.instance.collection(name_group_mb);
          _collection_4
              .add({"EMAIL_MB": email, "RANK_MB": "MEMBER", "TIME_MB": 0});
          var _collection_5 = FirebaseFirestore.instance.collection(email_iv!);
          _collection_5
              .doc(documentID) // <-- Doc ID where data should be updated.
              .delete();
        }
      } else {}
    });
  }

  var _collection_10 = FirebaseFirestore.instance.collection(name_group);
  var querySnapshots_10 = await _collection_10.get();
  for (var snapshot_10 in querySnapshots_10.docs) {
    var documentID_10 = snapshot_10.id;
    var docSnapshot_10 = await _collection_10.doc(documentID_10).get();
    Map<String, dynamic>? data = docSnapshot_10.data();
    final Map<String, dynamic> convertedData = jsonDecode(jsonEncode(data));
    var member_add = convertedData["AMOUNT_MB"] + 1;

    var _collection_add = FirebaseFirestore.instance.collection(name_group);
    _collection_add
        .doc(documentID_10) // <-- Doc ID where data should be updated.
        .update({"AMOUNT_MB": member_add});
  }
}

Future<void> decline(name_group) async {
  var _collection_1 = FirebaseFirestore.instance.collection(email_iv!);
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(email_iv!)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        if (value["ID_SJ"] == name_group) {
          var _collection_3 = FirebaseFirestore.instance.collection(email_iv!);
          _collection_3
              .doc(documentID) // <-- Doc ID where data should be updated.
              .delete();
        }
      } else {}
    });
  }
}

Future<void> clear() async {
  var _collection_1 = FirebaseFirestore.instance.collection(email_iv!);
  _collection_1.doc().delete();
  var querySnapshots = await _collection_1.get();
  for (var snapshot in querySnapshots.docs) {
    var documentID = snapshot.id;
    FirebaseFirestore.instance
        .collection(email_iv!)
        .doc(documentID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var value = Map.from(documentSnapshot.data() as Map<String, dynamic>);
        var _collection_3 = FirebaseFirestore.instance.collection(email_iv!);
        _collection_3
            .doc(documentID) // <-- Doc ID where data should be updated.
            .delete();
      } else {}
    });
  }
}
