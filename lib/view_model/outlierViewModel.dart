import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transport_predict_app/models/outlierpage_models/outlier_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../view/outlier_views/outlierView.dart';

int outlierCounter = 0;
final OutlierPredictProvider = StateProvider<List<Widget>>((ref) => []);

class OutlierViewModel extends ChangeNotifier {
  OutlierViewModel(this.ref) : super();
  final WidgetRef ref;

  Future OutlierDataSet(BuildContext context) async {
    OutlierModel outlierModel = OutlierModel(ref);

    if (outlierCounter == 0) {
      try {
        outlierCounter += 1;
        await outlierModel.getOutlier();

        print(outlierModel.pred_json);

        ref.watch(OutlierPredictProvider.notifier).state = await [
          OutlierView(outlierModel.pred_json!['Temperature']).View(
              AppLocalizations.of(context).temperature2,
              Theme.of(context),
              MediaQuery.of(context).size,
              context),
          OutlierView(outlierModel.pred_json!['Humidity']).View(
              AppLocalizations.of(context).humidity2,
              Theme.of(context),
              MediaQuery.of(context).size,
              context),
          OutlierView(outlierModel.pred_json!['AirPressure']).View(
              AppLocalizations.of(context).air_pressure2,
              Theme.of(context),
              MediaQuery.of(context).size,
              context),
          OutlierView(outlierModel.pred_json!['PM2.5']).View('PM2.5(μg/m^3)',
              Theme.of(context), MediaQuery.of(context).size, context),
        ];
      } on TimeoutException catch (e) {
        ref.watch(OutlierPredictProvider.notifier).state = [
          Column(
            children: [
              Container(
                child: Text('APIに接続できませんでした。'),
              ),
            ],
          )
        ];
      }
      return ref.watch(OutlierPredictProvider.notifier).state;
    } else {
      try {
        outlierCounter += 1;
        await Future.delayed(Duration(seconds: 3));

        ref.watch(OutlierPredictProvider.notifier).state = [
          OutlierView(outlierModel.pred_json!['Temperature']).error(),
          OutlierView(outlierModel.pred_json!['Humidity']).View(
              AppLocalizations.of(context).humidity2,
              Theme.of(context),
              MediaQuery.of(context).size,
              context),
          OutlierView(outlierModel.pred_json!['AirPressure']).View(
              AppLocalizations.of(context).air_pressure2,
              Theme.of(context),
              MediaQuery.of(context).size,
              context),
          OutlierView(outlierModel.pred_json!['PM2.5']).View('PM2.5(μg/m^3)',
              Theme.of(context), MediaQuery.of(context).size, context),
        ];
      } on TimeoutException catch (e) {
        ref.watch(OutlierPredictProvider.notifier).state = [
          Column(
            children: [
              Container(
                child: Text('APIに接続できませんでした。'),
              ),
            ],
          )
        ];
      }
      return ref.watch(OutlierPredictProvider.notifier).state;
    }
  }
}
