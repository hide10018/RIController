import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserInformation extends ChangeNotifier {
  String? uid = '-';
  String? email = '-';

  Future getUserInfo() async {
    final auth = await FirebaseAuth.instance;
    if (auth.currentUser?.uid != null && auth.currentUser?.email != null) {
      //nullがあった場合Noneを入れる
      this.uid = await auth.currentUser?.uid.toString();
      this.email = await auth.currentUser?.email.toString();
    } else {
      this.uid = 'None';
      this.email = 'Please Login!';
    }

    super.notifyListeners();
  }
}
