import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/usecases/hadeeth_usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

import '../../domain/entities/hadeeth_info_entity.dart';
import 'hadeth_info_state.dart';

class HadethInfoCubit extends Cubit<HadethInfoStates> {
  final HadeethInfoUsecase hadeethInfoUsecase;

  HadethInfoCubit({
    required this.hadeethInfoUsecase,
  }) : super(InitialHadethInfoState());

  static HadethInfoCubit get(context) => BlocProvider.of(context);

  // HadethDetailsModel? hadethDetailsModel;
  List<Map<String, dynamic>> list = [];

  String hadeethName = '';

  String id = '';
  getHadethInfo() async {
    emit(GetHadethInfoLoading());

    Either<Failure, HadeethInfoEntity> response =
        await hadeethInfoUsecase(HadeethInfoParams(hadeethId: id));
    response.fold(
        (failure) => emit(GetHadethInfoError(error: failure.message)),
        (hadeethInfoEntity) =>
            emit(GetHadethInfoSuccess(hadeethInfoEntity: hadeethInfoEntity)));
  }
}
