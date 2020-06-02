import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:job_seek/TabItems/view_jobs.dart';
import 'package:job_seek/authe.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({this.auth, this.onSignedOut});
  final VoidCallback onSignedOut;
  final BaseAuth auth;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.power_settings_new),
            color: Colors.black,
            tooltip: 'LOGOUT',
            onPressed: _signOut,
          )
        ],
      ),
      body: UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Widget _recommendJobs() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Recommended Jobs',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0f0250)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewJobDetails()));
                    },
                    child: Text(
                      'SEE ALL',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2d1eeb)),
                    ),
                  )
                ],
              )),
          randomjobs(),
        ],
      ),
    );
  }

  Widget randomjobs() {
    final dbRef = FirebaseDatabase.instance
        .reference()
        .child("Add Job Details")
        .limitToFirst(3);

    return FutureBuilder(
      future: dbRef.once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Map<dynamic, dynamic>> list = [];
          if (snapshot.data.value == null) {
            return Text("no Data");
          }
          for (String key in snapshot.data.value.keys) {
            list.add(snapshot.data.value[key]);
          }

          return new Row(children: <Widget>[
            Expanded(
                child: SizedBox(
                    height: 240.0,
                    child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(top: 20.0),
                              height: 240.0,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8, right: 8),
                                    padding: EdgeInsets.only(
                                        top: 20.0, left: 20.0, right: 20.0),
                                    width: 325.0,
                                    height: 240.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        stops: [0.2, 0.6],
                                        colors: (index % 2 == 0)
                                            ? [
                                                Color(0xff7500bf),
                                                Color(0xff5b1ad1),
                                              ]
                                            : [
                                                Color(0xffe90b7e),
                                                Color(0xffff5a5a),
                                              ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(list[index]["Job Title"],
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xfffefeff))),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Opacity(
                                            opacity: 0.6,
                                            child: Text(list[index]["Job Type"],
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffffffff))),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Opacity(
                                            opacity: 0.49,
                                            child: Text(
                                                list[index]["Payment"] +
                                                    " Provided",
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffffffff))),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 60.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 12.0,
                                                      left: 15.0,
                                                      right: 15.0,
                                                      bottom: 12.0),
                                                  decoration: BoxDecoration(
                                                      color: new Color.fromRGBO(
                                                          255, 255, 255, 0.5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0))),
                                                  child: Opacity(
                                                    opacity: 0.7,
                                                    child: Text('APPLY',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xfffefeff))),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                        })))
          ]);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _recentActivities() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Recent Activities',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff0f0250)),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Color(0xffeb1d96),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: Icon(Icons.settings, color: Color(0xffffffff)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              child: Text('24'.toString(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff0f0250))),
                              onPressed: () async {
                                FirebaseUser userId =
                                    await FirebaseAuth.instance.currentUser();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailedScreen(data1: userId)));
                              },
                            ),
                            SizedBox(height: 5.0),
                            Text('Saved Jobs',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffababb5)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String profilepicurl =
      'https://cdn.mos.cms.futurecdn.net/QjuZKXnkLQgsYsL98uhL9X-1024-80.jpg';
  String displayname = "Hey";
  // addMethod jobseek = new addMethod();

  // QuerySnapshot det;
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     jobseek.getData().then((QuerySnapshot results) {
  //       det = results;
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        profilepicurl = user.photoUrl;
        displayname = user.displayName;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30.0),
              color: Color(0xfff5f7f9),
              child: Column(
                children: <Widget>[
                  userdetails(),
                  _recommendJobs(),
                  _recentActivities()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userdetails() {
    return new Builder(
      builder: (context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 65,
                    child: ClipOval(
                      child: SizedBox(
                        width: 160.0,
                        height: 160.0,
                        child: Image.network(profilepicurl, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(displayname,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class DetailedScreen extends StatelessWidget {
  final FirebaseUser data1;

  const DetailedScreen({Key key, this.data1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseUser userId = data1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 26.0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: new Form(
            child: new Column(
              children: <Widget>[
                SizedBox(height: 20),
                favScreenbuild(context, userId)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget favScreenbuild(BuildContext context, FirebaseUser userId) {
    final dbRef = FirebaseDatabase.instance
        .reference()
        .child("UserJobProfile")
        .child(userId.uid)
        .child("Favorites");
    return FutureBuilder(
      future: dbRef.once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Map<dynamic, dynamic>> list = [];
          if (snapshot.data.value == null) {
            return Text("no Data");
          }
          for (String key in snapshot.data.value.keys) {
            list.add(snapshot.data.value[key]);
          }
          return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: snapshot.data.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               DetailedScreen(data: list[index])));
                      //   // Thats all. Run and check now
                      // },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.primaries[index][50],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8.0),
                                              child: Text(
                                                list[index]["Job Title"],
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2.0),
                                            child: Text(
                                                list[index]["Payment"] +
                                                    "  provided",
                                                style: TextStyle(
                                                    color: Colors.black45)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        }
        return CircularProgressIndicator();
      },
    );
  }
}
