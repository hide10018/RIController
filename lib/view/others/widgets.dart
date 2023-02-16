import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/dataViewModel.dart';

Widget DataView(BuildContext context, WidgetRef ref) {
  final screenSize = MediaQuery //画面サイズ取得
          .of(context)
      .size;
  return Container(
    width: screenSize.width * 0.22,
    height: screenSize.height * 0.3,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: BorderedText(
              child: Text(
                AppLocalizations.of(context).temperature,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightBlueAccent,
                ),
              ),
              strokeWidth: 1.0,
              strokeColor: Theme.of(context).primaryColor,
            ),
          ),
          FittedBox(
            child: Text(
              '${ref.watch(NowTmpProvider.notifier).state}℃',
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'ds_digital',
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    ),
  );
}

class DataViewWidget extends StatelessWidget {
  //data pageでデータを見るためのwidget
  const DataViewWidget(
      {super.key,
      required this.screenSize,
      required this.ref,
      required this.img,
      required this.data,
      required this.lang,
      required this.color});

  final Size screenSize;
  final WidgetRef ref;
  final String img;
  final String data;
  final String lang;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.48,
      height: screenSize.height * 0.3,
      decoration: BoxDecoration(
          color: Theme.of(context).disabledColor.withOpacity(0.5),
          border: Border.all(color: Theme.of(context).disabledColor),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
              width: screenSize.width * 0.2,
              height: screenSize.height * 0.3,
              child: Center(
                child: Image.asset(
                  img,
                  color: Colors.lightBlueAccent,
                ),
              )),
          Container(
            width: screenSize.width * 0.22,
            height: screenSize.height * 0.3,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    child: BorderedText(
                      child: Text(
                        lang,
                        style: TextStyle(
                          fontSize: 30,
                          color: color,
                        ),
                      ),
                      strokeWidth: 1.0,
                      strokeColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      data,
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'ds_digital',
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
