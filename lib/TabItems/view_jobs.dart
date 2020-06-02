import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

import 'package:url_launcher/url_launcher.dart';

class ViewJobDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Job Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2C1CEA),
        scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
      ),
      home: ViewJobDetailsList(title: 'Job Categories'),
    );
  }
}

class ViewJobDetailsList extends StatefulWidget {
  ViewJobDetailsList({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ViewJobDetailsState createState() => _ViewJobDetailsState();
}

class _ViewJobDetailsState extends State<ViewJobDetailsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        //centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          Expanded(child: ShowDetails()),
        ]),
      )),
    );
  }
}

class ShowDetails extends StatefulWidget {
  ShowDetails({Key key}) : super(key: key);

  @override
  _ShowDetailsState createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  final dbRef = FirebaseDatabase.instance.reference().child("Add Job Details");

  @override
  Widget build(BuildContext context) {
    //print(jobtitle.icon);
    return FutureBuilder(
        future: dbRef.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Map<dynamic, dynamic>> list = [];
            for (String key in snapshot.data.value.keys) {
              list.add(snapshot.data.value[key]);
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                itemCount: snapshot.data.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedScreen(data: list[index])));
                        },
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
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
        });
  }
}

class DetailedScreen extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  const DetailedScreen({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: 20.0,
                  ),
                  new Center(
                      child: Text(
                    data["Job Title"],
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: '    Job Description :   ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            new TextSpan(
                              text: data["Job Description"],
                              style: new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: '    Job Type :   ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            new TextSpan(
                              text: data["Job Type"],
                              style: new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: '    Age  :   ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            new TextSpan(
                              text: data["age"],
                              style: new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: '   Gender  :   ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            new TextSpan(
                              text: data["type"],
                              style: new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: '   Location :   ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            new TextSpan(
                              text: data["Location"],
                              style: new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: '    Payment  :   ',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            new TextSpan(
                              text: data["Payment"],
                              style: new TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: new Row(
                      children: <Widget>[
                        new Text('  Contact Us :',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                        new FlatButton(
                          child: new Text(
                            data["Contact Information"],
                            maxLines: 2,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: new Row(
                      children: <Widget>[
                        SizedBox(
                          width: 45.0,
                        ),
                        new RaisedButton(
                          child: Text("Save"),
                          color: Colors.pink,
                          textColor: Colors.white,
                          onPressed: () async {
                            FirebaseUser user =
                                await FirebaseAuth.instance.currentUser();
                            final dbRef = FirebaseDatabase.instance
                                .reference()
                                .child("UserJobProfile")
                                .child(user.uid)
                                .child("Favorites");
                            dbRef.push().set(data).then((_) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Successfully Added')));
                            }).catchError((onError) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(onError)));
                            });
                          },
                        ),
                        SizedBox(
                          width: 105.0,
                        ),
                        new RaisedButton(
                          child: new Text("Apply"),
                          color: Colors.indigoAccent[700],
                          textColor: Colors.white,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Container(
                                        width: 400,
                                        height: 400,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(height: 80),
                                            new SizedBox(
                                                width: 120.0,
                                                height: 70.0,
                                                child: new RaisedButton(
                                                  onPressed: () {},
                                                  color: Colors.orange,
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.call,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "Make a Call",
                                                      )
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(height: 20),
                                            new SizedBox(
                                                width: 142.0,
                                                height: 70.0,
                                                child: new RaisedButton(
                                                  onPressed: () {},
                                                  color: Colors.blue,
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.message,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "Send Message",
                                                      )
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(height: 20),
                                            new SizedBox(
                                                width: 120.0,
                                                height: 70.0,
                                                child: new RaisedButton(
                                                  onPressed: () {},
                                                  color: Colors.redAccent,
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.email,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "Send Email",
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        )),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            )));
  }
}
