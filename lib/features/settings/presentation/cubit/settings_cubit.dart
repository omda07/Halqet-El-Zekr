import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/settings_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  final SettingsUsecase settingsUsecase;

  SettingsCubit({required this.settingsUsecase}) : super(InitSettingsState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  Future<void> deleteUserFun() async {
    emit(DeleteUserLoadingState());
    Either<Failure, SettingsEntity> response =
        await settingsUsecase(NoParams());

    emit(response.fold(
        (failure) => DeleteUserErrorState(message: failure.message),
        (settingsEntity) =>
            DeleteUserSuccessState(settingsEntity: settingsEntity)));
  }


}
