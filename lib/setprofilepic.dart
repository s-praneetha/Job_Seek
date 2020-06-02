import 'dart:math';
import 'package:job_seek/AuthPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:job_seek/TabItems/profilepage.dart';

class SetProfilepic extends StatelessWidget {
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
  File profilepic;

  Future getImage() async {
    var tempImg = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profilepic = tempImg;
    });
  }

  // uploadImage() async {
  //   var random = Random(25);
  //   final StorageReference fireref = FirebaseStorage.instance
  //       .ref()
  //       .child('profilepics/${random.nextInt(5000).toString()}.jpg');
  //   StorageUploadTask task = fireref.putFile(profilepic);
  //   StorageTaskSnapshot snapshottask = await task.onComplete;
  //   String downloadUrl = await snapshottask.ref.getDownloadURL();
  //   //_imageUrl.add(downloadUrl.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: profilepic == null ? Text('data') : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add image',
        child: new Icon(FontAwesomeIcons.camera),
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
                        child: Image.network('', fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Praneetha Seethepalli',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(profilepic, height: 300, width: 300),
          RaisedButton(
              onPressed: () {
                final StorageReference fireref =
                    FirebaseStorage.instance.ref().child('image.jpg');
                final StorageUploadTask task = fireref.putFile(profilepic);
              },
              child: Text('upload'))
        ],
      ),
    );
  }

  Widget choose() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(profilepic, height: 300, width: 300),
          RaisedButton(onPressed: getImage, child: Text('Choose'))
        ],
      ),
    );
  }
}
