import 'dart:async';
import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geolocator/geolocator.dart';
import 'package:hesn_elmuslim/core/utils/assets_manager.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/text_custom/text_custom.dart';
import 'loading_indicator.dart';
import 'location_error_widget.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({Key? key}) : super(key: key);

  @override
  QiblahCompassState createState() => QiblahCompassState();
}

class QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0.sp),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              // case GeolocationStatus.unknown:
              //   return LocationErrorWidget(
              //     error: "Unknown Location service error",
              //     callback: _checkLocationStatus,
              //   );
              default:
                return Container();
            }
          } else {
            return LocationErrorWidget(
              error: "من فضلك فعل تحديد الموقع",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {
  // final _compassSvg = SvgPicture.asset('assets/compass.svg');
  // final _needleSvg = SvgPicture.asset(
  //   'assets/needle.svg',
  //   fit: BoxFit.contain,
  //   height: 160.h,
  //   alignment: Alignment.center,
  // );

  final _compassSvg = Image.asset(ImageAssets.compassImg);

  final _needleSvg = Image.asset(
    ImageAssets.needleImg,
  );

  QiblahCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        }

        final qiblahDirection = snapshot.data!;
        if (qiblahDirection.offset.toStringAsFixed(0) ==
            qiblahDirection.direction.toStringAsFixed(0)) {
          Vibration.vibrate(duration: 100);
        }
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: TextCustom(
                  maxLines: 3,
                  text:
                      "تحذير : حافظ علي وضع الهاتف افقي. قد تتسبب القطع المعدنية او المجالات المغناطيسية في حدوث خطأ.",
                  fontSize: 18.sp,
                  color: ColorManager.error,
                  fontWeight: FontWeight.bold),
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _compassSvg,
                // Transform.rotate(
                //   angle: (qiblahDirection.direction * (pi / 180) * -1),
                //   child: _compassSvg,
                // ),
                Transform.rotate(
                  angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                  alignment: Alignment.center,
                  child: _needleSvg,
                ),
              ],
            ),
            TextCustom(
                text: "${qiblahDirection.offset.toStringAsFixed(3)}°",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
            TextCustom(
                text: "${qiblahDirection.direction.toStringAsFixed(0)}°",
                fontSize: 20.sp,
                color: qiblahDirection.offset.toStringAsFixed(0) !=
                        qiblahDirection.direction.toStringAsFixed(0)
                    ? ColorManager.primary
                    : ColorManager.greenColor,
                fontWeight: FontWeight.bold),
          ],
        );
      },
    );
  }
}
