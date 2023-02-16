import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:transport_predict_app/settings/setting_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:transport_predict_app/view_model/outlierViewModel.dart';
import '../../view_model/dataViewModel.dart';
import '../others/basetabview.dart';

class OutlierPage extends ConsumerStatefulWidget {
  const OutlierPage({Key? key}) : super(key: key);

  @override
  _OutlierPageState createState() => _OutlierPageState();
}

class _OutlierPageState extends ConsumerState<OutlierPage> {
  @override
  void initState() {
    Future(() async {
      outlierCounter = 0;
      OutlierViewModel outlierViewModel = OutlierViewModel(ref);
      await outlierViewModel.OutlierDataSet(context);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    OutlierViewModel outlierViewModel = OutlierViewModel(ref);
    DataViewModel dataViewModel = DataViewModel(ref);
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            outlierCounter = 0;
            ref.refresh(OutlierPredictProvider.notifier);

            await outlierViewModel.OutlierDataSet(context);
            setState(() {});
          },
          label: Text(AppLocalizations.of(context).get_data),
          icon: Icon(Icons.download_rounded),
        ),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).outlier,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).disabledColor,
        ),
        body: FutureBuilder(
            future: outlierViewModel.OutlierDataSet(context),
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
                    child: ListView(
                      children:
                          ref.watch(OutlierPredictProvider.notifier).state,
                    ));
              }
            }));
  }
}

class OutlierView {
  Object? data;

  Widget View(title_text, text_color, screenSize, context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: screenSize.height * 0.025,
              bottom: screenSize.height * 0.025),
          // padding: EdgeInsets.only(right: screenSize.width*0.03,left: screenSize.width*0.03),
          width: screenSize.width * 0.7,
          height: screenSize.height * 0.25,
          decoration: BoxDecoration(
              color: text_color.disabledColor.withOpacity(0.5),
              border: Border.all(color: text_color.disabledColor),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title_text),
              Container(
                padding: EdgeInsets.only(),
                child: Center(
                  child: BorderedText(
                    child: Text(
                      data == 1
                          ? AppLocalizations.of(context).safety
                          : AppLocalizations.of(context).anomaly,
                      style: TextStyle(
                          color: data == 1
                              ? Colors.lightGreenAccent
                              : Colors.pinkAccent,
                          fontSize: 30),
                    ),
                    strokeWidth: 1.0,
                    strokeColor: text_color.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget error() {
    return Container(
      child: Text('APIに接続できませんでした。'),
    );
  }

  OutlierView(this.data);
}
