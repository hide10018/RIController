import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transport_predict_app/view/switch_views/switchView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../settings/setting_page.dart';
import '../datapage_views/dataView.dart';
import '../graphpage_views/graphView.dart';
import '../outlier_views/outlierView.dart';

final List<Icon> theme1list = [
  //テーマ変更用リスト,デフォルト
  Icon(Icons.home),
  Icon(Icons.show_chart),
  Icon(Icons.check),
  Icon(Icons.power_settings_new),
  Icon(Icons.settings)
];
final List<Icon> theme2list = [
  //考え中
  Icon(Icons.home),
  Icon(Icons.show_chart),
  Icon(Icons.check),
  Icon(Icons.power_settings_new),
  Icon(Icons.settings)
];

final List<ImageIcon> theme3list = [
  //神戸
  ImageIcon(
    AssetImage('assets/icon-2.png'),
    size: 40,
  ),

  ImageIcon(
    AssetImage('assets/icon-5.png'),
    size: 40,
  ),

  ImageIcon(
    AssetImage('assets/icon-1.png'),
    size: 40,
  ),

  ImageIcon(
    AssetImage('assets/anchor.png'),
    size: 40,
  ),

  ImageIcon(
    AssetImage('assets/icon-3.png'),
    size: 40,
  ),
];
final List<ImageIcon> theme4list = [
  //宇宙
  ImageIcon(AssetImage('assets/earth.png')),
  ImageIcon(AssetImage('assets/1846.png')),
  ImageIcon(AssetImage('assets/meteor.png')),
  ImageIcon(AssetImage('assets/galaxy.png')),
  ImageIcon(AssetImage('assets/38123.png'))
];

final List<Icon> theme1list_active = [
  Icon(Icons.home),
  Icon(Icons.show_chart),
  Icon(Icons.check),
  Icon(Icons.power_settings_new),
  Icon(Icons.settings)
];
final List<Icon> theme2list_active = [
  Icon(Icons.home),
  Icon(Icons.show_chart),
  Icon(Icons.check),
  Icon(Icons.power_settings_new),
  Icon(Icons.settings)
];
final List<ImageIcon> theme3list_active = [
  MyImageIcon(AssetImage('assets/icon-2.png')),
  MyImageIcon(AssetImage('assets/icon-5.png')),
  MyImageIcon(AssetImage('assets/icon-1.png')),
  MyImageIcon(AssetImage('assets/anchor.png')),
  MyImageIcon(AssetImage('assets/icon-3.png')),
];
final List<ImageIcon> theme4list_active = [
  ImageIcon(
    AssetImage('assets/earth.png'),
    size: 30,
    color: Colors.lightBlueAccent,
  ),
  ImageIcon(
    AssetImage('assets/1846.png'),
    size: 30,
    color: Colors.lightBlueAccent,
  ),
  ImageIcon(
    AssetImage('assets/meteor.png'),
    size: 30,
    color: Colors.lightBlueAccent,
  ),
  ImageIcon(
    AssetImage('assets/galaxy.png'),
    size: 30,
    color: Colors.lightBlueAccent,
  ),
  ImageIcon(
    AssetImage('assets/38123.png'),
    size: 30,
    color: Colors.lightBlueAccent,
  )
];

final List<List<Widget>> themelist = [
  theme1list,
  theme2list,
  theme3list,
  theme4list
];
final List<List<Widget>> themelist_active = [
  theme1list_active,
  theme2list_active,
  theme3list_active,
  theme4list_active
];

final baseTabViewProvider = StateProvider<ViewType>((ref) => ViewType.home);
final themechangeProvider = StateProvider((ref) => 0);

enum ViewType { home, charts, outlier, onoff, settings }

class BaseTabView extends ConsumerWidget {
  BaseTabView({Key? key}) : super(key: key);

  final widgets = [
    //ページリスト
    Data_page(),
    GraphPage(),
    OutlierPage(),
    SwitchOnOff(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(baseTabViewProvider.state);
    final theme_index = ref.watch(themechangeProvider);

    return Scaffold(
      body: widgets[view.state.index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SizedBox(width: 50, child: themelist[theme_index][0]),
              activeIcon:
                  SizedBox(width: 50, child: themelist_active[theme_index][0]),
              label: AppLocalizations.of(context).home),
          BottomNavigationBarItem(
              icon: SizedBox(width: 50, child: themelist[theme_index][1]),
              activeIcon:
                  SizedBox(width: 50, child: themelist_active[theme_index][1]),
              label: AppLocalizations.of(context).charts_title),
          BottomNavigationBarItem(
              icon: SizedBox(width: 50, child: themelist[theme_index][2]),
              activeIcon:
                  SizedBox(width: 50, child: themelist_active[theme_index][2]),
              label: AppLocalizations.of(context).outlier),
          BottomNavigationBarItem(
              icon: SizedBox(width: 50, child: themelist[theme_index][3]),
              activeIcon:
                  SizedBox(width: 50, child: themelist_active[theme_index][3]),
              label: AppLocalizations.of(context).power),
          BottomNavigationBarItem(
              icon: SizedBox(width: 50, child: themelist[theme_index][4]),
              activeIcon:
                  SizedBox(width: 50, child: themelist_active[theme_index][4]),
              label: AppLocalizations.of(context).settings),
        ],
        currentIndex: view.state.index,
        onTap: (int index) => view.update((state) => ViewType.values[index]),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class MyImageIcon extends ImageIcon {
  const MyImageIcon(
    ImageProvider image, {
    Key? key,
    double? size,
    Color? color,
    String? semanticLabel,
  }) : super(image,
            key: key, size: size, color: color, semanticLabel: semanticLabel);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: Image(
        image: image as ImageProvider,
        width: size,
        height: size,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        excludeFromSemantics: true,
        // color属性は設定しない
      ),
    );
  }
}
