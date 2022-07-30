import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/view/resources/color_manager.dart';
import '../widgets/text_custom/text_custom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/1789.jpg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCustom(
                            context: context,
                            text: 'الفجر',
                            color: ColorManager.white,
                            fontSize: 18.sp),
                        textCustom(
                            context: context,
                            text: 'am 5:13',
                            color: ColorManager.white,
                            fontSize: 18.sp),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textCustom(
                        context: context,
                        text: '14 جمادي اولي 1443',
                        color: ColorManager.white,
                        fontSize: 20.sp),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: GridView.count(
              shrinkWrap: true,
              primary: false,
              // padding: const EdgeInsets.all(20),
              // crossAxisSpacing: 0.2,
              mainAxisSpacing: 1.2,
              crossAxisCount: 3,
              children: <Widget>[
                buildItem(
                    label: 'القرآن الكريم',
                    url: 'assets/images/quran.png',
                    screen: 'quran',
                    context: context),
                buildItem(
                    label: 'المصحف',
                    url: 'assets/images/quran1.png',
                    screen: 'quranOff',
                    context: context),
                buildItem(
                    label: 'التسبيح',
                    url: 'assets/images/tasbih.png',
                    screen: 'tasbehScreen',
                    context: context),
                buildItem(
                    label: 'دعاء',
                    url: 'assets/images/pray.png',
                    screen: 'DuaaScreen',
                    context: context),
                buildItem(
                    label: 'القبلة',
                    url: 'assets/images/kaaba.png',
                    screen: 'qibla',
                    context: context),
                buildItem(
                    label: 'الاحاديث النبوية',
                    url: 'assets/images/muslim.png',
                    screen: 'HadeethCategoriesScreen',
                    context: context),
                buildItem(
                    label: 'مواقيت الصلاة',
                    url: 'assets/images/prayer-mat.png',
                    screen: 'pray',
                    context: context),
                buildItem(
                    label: 'اذكار',
                    url: 'assets/images/moon.png',
                    screen: 'azkarScreen',
                    context: context),
                buildItem(
                    label: 'حساب الزكاة',
                    url: 'assets/images/money-bag.png',
                    screen: 'zakat',
                    context: context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String label,
    required String url,
    Function? onTap,
    context,
    String? screen,
  }) {
    return InkWell(
      onTap: () {

        Navigator.pushNamed(context, screen!);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(
              url,
              width: 45,
              height: 45,
            ),
            textCustom(
              context: context,
              text: label,
              fontSize: 16.sp
            ),
          ],
        ),
      ),
    );
  }
}
