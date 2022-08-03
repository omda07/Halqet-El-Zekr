import 'dart:convert';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hesn_elmuslim/cubit/home/home_state.dart';
import 'package:hesn_elmuslim/model/evening/azkar_evening_model.dart';
import 'package:hesn_elmuslim/model/morning/azkar_morning_model.dart';
import 'package:hesn_elmuslim/model/tasbeh/tasbeh_model.dart';
import 'package:location/location.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  void changeNav(int index) {
    selectedIndex = index;
    print(selectedIndex);
    emit(BottomNavBar());
  }

  List<String> title =['الشرط الأول:','الشرط الثانى:','الشرط الثالث:'];
  List<String> subTitle =[
    'بلوغ النصاب: أن يكون المبلغ كامل النصاب (85 جرام ذهب عيار 21) سعر الجرام بسعر اليوم، أى نقوم بضرب عدد الجرامات فى سعر الجرام الواحد فى يوم إخراج الزكاة، ويتم حساب الزكاة 2.5% من الأصل',
    'حولان الحول: عام هجرى كامل على النصاب',
    'أن تكون خاليا من الديون وفائض عن الحاجة أى يكون المال مدخر. كما أن حلى المرأة الذى تستخدمه للزينة ليس عليه زكاة، لأنها تتزين به، طالما أن النية منه الزينة، أما إذا كان الغرض منه الإدخار فعليها الزكاة، لكنها قد تخرج عليه صدقة من باب الورع.'
  ];

  Future<void> share(String link, String title, String text) async {
    await FlutterShare.share(
        title: 'title',
        text: text,
        linkUrl: link,
        chooserTitle: 'Example Chooser Title');
    emit(Share());
  }

  AzkarMoriningModel? azkarMoriningModel;

  getAzkarMorning({required BuildContext context}) async {
    try {
      emit(GetAzkarLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/azkar_elsabah.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      azkarMoriningModel = AzkarMoriningModel.fromJson(mJson);

      // allAzkar
      //     .where(
      //       (element) =>
      //       element.containsValue(category),
      // )
      //     .forEach((element) {
      //
      //   azkarList.add(
      //     AzkarModel.fromJson(element),
      //   );
      //
      // });
      print(azkarMoriningModel!.morning);
      emit(GetAzkarSuccess());
    } catch (e) {
      print(e);
      emit(GetAzkarError(e.toString()));
    }
  }

  AzkarEveningModel? azkarEveningModel;

  getAzkarEvening({required BuildContext context}) async {
    try {
      emit(GetAzkarEveningLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/azkar_elmasaa.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      azkarEveningModel = AzkarEveningModel.fromJson(mJson);

      print(azkarEveningModel!.evening);
      emit(GetAzkarEveningSuccess());
    } catch (e) {
      print(e);
      emit(GetAzkarEveningError(e.toString()));
    }
  }

  TasbehModel? tasbehModel;

  getTasbeh({required BuildContext context}) async {
    try {
      emit(GetTasbehLoading());
      var response = await DefaultAssetBundle.of(context)
          .loadString('assets/json/tasbeh.json');
      // now we have response as String from local json or and API request...
      var mJson = json.decode(response);
      // now we have a json...

      tasbehModel = TasbehModel.fromJson(mJson);

      print(tasbehModel!.tasbeh);
      emit(GetTasbehSuccess());
    } catch (e) {
      print(e);
      emit(GetTasbehError(e.toString()));
    }
  }

  int count = 0;
  double percent = 0;

  incrementCounter({required int counter}) {
    late double constNumber = 1 / counter;
    if (count < counter) {
      count++;
      percent = percent + constNumber;
      emit(GetPercent());
      //percent=percent2;
    } else {
      return null;
    }
  }

  refresh() {
    count = 0;
    percent = 0.0;
    emit(Refresh());
  }

  double moneyResult = 0.0;
  double goldResult = 0.0;
bool checkZakat = false;
  calculateZakat({required double money,required double gold}) {
    goldResult = (gold *85) *(2.5/100);
    moneyResult = money * (2.5 / 100);
    if(goldResult <= moneyResult){
      print(goldResult);
      print(moneyResult);
      checkZakat = true;
    }else{
       moneyResult = 0.0;
       goldResult = 0.0;
      checkZakat = false;
    }
    emit(Calculation());
  }

  Location location = Location();
  LocationData? locationData;
  Coordinates? myCoordinates;
  CalculationParameters? params;
  PrayerTimes? prayerTimes;

  determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    myCoordinates = Coordinates(
      locationData!.latitude!,
      locationData!.longitude!,
    ); // Replace with your own location lat, lng.
    params = CalculationMethod.egyptian.getParameters();

    params!.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(myCoordinates!, params!);
    print(locationData);
    emit(GetLocation());
  }

  String? getPrayerName() {
    switch (prayerTimes!.nextPrayer().name) {
      case 'fajr':
        return 'صلاة الفجر';
      case 'sunrise':
        return 'صلاة الشروق';
      case 'dhuhr':
        return 'صلاة الظهر';
      case 'asr':
        return 'صلاة العصر';
      case 'maghrib':
        return 'صلاة المغرب';
      case 'isha':
        return 'صلاة العشاء';
      case 'none':
      default:
        return null;

      // emit(GetPrayer());
    }
  }

  DateTime? getPrayer() {
    switch (prayerTimes!.nextPrayer().name) {
      case 'fajr':
        return prayerTimes!.timeForPrayer(Prayer.fajr);
      case 'sunrise':
        return prayerTimes!.timeForPrayer(Prayer.sunrise);
      case 'dhuhr':
        return prayerTimes!.timeForPrayer(Prayer.dhuhr);
      case 'asr':
        return prayerTimes!.timeForPrayer(Prayer.asr);
      case 'maghrib':
        return prayerTimes!.timeForPrayer(Prayer.maghrib);
      case 'isha':
        return prayerTimes!.timeForPrayer(Prayer.isha);
      case 'none':
        return null;
      default:
        return null;

      // emit(GetPrayer());
    }
  }
}
