

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/cubit/people/people_states.dart';
import 'package:hesn_elmuslim/model/people/people_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PeopleCubit extends Cubit<PeopleSates>{
  PeopleCubit() : super(InitialState());

  static PeopleCubit get(context) =>BlocProvider.of(context);

  PeopleModel? peopleModel;
final client =Supabase.instance.client;
  Future insertName({required String name,required uid})async{
    emit(InsertPeopleLoadingState());
    await client.from('people').insert({

      'name': name,
      'uid':uid
    }).execute().then((value) {
      print('------------------${value.status}');
      emit(InsertPeopleSuccessState());
    }).catchError((onError){
      print(onError);
      emit(InsertPeopleErrorState(onError));
    });
  }

  Future deleteName({required id})async{
    emit(DeletePeopleLoadingState());
    await client.from('people').delete().eq('id', id).execute().then((value) {
      print('------------------${value.status}');
      getNames();
      emit(DeletePeopleSuccessState());
    }).catchError((onError){
      print(onError);
      emit(DeletePeopleErrorState(onError));
    });
  }


  Future<void> getNames()async{
    emit(GetPeopleLoadingState());
client.from('people').select().eq('approved', true).order('created_at').execute().then((value) {
  print(value.toJson());

  peopleModel = PeopleModel.fromJson( value.toJson());
  print(peopleModel!.data![0].id);
  emit(GetPeopleSuccessState(peopleModel!));
}).catchError((onError){
  print(onError);
  emit(GetPeopleErrorState(onError.toString()));
});


  }

  bool isBottomSheetShown = false;

  void changeBottomSheetState({
    required bool isShow,
  }) {
    isBottomSheetShown = isShow;

    emit(AppChangeBottomSheetState());
  }
  String uniqueDeviceId = '';
   getUniqueDeviceId() async {


    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId = '${iosDeviceInfo.name}:${iosDeviceInfo
          .identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId = '${androidDeviceInfo.model}:${androidDeviceInfo
          .id}'; // unique ID on Android
    }

  }


}