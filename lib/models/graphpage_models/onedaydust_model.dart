import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class OneDayDust extends ChangeNotifier {
  DataSnapshot? data;
  String? error;

  Future getOneDayDust() async {
    await Firebase.initializeApp();
    final ref = FirebaseDatabase.instance.ref();
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();

    if (uid != null) {
      this.data = await ref.child('users/' + uid + '/dust/onedaydust').get();
    } else {
      this.error = "OneDay Dust Data GET ERROR!";
    }
  }
}
