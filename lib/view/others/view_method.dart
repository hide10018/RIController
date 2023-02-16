import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../settings/setting_page.dart';

Widget image_theme(img, img2, BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  if (switch_value == true) {
    return SizedBox(
        width: screenSize.width * 0.5,
        height: 300,
        child: Center(
            child: Image.asset(
          img,
          color: Colors.lightBlueAccent,
        )));
  } else {
    return SizedBox(
        width: screenSize.width * 0.5,
        height: 300,
        child: Center(
            child: Image.asset(
          img2,
          color: Colors.lightBlueAccent,
        )));
  }
}

void showProgressDialog(BuildContext context) {
  //ロード画面
  showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 400),
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).primaryColor, size: 100),
        );
      });
}

Widget ListItem(title, icon, switch_bool, num, {double size = 45}) {
  //Switch pageのアイコン用
  return Row(
    children: [
      SizedBox(
        width: 40,
      ),
      Column(
        children: [
          Row(children: [
            Text(
              num,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: 45,
              height: 45,
              child: Center(
                child: Container(
                    width: size,
                    height: size,
                    child: switch_bool
                        ? ImageIcon(
                            AssetImage(icon),
                            size: 10,
                            color: Colors.green,
                          )
                        : ImageIcon(
                            AssetImage(icon),
                            size: 10,
                          )),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ]),
          SizedBox(
            height: 23,
          )
        ],
      ),
    ],
  );
}
