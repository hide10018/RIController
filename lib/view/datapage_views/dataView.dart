import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:transport_predict_app/settings/setting_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:transport_predict_app/view/others/widgets.dart';
import '../../view_model/dataViewModel.dart';
import '../others/basetabview.dart';

class Data_page extends ConsumerStatefulWidget {
  const Data_page({Key? key}) : super(key: key);

  @override
  _Data_page createState() => _Data_page();
}

class _Data_page extends ConsumerState<Data_page> {
  Future? _data;

  Future builderGiveData() async {
    //future builderにmapのdataを渡すfuture関数
    DataViewModel dataViewModel = DataViewModel(ref);
    final _MapData = await dataViewModel.AllDataSet();
    return _MapData;
  }

  @override
  void initState() {
    //counter処理が美しくないので別の方法を模索中
    counter = 0;
    _data = builderGiveData();
    setState(() {});

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    DataViewModel dataViewModel = DataViewModel(ref);

    var screenSize = MediaQuery //画面サイズ取得
            .of(context)
        .size;
    var date = DateTime.now(); //時間取得
    var date_h = date.hour;
    var min = date.minute;
    var date_m = (min - min % 5).toString().padLeft(2, "0");

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            counter = 0; //カウンターの初期化
            _data = builderGiveData();

            setState(() {});
          },
          label: Text(AppLocalizations.of(context).get_data),
          icon: Icon(Icons.download),
        ),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).title,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).disabledColor,
        ),
        body: FutureBuilder(
            future: _data?.timeout(const Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      //snapshotが読み込めていなかったら読み込み画面を出す
                      color: Theme.of(context).primaryColor,
                      size: 100),
                );
              } else {
                return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: dataViewModel.background_img(
                          ref.read(themechangeProvider.notifier).state),
                      colorFilter: ColorFilter.mode(
                          switch_value
                              ? Colors.white.withOpacity(0.6)
                              : Colors.white.withOpacity(0.7),
                          BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        ref.watch(UserEmailProvider.notifier).state ==
                                "Please Login!"
                            ?
                            //UserEmailProviderの値がPlease Login!と一致していた場合Welcomeを省く
                            Text(
                                '${ref.watch(UserEmailProvider.notifier).state}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor))
                            : Text(
                                '${ref.watch(UserEmailProvider.notifier).state}, Welcome!',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor)),
                        Text('$date_h:$date_m',
                            style: TextStyle(
                                fontSize: 50,
                                color: Theme.of(context).primaryColor)),
                        Row(
                          children: [
                            DataViewWidget(
                                //temp dataの表示
                                screenSize: screenSize,
                                ref: ref,
                                lang: AppLocalizations.of(context).temperature,
                                data:
                                    "${ref.watch(NowTmpProvider.notifier).state}℃",
                                img: 'assets/tmpicon.png',
                                color: Colors.blueAccent),
                            SizedBox(
                              //余白
                              width: screenSize.width * 0.03,
                            ),
                            DataViewWidget(
                                //hum data の表示
                                screenSize: screenSize,
                                ref: ref,
                                lang: AppLocalizations.of(context).humidity,
                                data:
                                    "${ref.watch(NowHumProvider.notifier).state}%",
                                img: 'assets/humicon.png',
                                color: Colors.pink),
                          ],
                        ),
                        SizedBox(
                          //余白
                          height: screenSize.height * 0.03,
                        ),
                        Row(
                          children: [
                            DataViewWidget(
                                screenSize: screenSize,
                                ref: ref,
                                lang: AppLocalizations.of(context).air_pressure,
                                data:
                                    "${ref.watch(NowPressureProvider.notifier).state}HPA",
                                img: 'assets/ifn0112.png',
                                color: Colors.greenAccent),
                            SizedBox(
                              width: screenSize.width * 0.03,
                            ),
                            DataViewWidget(
                                screenSize: screenSize,
                                ref: ref,
                                lang: "PM2.5",
                                data:
                                    "${ref.watch(NowDustProvider.notifier).state}μg/m^3",
                                img: 'assets/ifn0112.png',
                                color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ],
                    ));
              }
            }));
  }
}
