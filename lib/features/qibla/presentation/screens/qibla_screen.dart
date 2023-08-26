import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import '../../../../core/widgets/app_bar/app_bar_custom.dart';
import '../../../../core/widgets/scaffold_custom/scaffold_custom.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'loading_indicator.dart';
import 'qiblah_compass.dart';

class QiblaScreen extends StatelessWidget {
  QiblaScreen({Key? key}) : super(key: key);
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      appBarCustom: const AppBarCustom(
        text: 'اتجاه القبلة',
      ),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: TextCustom(text: "خطأ: ${snapshot.error.toString()}"),
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
