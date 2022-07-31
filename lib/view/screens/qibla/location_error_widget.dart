import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/widgets/elevated_button/elevated_button_custom.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const box = SizedBox(height: 32);
    const errorColor = Color(0xffb00020);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: ColorManager.primary,
          ),
          box,
          textCustom(
            context: context,
            text:
            error!,
            color: errorColor, fontWeight: FontWeight.bold,fontSize: 20.sp
          ),
          box,
          ElevatedButtonCustom(height: 10.h,
            text:  "اعادة المحاولة",
            onPressed: () {
              if (callback != null) callback!();
            },
          )
        ],
      ),
    );
  }
}
