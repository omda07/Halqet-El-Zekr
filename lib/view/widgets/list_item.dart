import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import 'package:hesn_elmuslim/view/widgets/text_custom/text_custom.dart';

class ListItemCustom extends StatelessWidget {
  final Widget screen;
  final String text;
  Widget? leading;
  final String image;
  final int index;
   ListItemCustom({Key? key, required this.screen, required this.text, required this.image,this.leading, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      padding:  EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            offset: const Offset(0.6, 1.2), //(x,y)
            blurRadius: 6.0,
          ),
        ],
        color: ColorManager.cardColor,
      ),
      child: InkWell(
        onTap: () {


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
        child: Padding(
          padding:  EdgeInsets.all(8.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/$image.png',scale:10 ,
                // width: 60,
              ),
              Flexible(
                child: textCustom(
                  textAlign: TextAlign.start,
                  context: context,
                  text: text,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              leading ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
