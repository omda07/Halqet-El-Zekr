import 'dart:convert';
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

  Future<void> share(String link,String title, String text) async {
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


  int count= 0;
  double percent=0;

  incrementCounter(
      {required int counter}
      ) {
    late double constNumber=1/counter;
    if(count<counter) {
      count++;
      percent = percent+constNumber;
      emit(GetPercent());
      //percent=percent2;
    }else{
      return null;
    }
  }
  refresh() {
    count = 0;
    percent = 0.0;
    emit(Refresh());
  }
  double result = 0.0;
  calculateZakat({required double money}){
     result = money *(2.5/100);
     emit(Calculation());
  }


  Location location = new Location();
  LocationData? locationData;
  determinePosition() async {


    bool _serviceEnabled;
    PermissionStatus _permissionGranted;


    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return ;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return ;
      }
    }

    locationData = await location.getLocation();
    print(locationData);
    emit(GetLocation());
  }

}
