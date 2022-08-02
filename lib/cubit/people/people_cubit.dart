

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/cubit/people/people_states.dart';
import 'package:hesn_elmuslim/model/people/people_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PeopleCubit extends Cubit<PeopleSates>{
  PeopleCubit() : super(InitialState());

  static PeopleCubit get(context) =>BlocProvider.of(context);

  PeopleModel? peopleModel;
final client =Supabase.instance.client;
  Future insertName({required String name})async{
    emit(InsertPeopleLoadingState());
    await client.from('people').insert({

      'name': name,
    }).execute().then((value) {
      print('------------------${value.status}');
      emit(InsertPeopleSuccessState());
    }).catchError((onError){
      print(onError);
      emit(InsertPeopleErrorState(onError));
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

}