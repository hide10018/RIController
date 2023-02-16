import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Humidity extends ChangeNotifier {
  Object? data = '-';

  Future getNowHumidity() async {
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();

    if (uid != null) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final ref = FirebaseDatabase.instance.ref();

      final hum_snapshot =
          await ref.child('users/' + uid! + '/weather/humidity/now').get();

      this.data = hum_snapshot.child('tag1').value;
    } else {
      this.data = '-';
    }

    super.notifyListeners();
  }
}
