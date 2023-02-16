import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../view/others/basetabview.dart';
import '../../settings/setting_page.dart';
import '../../settings/theme_change.dart';

class SharedPreferencesGetter extends ChangeNotifier {
  SharedPreferencesGetter(this.ref) : super();
  final WidgetRef ref;

  getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch_value = prefs.getBool('dark_mode') ?? false;

    ref.read(darkmodeProvider.notifier).state = switch_value
        ? ThemeData.dark()
            .copyWith(primaryColor: Colors.white, disabledColor: Colors.black87)
        : ThemeData.light().copyWith(
            primaryColor: Colors.black87, disabledColor: Colors.white);

    ref.read(localeProvider.notifier).state =
        prefs.getString('language') ?? 'en';

    ref.read(themechangeProvider.notifier).state = prefs.getInt('theme') ?? 0;
    ref.read(theme1boolProvider.notifier).state =
        prefs.getBool('theme1') ?? false;
    ref.read(theme2boolProvider.notifier).state =
        prefs.getBool('theme2') ?? false;
    ref.read(theme3boolProvider.notifier).state =
        prefs.getBool('theme3') ?? false;
  }
}
