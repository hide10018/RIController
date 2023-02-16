import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transport_predict_app/models/datapage_models/userinfo_model.dart';
import 'package:transport_predict_app/models/graphpage_models/onedaydust_model.dart';
import 'package:transport_predict_app/models/graphpage_models/onedayhum_model.dart';
import 'package:transport_predict_app/models/graphpage_models/onedaypressure_model.dart';
import 'package:transport_predict_app/models/graphpage_models/onedaytemp_model.dart';

final OneDayTempProvider = StateProvider<Object?>((ref) => '-');
final OneDayHumProvider = StateProvider<Object?>((ref) => '-');
final OneDayDustProvider = StateProvider<Object?>((ref) => '-');
final OneDayPressureProvider = StateProvider<Object?>((ref) => '-');
final TempFLSpotProvider = StateProvider<Object?>((ref) => '-');

List<double> tempValue = List<double>.generate(24, (i) => 0); //グラフデータ初期値0埋め

List<double> humValue = List<double>.generate(24, (i) => 20);

List<double> dustValue = List<double>.generate(24, (i) => 0);

List<double> apValue = List<double>.generate(24, (i) => 970);

int graphCounter = 0;

class GraphViewModel extends ChangeNotifier {
  GraphViewModel(this.ref) : super();
  final WidgetRef ref;

  OneDayDust oneDayDust = OneDayDust();
  OneDayHum oneDayHum = OneDayHum();
  OneDayPressure oneDayPressure = OneDayPressure();
  OneDayTemp oneDayTemp = OneDayTemp();
  UserInformation userInformation = UserInformation();

  Future OneDayDataSet() async {
    if (graphCounter == 0) {
      graphCounter += 1;
      await userInformation.getUserInfo();
      await oneDayTemp.getOneDaytemp();
      await oneDayHum.getOneDayHum();
      await oneDayDust.getOneDayDust();
      await oneDayPressure.getOneDayPressure();

      tempValue.clear();
      humValue.clear();
      dustValue.clear();
      apValue.clear();

      var date = DateTime.now();

      for (var i = date.hour; i >= 0; i--) {
        await double_cast(
            oneDayTemp.data?.child("${i}").value as num, tempValue);

        await double_cast(oneDayHum.data?.child("${i}").value as num, humValue);

        await double_cast(
            oneDayDust.data?.child("${i}").value as double, dustValue);

        await double_cast(
            oneDayPressure.data?.child("${i}").value as double, apValue);
        print(tempValue);
        print(humValue);
        print(dustValue);
        print(apValue);
      }

      for (var i = 23; i > date.hour; i--) {
        await double_cast(
            oneDayTemp.data?.child("${i}").value as num, tempValue);

        await double_cast(oneDayHum.data?.child("${i}").value as num, humValue);

        await double_cast(
            oneDayDust.data?.child("${i}").value as double, dustValue);

        await double_cast(
            oneDayPressure.data?.child("${i}").value as double, apValue);

        print(tempValue);
        print(humValue);
        print(dustValue);
        print(apValue);
      }
      ref.watch(OneDayTempProvider.notifier).state = tempValue;
      ref.watch(OneDayHumProvider.notifier).state = humValue;
      ref.watch(OneDayDustProvider.notifier).state = dustValue;
      ref.watch(OneDayPressureProvider.notifier).state = apValue;

      await Future.delayed(Duration(seconds: 1));
      return [tempValue, humValue, dustValue, apValue];
    } else {
      graphCounter += 1;
      ref.watch(OneDayTempProvider.notifier).state = tempValue;
      ref.watch(OneDayHumProvider.notifier).state = humValue;
      ref.watch(OneDayDustProvider.notifier).state = dustValue;
      ref.watch(OneDayPressureProvider.notifier).state = apValue;
      await Future.delayed(Duration(seconds: 1));
      return [tempValue, humValue, dustValue, apValue];
    }
  }

  List<FlSpot> FlSpot_Cast(list) {
    var spotList;
    for (var i = 0; i > list.length; i++) {
      FlSpot spot = FlSpot(i.toDouble(), list[i]);
      spotList.add(spot);
    }
    return spotList;
  }

  double_cast(data, list) {
    var x = double.parse("${data}");

    list.add(x);
  }
}
