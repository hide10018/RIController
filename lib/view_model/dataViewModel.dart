import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transport_predict_app/models/datapage_models/dust_model.dart';
import 'package:transport_predict_app/models/datapage_models/hum_model.dart';
import 'package:transport_predict_app/models/datapage_models/pressure_model.dart';
import 'package:transport_predict_app/models/datapage_models/sharedpreferance_model.dart';
import 'package:transport_predict_app/models/datapage_models/temp_model.dart';
import 'package:transport_predict_app/models/datapage_models/userinfo_model.dart';

final NowTmpProvider = StateProvider<Object?>((ref) => '-');
final NowHumProvider = StateProvider<Object?>((ref) => '-');
final NowDustProvider = StateProvider<Object?>((ref) => '-');
final NowPressureProvider = StateProvider<Object?>((ref) => '-');

final UserEmailProvider = StateProvider<String?>((ref) => '-');
final UserUidProvider = StateProvider<String?>((ref) => '-');

int counter = 0;

class DataViewModel extends ChangeNotifier {
  //vmはChangeNotifier?
  DataViewModel(this.ref) : super();
  final WidgetRef ref;

  Dust dust = Dust(); //modelのインスタンス化
  Temperature tmp = Temperature();
  Pressure pressure = Pressure();
  Humidity humidity = Humidity();
  UserInformation userInformation = UserInformation();

  Future<void> SensorDataSet() async {
    try {
      await tmp.getNowTemperature(); //メソッドの実行で値をthis.dataに格納
      await humidity.getNowHumidity();
      await dust.getNowDust();
      await pressure.getNowPressure();

      // final dust_cast = DataCast(dust.data);//少数第三位までにキャスト
      // final pressure_cast = DataCast(pressure.data);

      ref.watch(NowDustProvider.notifier).state = dust.data; //riverpodに格納
      ref.watch(NowTmpProvider.notifier).state = tmp.data;
      ref.watch(NowPressureProvider.notifier).state = pressure.data;
      ref.watch(NowHumProvider.notifier).state = humidity.data;
    } catch (e) {
      print('data get error');
      print(e);
    }
  }

  Future<void> UserDataSet() async {
    await userInformation.getUserInfo();

    ref.watch(UserEmailProvider.notifier).state =
        userInformation.email; //riverpodにemailを格納
    ref.watch(UserUidProvider.notifier).state =
        userInformation.uid; //riverpodにuidを格納
  }

  Future<Map<String, dynamic>> AllDataSet() async {
    //future builderに使うために1つのメソッドにまとめる
    if (counter == 0) {
      counter += 1;
      SharedPreferencesGetter sharedPreferencesGetter =
          SharedPreferencesGetter(ref);

      await sharedPreferencesGetter.getPrefItems();
      await UserDataSet();
      await SensorDataSet();

      var dataMap = {
        'tmp': ref.watch(NowTmpProvider.notifier).state,
        'humidity': ref.watch(NowHumProvider.notifier).state,
        'dust': ref.watch(NowDustProvider.notifier).state,
        'pressure': ref.watch(NowPressureProvider.notifier).state,
        'email': ref.watch(UserEmailProvider.notifier).state,
      };

      return dataMap;
    } else {
      counter += 1;

      var dataMap = {
        'tmp': ref.watch(NowTmpProvider.notifier).state,
        'humidity': ref.watch(NowHumProvider.notifier).state,
        'dust': ref.watch(NowDustProvider.notifier).state,
        'pressure': ref.watch(NowPressureProvider.notifier).state,
        'email': ref.watch(UserEmailProvider.notifier).state,
      };
      return dataMap;
    }
  }

  String DataCast(d) {
    var data_cast = d as double;
    var data = data_cast.toStringAsFixed(3);
    return data;
  }

  AssetImage background_img(theme_index) {
    //背景テーマ用
    if (theme_index == 2) {
      return AssetImage('assets/IMG_3541.jpg');
    } else if (theme_index == 3) {
      return AssetImage(
          'assets/wp6205436-minimal-solar-system-hd-wallpapers.jpg');
    } else {
      return AssetImage('');
    }
  }
}
