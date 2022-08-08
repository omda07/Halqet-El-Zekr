import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/cubit/people/people_states.dart';
import 'package:hesn_elmuslim/model/people/people_model.dart';

class PeopleCubit extends Cubit<PeopleSates> {
  PeopleCubit() : super(InitialState());

  static PeopleCubit get(context) => BlocProvider.of(context);

  PeopleModel? peopleModel;
  List<PeopleModel> names = [];

  Future<void> getNamesData() async {
    emit(GetPeopleLoadingState());
    try {
       FirebaseFirestore.instance
          .collection('people')
          .orderBy('dateTime', descending: true)
          .where('approved', isEqualTo: true)
          .snapshots()
          .listen((event) {
        // print(event.docs);
        names = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            // print(element.reference);
            peopleModel = PeopleModel.fromJson(element.data());
            names.add(PeopleModel.fromJson(element.data()));
          }
        }

        emit(GetPeopleSuccessState());
      });
    } catch (error) {
      print(error);
      emit(GetPeopleErrorState(error.toString()));
    }
  }

  void createName({required String name, required uid}) async {
    emit(InsertPeopleLoadingState());

    await FirebaseFirestore.instance.collection('people').add({
      'name': name,
      'uid': uid,
      'approved': false,
      'dateTime': DateTime.now()
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('people')
          .doc(value.id)
          .update({"id": value.id});
      emit(InsertPeopleSuccessState());
    }).catchError((onError) {
      emit(InsertPeopleErrorState(onError.toString()));
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance
        .collection('people')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeletePeopleSuccessState());
    }).catchError((error) {
      print("Failed to delete user: $error");
      emit(DeletePeopleErrorState(error.toString()));
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

    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId =
          '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId =
          '${androidDeviceInfo.model}:${androidDeviceInfo.id}'; // unique ID on Android
    }
  }
}
