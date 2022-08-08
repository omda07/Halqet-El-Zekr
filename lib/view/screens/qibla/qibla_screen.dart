import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:hesn_elmuslim/view/screens/qibla/qiblah_compass.dart';
import 'package:hesn_elmuslim/view/widgets/app_bar/app_bar_custom.dart';

import '../../widgets/text_custom/text_custom.dart';
import 'loading_indicator.dart';

class QiblaScreen extends StatelessWidget {
   QiblaScreen({Key? key}) : super(key: key);
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context: context,leading: 'القبلة',onPressed: (){
        Navigator.pop(context);
      }),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: textCustom(context:context,text:"Error: ${snapshot.error.toString()}"),
            );
          }

          if (snapshot.data!) {
            return const QiblahCompass();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),

    );
  }
}
