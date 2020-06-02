import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:job_seek/bottomNavigation/bottom_bar.dart';
import 'package:job_seek/services/userinfo.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Profilepic(),
    );
  }
}

class Profilepic extends StatefulWidget {
  _ProfilepicState createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  File newprofilepic;

  Future getImage() async {
    var tempImg = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      newprofilepic = tempImg;
    });
  }

  uploadImage() async {
    var random = Random(25);
    final StorageReference fireref = FirebaseStorage.instance
        .ref()
        .child('profilepics/${random.nextInt(5000).toString()}.jpg');
    StorageUploadTask task = fireref.putFile(newprofilepic);
    StorageTaskSnapshot snapshottask = await task.onComplete;
    String downloadUrl = await snapshottask.ref.getDownloadURL();
    if (downloadUrl != null) {
      UserManagement.updateProfilePic(downloadUrl.toString()).then((val) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => bottom_bar()));
        //Navigator.of(context).pushReplacementNamed('/homepage');
      });
    }
  }

  UserManagement userManagement = new UserManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: newprofilepic == null ? getChooseButton() : getUploadButton());
  }

  Widget getChooseButton() {
    return new Stack(children: <Widget>[
      Positioned(
        width: 375.0,
        top: 110,
        child: Column(
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://cdn.mos.cms.futurecdn.net/QjuZKXnkLQgsYsL98uhL9X-1024-80.jpg',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
            ),
            SizedBox(height: 30),
            Text(
              'Praneetha Seethepalli',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                            onTap: getImage,
                            child: Center(
                              child: Text('Change Pic',
                                  style: TextStyle(color: Colors.white)),
                            )))),
                Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                            )))),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  Widget getUploadButton() {
    return new Stack(children: <Widget>[
      Positioned(
        width: 375.0,
        top: 110,
        child: Column(
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: FileImage(newprofilepic), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                  boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
            ),
            SizedBox(height: 30),
            Text(
              'Praneetha Seethepalli',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                            onTap: uploadImage,
                            child: Center(
                              child: Text('Upload Pic',
                                  style: TextStyle(color: Colors.white)),
                            )))),
                Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                            )))),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
