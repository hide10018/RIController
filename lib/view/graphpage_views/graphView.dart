import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:transport_predict_app/view_model/dataViewModel.dart';
import 'package:transport_predict_app/view_model/graphViewModel.dart';
import 'package:transport_predict_app/settings/setting_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../others/basetabview.dart';

class GraphPage extends ConsumerStatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends ConsumerState<GraphPage> {


  @override
  void initState() {
    Future((){
      graphCounter = 0;

      GraphViewModel graphViewModel = GraphViewModel(ref);
      graphViewModel.OneDayDataSet();
    });
    super.initState();
  }


  Widget build(BuildContext context) {
    GraphViewModel graphViewModel = GraphViewModel(ref);

    DataViewModel dataViewModel = DataViewModel(ref);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            graphCounter = 0;

            graphViewModel.OneDayDataSet();

            setState(() {
            });
          },
          label: Text(AppLocalizations.of(context).get_data),
          icon: Icon(Icons.download),
        ),

        appBar: AppBar(
          title: Text(AppLocalizations.of(context).charts_title,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          backgroundColor: Theme.of(context).disabledColor,
        ),
        body: FutureBuilder(
          future: graphViewModel.OneDayDataSet(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    //snapshotが読み込めていなかったら読み込み画面を出す
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 100)
              );
            }else{
              return
                Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Text(
                        AppLocalizations.of(context).temperature2,
                        style: TextStyle(
                            fontSize: 20, color: Colors.lightBlueAccent),
                      ),
                      graphViewMethod(context, screenSize, tempValue),//温度のグラフ

                      Text(
                        AppLocalizations.of(context).humidity2,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),

                      graphViewMethod(context, screenSize, humValue),//湿度のグラフ

                      Text(
                        AppLocalizations.of(context).air_pressure2,
                        style: TextStyle(
                            fontSize: 20, color: Colors.greenAccent),
                      ),

                      graphViewMethod(context, screenSize, apValue),

                      Text(
                        'PM2.5(μg/m^3)',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),

                      graphViewMethod(context, screenSize, dustValue),

                    ],
                  ),
                ),
              );
            }
          },
        ));
  }





  ///bottomTitleWidgetsにcontextの引数を追加すると呼び出せなかった為viewに…
  SingleChildScrollView graphViewMethod(BuildContext context, Size screenSize, List<double> list,) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:Container(
                          color: Theme.of(context)
                              .disabledColor
                              .withOpacity(0.5),
                          padding: const EdgeInsets.all(10),
                          margin: screenSize.width >= 500
                              ? EdgeInsets.fromLTRB(
                              screenSize.width * 0, 50, 0, 50)
                              : const EdgeInsets.fromLTRB(0, 50, 0, 50),
                          width: screenSize.width >= 500
                              ? screenSize.width * 1
                              : screenSize.width * 2,
                          height: screenSize.height * 0.4,
                          child: LineChart(
                            LineChartData(
                              minX: 0,
                              maxX: 25,
                              minY: list.reduce(min) - 3,
                              maxY: list.reduce(max) + 3,
                              lineBarsData: [
                                LineChartBarData(spots: [
                                  FlSpot(0, list[0]),
                                  FlSpot(1, list[1]),
                                  FlSpot(2, list[2]),
                                  FlSpot(3, list[3]),
                                  FlSpot(4, list[4]),
                                  FlSpot(5, list[5]),
                                  FlSpot(6, list[6]),
                                  FlSpot(7, list[7]),
                                  FlSpot(8, list[8]),
                                  FlSpot(9, list[9]),
                                  FlSpot(10, list[10]),
                                  FlSpot(11, list[11]),
                                  FlSpot(12, list[12]),
                                  FlSpot(13, list[13]),
                                  FlSpot(14, list[14]),
                                  FlSpot(15, list[15]),
                                  FlSpot(16, list[16]),
                                  FlSpot(17, list[17]),
                                  FlSpot(18, list[18]),
                                  FlSpot(19, list[19]),
                                  FlSpot(20, list[20]),
                                  FlSpot(21, list[21]),
                                  FlSpot(22, list[22]),
                                  FlSpot(23, list[23]),
                                ]),
                              ],
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                      sideTitles:
                                      SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                      SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: leftTitleWidgets,
                                      reservedSize: 33,
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: bottomTitleWidgets,
                                    ),
                                  )),
                            ),
                          )));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      fontFamily: 'Digital',
      fontSize: 10,
    );
    String text;
    var x = (value).toInt();

    switch (x) {
      case 0:
        text = AppLocalizations.of(context).now;
        break;
      case 3:
        text = '3' + AppLocalizations.of(context).hour_ago;
        break;
      case 6:
        text = '6' + AppLocalizations.of(context).hour_ago;
        break;
      case 9:
        text = '9' + AppLocalizations.of(context).hour_ago;
        break;
      case 12:
        text = '12' + AppLocalizations.of(context).hour_ago;
        break;
      case 15:
        text = '15' + AppLocalizations.of(context).hour_ago;
        break;
      case 18:
        text = '18' + AppLocalizations.of(context).hour_ago;
        break;
      case 21:
        text = '21' + AppLocalizations.of(context).hour_ago;
        break;
      case 24:
        text = '24' + AppLocalizations.of(context).hour_ago;
        break;
      default:
        return const Text('');
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style2 = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      fontFamily: 'Digital',
      fontSize: 10,
    );
    String text;
    var y = (value).toInt();
    var x = (y).toString();
    text = x;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, softWrap: false, style: style2),
    );
  }

  Widget DleftTitleWidgets(double value, TitleMeta meta) {
    var style2 = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
      fontFamily: 'Digital',
      fontSize: 10,
    );
    String _text;
    var x = value.toStringAsFixed(1);
    var y = (x).toString();
    _text = y;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(_text, softWrap: false, style: style2),
    );
  }
}
