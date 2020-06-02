import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance.collection('/userdetails').add({
      'email': user.email,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl
    }).then((value) {
      Navigator.of(context).pushReplacementNamed('/setprofile');
    }).catchError((e) {
      print(e);
    });
  }

  static Future updateProfilePic(picUrl) async {
    //Firestore.instance.collection('/userdetails').add({'photoUrl': picUrl});

    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;
    final user = await FirebaseAuth.instance.currentUser();

    user.updateProfile(userInfo).then((val) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance
            .collection('/userdetails')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/userdetails/${docs.documents[0].documentID}')
              .updateData({'photoUrl': picUrl}).then((val) {
            print('Updated');
          }).catchError((e) {
            print(e);
          });
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }
}

// class addMethod {
//   addData(userData) async {
//     DocumentReference docRef = await Firestore.instance
//         .collection('userdetails')
//         .add(userData)
//         .catchError((e) {
//       print(e);
//     });
//     print(docRef.documentID);
//   }

//   final user = FirebaseAuth.instance.currentUser();
//   getData() async {
//     return await Firestore.instance
//         .collection('userdetails')
//         .where('uid', isEqualTo: user)
//         .getDocuments();
//   }
// }
