import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'userinfo_model.dart';

class Dust extends ChangeNotifier {
  String data = '-'; //Dustクラスのdataの初期値設定
  UserInformation userInfo = UserInformation(); //UserInformationのインスタンス化

  Future getNowDust() async {
    await userInfo.getUserInfo(); //UserInformationクラスのgetUserInfoメソッドを呼び出す
    var uid = userInfo.uid; //userInfo.uidでuidにアクセス

    if (uid != null && uid != 'None') {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final ref = FirebaseDatabase.instance.ref();

      final dust_snapshot = await ref.child('users/' + uid + '/dust/now').get();

      var dust_cast = dust_snapshot.child('tag1').value as double;
      this.data = dust_cast.toStringAsFixed(3); //dataに値を格納
    } else {
      this.data = '-';
    }
    super.notifyListeners();
  }
}
