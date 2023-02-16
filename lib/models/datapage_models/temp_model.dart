import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Temperature extends ChangeNotifier {
  Object? data = '-'; //ここに温度

  Future getNowTemperature() async {
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();
    if (uid != null) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final ref = FirebaseDatabase.instance.ref();

      final tmp_snapshot =
          await ref.child('users/' + uid + '/weather/temperature/now').get();

      this.data = tmp_snapshot.child('tag1').value;
    } else {
      this.data = '-';
    }
    super.notifyListeners();
  }
}
