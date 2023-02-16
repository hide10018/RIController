import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:transport_predict_app/models/switchpage_models/switch_model.dart';
import 'package:transport_predict_app/view/others/view_method.dart';
import 'package:transport_predict_app/view_model/switchViewModel.dart';

class SwitchOnOff extends ConsumerStatefulWidget {
  @override
  SwitchOnOffState createState() => SwitchOnOffState();
}

class SwitchOnOffState extends ConsumerState<SwitchOnOff> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    SwitchModel switchModel = SwitchModel(ref);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          SwitchModel switchModel = SwitchModel(ref);
          switchModel.getSwitchData();
          setState(() {});
        },
        label: Text(AppLocalizations.of(context).get_data),
        icon: Icon(Icons.download_rounded),
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).power,
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).disabledColor,
      ),
      body: FutureBuilder(
          future: switchModel.getSwitchData(),
          builder: (context, snapshot) {
            SwitchViewModel switchViewModel = SwitchViewModel(ref);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    //snapshotが読み込めていなかったら読み込み画面を出す
                    color: Theme.of(context).primaryColor,
                    size: 100),
              );
            } else {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: screenSize.width * 0.1,
                        top: screenSize.height * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                              height: screenSize.height * 0.6,
                              child: Image.asset("assets/plug.png")),
                        ),
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      //bool値をfirebaseに書き込む
                                      ref.watch(switchProvider.notifier).state =
                                          switchViewModel.SwitchDataChange(
                                              ref
                                                  .watch(
                                                      switchProvider.notifier)
                                                  .state,
                                              'all');
                                      switchViewModel.write(
                                          ref,
                                          'all',
                                          ref
                                              .watch(switchProvider.notifier)
                                              .state);
                                      setState(() {
                                        //setStateがないとボタンの描画が更新されない。調査中
                                      });
                                    },
                                    child: ListItem(
                                        AppLocalizations.of(context).all,
                                        "assets/power.png",
                                        ref
                                            .watch(switchProvider.notifier)
                                            .state,
                                        "1.",
                                        size: 30)),
                                GestureDetector(
                                  onTap: () {
                                    //bool値をfirebaseに書き込む
                                    ref
                                            .watch(fanswitchProvider.notifier)
                                            .state =
                                        switchViewModel.SwitchDataChange(
                                            ref
                                                .watch(
                                                    fanswitchProvider.notifier)
                                                .state,
                                            'fan');
                                    switchViewModel.write(
                                        ref,
                                        'fan',
                                        ref
                                            .watch(fanswitchProvider.notifier)
                                            .state);
                                    setState(() {
                                      //setStateがないとボタンの描画が更新されない。調査中
                                    });
                                  },
                                  child: ListItem(
                                    AppLocalizations.of(context).fan,
                                    "assets/fan_icon.png",
                                    ref.watch(fanswitchProvider.notifier).state,
                                    "2.",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //bool値をfirebaseに書き込む
                                    ref
                                            .watch(humfiswitchProvider.notifier)
                                            .state =
                                        switchViewModel.SwitchDataChange(
                                            ref
                                                .watch(humfiswitchProvider
                                                    .notifier)
                                                .state,
                                            'humfi');
                                    switchViewModel.write(
                                        ref,
                                        'humfi',
                                        ref
                                            .watch(humfiswitchProvider.notifier)
                                            .state);
                                    setState(() {
                                      //setStateがないとボタンの描画が更新されない。調査中
                                    });
                                  },
                                  child: ListItem(
                                    AppLocalizations.of(context).humidifier,
                                    "assets/aroma-icon96962.png",
                                    ref
                                        .watch(humfiswitchProvider.notifier)
                                        .state,
                                    "3.",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //bool値をfirebaseに書き込む
                                    ref
                                            .watch(lightswitchProvider.notifier)
                                            .state =
                                        switchViewModel.SwitchDataChange(
                                            ref
                                                .watch(lightswitchProvider
                                                    .notifier)
                                                .state,
                                            'light');
                                    switchViewModel.write(
                                        ref,
                                        'light',
                                        ref
                                            .watch(lightswitchProvider.notifier)
                                            .state);
                                    setState(() {
                                      //setStateがないとボタンの描画が更新されない。調査中
                                    });
                                  },
                                  child: ListItem(
                                    AppLocalizations.of(context).light,
                                    "assets/light.png",
                                    ref
                                        .watch(lightswitchProvider.notifier)
                                        .state,
                                    "4.",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //bool値をfirebaseに書き込む
                                    ref
                                            .watch(airclswitchProvider.notifier)
                                            .state =
                                        switchViewModel.SwitchDataChange(
                                            ref
                                                .watch(airclswitchProvider
                                                    .notifier)
                                                .state,
                                            'aircl');
                                    switchViewModel.write(
                                        ref,
                                        'aircl',
                                        ref
                                            .watch(airclswitchProvider.notifier)
                                            .state);
                                    setState(() {
                                      //setStateがないとボタンの描画が更新されない。調査中
                                    });
                                  },
                                  child: ListItem(
                                    AppLocalizations.of(context).air_cleaner,
                                    "assets/aircleaner.png",
                                    ref
                                        .watch(airclswitchProvider.notifier)
                                        .state,
                                    "5.",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //bool値をfirebaseに書き込む
                                    ref
                                            .read(esp32switchProvider.notifier)
                                            .state =
                                        switchViewModel.SwitchDataChange(
                                            ref
                                                .read(esp32switchProvider
                                                    .notifier)
                                                .state,
                                            'esp32');
                                    switchViewModel.write(
                                        ref,
                                        'esp32',
                                        ref
                                            .read(esp32switchProvider.notifier)
                                            .state);
                                    setState(() {
                                      //setStateがないとボタンの描画が更新されない。調査中
                                    });
                                  },
                                  child: ListItem(
                                      AppLocalizations.of(context).sensor,
                                      "assets/power.png",
                                      ref
                                          .read(esp32switchProvider.notifier)
                                          .state,
                                      "6.",
                                      size: 30),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
