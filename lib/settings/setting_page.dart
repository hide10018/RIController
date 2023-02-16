import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:transport_predict_app/main.dart';
import 'package:transport_predict_app/settings/theme_change.dart';
import 'package:transport_predict_app/settings/language_change.dart';
import 'package:transport_predict_app/settings/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view_model/ble.dart';

//mvvmに分離する方法が思いつかなかったため保留
bool switch_value = false; //トグルスイッチのオンオフ描画用
StateProvider<bool> layoutboolProvider = StateProvider((ref) => false);

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).settings,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).disabledColor,
        ),
        body: SettingsList(
          sections: [
            SettingsSection(title: Text('Common'), tiles: <SettingsTile>[
              SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text(AppLocalizations.of(context).language),
                  onPressed: (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => language_changePage()));
                  }),
              SettingsTile.navigation(
                  leading: Icon(Icons.format_paint),
                  title: Text(AppLocalizations.of(context).theme1),
                  onPressed: (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThemeChangePage()));
                  }),
              SettingsTile.switchTile(
                onToggle: (bool value) {
                  _setPrefItems() async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('dark_mode', switch_value);
                  }

                  ref.read(darkmodeProvider.notifier).state = value
                      ? ThemeData.dark().copyWith(
                          primaryColor: Colors.white,
                          disabledColor: Colors.black87)
                      : ThemeData.light().copyWith(
                          primaryColor: Colors.black87,
                          disabledColor: Colors.white);
                  switch_value = !switch_value;
                  _setPrefItems();
                },
                initialValue: switch_value,
                leading: Icon(Icons.dark_mode),
                title: Text(AppLocalizations.of(context).dark_mode),
              ),
              SettingsTile.navigation(
                  leading: Icon(Icons.login),
                  title: Text("login"),
                  onPressed: (context) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthPage()));
                  }),
              SettingsTile.navigation(
                  leading: Icon(Icons.bluetooth),
                  title: Text("Bluetooth Scan"),
                  onPressed: (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindDevicesScreen()));
                  }),
            ])




          ],
        ));
  }
}
