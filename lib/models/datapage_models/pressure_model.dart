import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Pressure extends ChangeNotifier {
  Object? data = '-';

  Future getNowPressure() async {
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();

    if (uid != null && uid != 'None') {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final ref = FirebaseDatabase.instance.ref();

      final ap_snapshot = await ref.child('users/' + uid + '/ap/now').get();

      var pressure_cast = ap_snapshot.child("now").value as double;
      this.data = pressure_cast.toStringAsFixed(3);
    } else {
      this.data = '-';
    }

    super.notifyListeners();
  }
}
