import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class OutlierModel extends ChangeNotifier {
  OutlierModel(this.ref) : super();
  final WidgetRef ref;

  Map<String, dynamic>? pred_json;

  Future getOutlier() async {
    http.Response result = await http //センサーデータの値を埋め込んだAPIのURLを生成
        .get(Uri.parse('API URL'))
        .timeout(const Duration(seconds: 3)); //3秒繋がらなければタイムアウト
    this.pred_json = jsonDecode(result.body); //pred_jsonに結果を取得
  }
}
