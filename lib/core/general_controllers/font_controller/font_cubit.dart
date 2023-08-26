import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesn_elmuslim/core/local/cache_helper.dart';
import 'package:hesn_elmuslim/core/utils/strings_manager.dart';

import 'font_state.dart';

class FontCubit extends Cubit<FontState> {
  FontCubit() : super(FontInitial());

  static FontCubit get(context) => BlocProvider.of(context);

  double? azkarFontSize;
  double? duaaFontSize;
  double? hadethFontSize;

  saveAzkarFontSize() async {
    emit(SaveFontSizeLoadingState());
    try {
      var cache = await CacheHelper.put(
          key: AppStrings.cachedFontSize, value: azkarFontSize?.sp ?? 16.0.sp);
      if (cache) {
        emit(SaveFontSizeSuccessState());
      } else {
        emit(const SaveFontSizeErrorState(message: 'Can\'t Save The Size'));
      }
    } catch (error) {
      emit(SaveFontSizeErrorState(message: error.toString()));
    }
  }

  saveDuaaFontSize() async {
    emit(SaveDuaaFontSizeLoadingState());
    try {
      var cache = await CacheHelper.put(
          key: AppStrings.cachedDuaaFontSize,
          value: duaaFontSize?.sp ?? 16.0.sp);
      if (cache) {
        emit(SaveDuaaFontSizeSuccessState());
      } else {
        emit(const SaveDuaaFontSizeErrorState(message: 'Can\'t Save The Size'));
      }
    } catch (error) {
      emit(SaveDuaaFontSizeErrorState(message: error.toString()));
    }
  }

  saveHadethFontSize() async {
    emit(SaveHadethFontSizeLoadingState());
    try {
      var cache = await CacheHelper.put(
          key: AppStrings.cachedHadethFontSize,
          value: hadethFontSize?.sp ?? 16.0.sp);
      if (cache) {
        emit(SaveHadethFontSizeSuccessState());
      } else {
        emit(const SaveHadethFontSizeErrorState(
            message: 'Can\'t Save The Size'));
      }
    } catch (error) {
      emit(SaveHadethFontSizeErrorState(message: error.toString()));
    }
  }

  getFontSize() {
    emit(GetFontSizeLoadingState());
    azkarFontSize = CacheHelper.get(key: AppStrings.cachedFontSize) ?? 16.sp;
    duaaFontSize = CacheHelper.get(key: AppStrings.cachedDuaaFontSize) ?? 16.sp;
    hadethFontSize =
        CacheHelper.get(key: AppStrings.cachedHadethFontSize) ?? 16.sp;
    emit(GetFontSizeSuccessState());
  }
}
