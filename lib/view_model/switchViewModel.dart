import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final auth =
    FirebaseAuth.instance; //modelのプロパティだと１度しかupdateできないためview modelでもインスタンスを用意
final uid = auth.currentUser?.uid.toString();
DatabaseReference switchref = FirebaseDatabase.instance
    .ref('users/' + uid! + '/switch'); //firebaseのリファレンス

class SwitchViewModel extends ChangeNotifier {
  SwitchViewModel(this.ref) : super();
  final WidgetRef ref;

  bool SwitchDataChange(bool switch_val, String type) {
    return !switch_val;
  }

  void write(WidgetRef ref, String item, provider) async {
    try {
      await switchref.update({
        "$item": provider,
      });
    } catch (e) {
      print('Error : $e');
    }
  }
}
