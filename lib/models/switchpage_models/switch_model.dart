import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final switchProvider = StateProvider<bool>((ref) => true); //全てのオンオフ
final fanswitchProvider = StateProvider<bool>((ref) => false); //扇風機のオンオフ
final humfiswitchProvider = StateProvider<bool>((ref) => false); //加湿器のオンオフ
final airclswitchProvider = StateProvider<bool>((ref) => false); //空気清浄機のオンオフ
final lightswitchProvider = StateProvider<bool>((ref) => false); //仮
final esp32switchProvider = StateProvider<bool>((ref) => false); //センサー類

class SwitchModel extends ChangeNotifier {
  SwitchModel(this.ref) : super();
  final WidgetRef ref;

  DatabaseReference? switchRef;
  String? error;
  DataSnapshot? all_state;
  DataSnapshot? fan_state;
  DataSnapshot? humfi_state;
  DataSnapshot? aircl_state;
  DataSnapshot? light_state;
  DataSnapshot? esp32_state;

  Future getSwitchData() async {
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid.toString();
    if (uid != null) {
      this.switchRef =
          FirebaseDatabase.instance.ref('users/' + uid + '/switch');

      this.all_state = await this.switchRef?.child('all').get();
      this.fan_state = await this.switchRef?.child('fan').get();
      this.humfi_state = await this.switchRef?.child('humfi').get();
      this.aircl_state = await this.switchRef?.child('aircl').get();
      this.light_state = await this.switchRef?.child('light').get();
      this.esp32_state = await this.switchRef?.child('esp32').get();
      this
              .all_state
              ?.value
              .toString()
              .toLowerCase() == //datasnapshot->string->小文字->bool
          'true';

      ref.read(fanswitchProvider.notifier).state =
          this.fan_state?.value.toString().toLowerCase() == 'true';

      ref.read(humfiswitchProvider.notifier).state =
          this.humfi_state?.value.toString().toLowerCase() == 'true';

      ref.read(airclswitchProvider.notifier).state =
          this.aircl_state?.value.toString().toLowerCase() == 'true';

      ref.read(lightswitchProvider.notifier).state =
          this.light_state?.value.toString().toLowerCase() == 'true';

      ref.read(esp32switchProvider.notifier).state =
          this.esp32_state?.value.toString().toLowerCase() == 'true';
      notifyListeners();
      return this;
    } else {
      this.error = "Switch Data GET ERROR!";
    }
  }
}
