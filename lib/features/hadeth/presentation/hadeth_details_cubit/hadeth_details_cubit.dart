import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/usecases/hadeeth_usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/hadeeth_details_entity.dart';
import 'hadeth_details_state.dart';

class HadethDetailsCubit extends Cubit<HadethDetailsStates> {
  final HadeethDetailsUsecase hadeethDetailsUsecase;

  HadethDetailsCubit({
    required this.hadeethDetailsUsecase,
  }) : super(InitialHadethDetailsState());

  static HadethDetailsCubit get(context) => BlocProvider.of(context);

  String? categoryId = '';
  String page = '1';
  String categoryName = '';

  getHadethDetails() async {
    emit(GetHadethDetailsLoading());

    Either<Failure, HadeethDetailsEntity> response =
        await hadeethDetailsUsecase(
            HadeethDetailsParams(categoryId: categoryId!, page: page));
    response.fold(
        (failure) => emit(GetHadethDetailsError(error: failure.message)),
        (hadeethDetailsEntity) => emit(GetHadethDetailsSuccess(
            hadeethDetailsEntity: hadeethDetailsEntity)));
  }
}
