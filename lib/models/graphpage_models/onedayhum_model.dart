import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class OneDayHum extends ChangeNotifier {
  DataSnapshot? data;
  String? error;

  Future getOneDayHum() async {
    await Firebase.initializeApp();
    final ref = FirebaseDatabase.instance.ref();
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();

    if (uid != null) {
      this.data =
          await ref.child('users/' + uid + '/weather/humidity/onedayhum').get();
    } else {
      this.error = "OneDay Humidity Data GET ERROR!";
    }
  }
}
