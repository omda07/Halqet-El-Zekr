import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hesn_elmuslim/features/hadeth/domain/usecases/hadeeth_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'features/hadeth/data/datasources/hadeeth_remote_datasource.dart';
import 'features/hadeth/data/repositories/hadeeth_repository_impl.dart';
import 'features/hadeth/domain/repositories/hadeeth_repository.dart';
import 'features/hadeth/presentation/hadeth_cubit/hadeth_cubit.dart';
import 'features/hadeth/presentation/hadeth_details_cubit/hadeth_details_cubit.dart';
import 'features/hadeth/presentation/hadeth_info_cubit/hadeth_info_cubit.dart';
import 'features/profile/data/datasources/profile_datasource.dart';
import 'features/profile/data/datasources/profile_local_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/profile_usecase.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/quran/data/datasources/quran_remote_datasource.dart';
import 'features/quran/data/repositories/quran_repository_impl.dart';
import 'features/quran/domain/repositories/quran_repository.dart';
import 'features/quran/domain/usecases/quran_usecase.dart';
import 'features/quran/presentation/quran_cubit/quran_cubit.dart';
import 'features/quran/presentation/surah_cubit/surah_cubit.dart';
import 'features/quran_audio/data/datasorces/recitations_remote_datasource.dart';
import 'features/quran_audio/data/repositories/recitations_repostiory_impl.dart';
import 'features/quran_audio/domain/repositories/recitations_repository.dart';
import 'features/quran_audio/domain/usecases/recitations_usecase.dart';
import 'features/quran_audio/presentation/controller/aduio_cubit/audio_cubit.dart';
import 'features/quran_audio/presentation/controller/recitations_cubit/recitations_cubit.dart';

import 'features/settings/data/datasources/settings_datasource.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/settings_usecase.dart';
import 'features/settings/presentation/cubit/settings_cubit.dart';
import 'features/yasser_dousery/data/datasources/yasser_surah_remote_datasource.dart';
import 'features/yasser_dousery/data/repositories/yasser_surah_repository_impl.dart';
import 'features/yasser_dousery/domain/repositories/yasser_surah_repository.dart';
import 'features/yasser_dousery/domain/usecases/yasser_surah_usecase.dart';
import 'features/yasser_dousery/presentation/manager/rooms_cubit/yasser_surah_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  ///////////////////////////////////////////////////////// Blocs//////////////////////////////////////////////////

  sl.registerLazySingleton<HadethCubit>(
      () => HadethCubit(hadeethCategoriesUsecase: sl()));
  sl.registerLazySingleton<HadethDetailsCubit>(
      () => HadethDetailsCubit(hadeethDetailsUsecase: sl()));
  sl.registerLazySingleton<HadethInfoCubit>(
      () => HadethInfoCubit(hadeethInfoUsecase: sl()));
  sl.registerLazySingleton<QuranCubit>(
      () => QuranCubit(quranUsecase: sl(), quranAudioUsecase: sl()));
  sl.registerLazySingleton<SurahCubit>(() => SurahCubit(surahUsecase: sl()));
  sl.registerLazySingleton<RecitationsCubit>(
      () => RecitationsCubit(recitationsUsecase: sl()));
  sl.registerLazySingleton<AudioCubit>(() => AudioCubit(audioUsecase: sl()));

  sl.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(profileUsecase: sl()));

  sl.registerLazySingleton<QuranAudioCubit>(
      () => QuranAudioCubit(quranAudiosUsecase: sl()));

  //*****************************************// Use cases \\**************************************\\

  sl.registerLazySingleton<HadeethCategoriesUsecase>(
      () => HadeethCategoriesUsecase(sl()));
  sl.registerLazySingleton<HadeethDetailsUsecase>(
      () => HadeethDetailsUsecase(sl()));
  sl.registerLazySingleton<HadeethInfoUsecase>(() => HadeethInfoUsecase(sl()));
  sl.registerLazySingleton<QuranUsecase>(() => QuranUsecase(sl()));
  sl.registerLazySingleton<QuranAudioUsecase>(() => QuranAudioUsecase(sl()));
  sl.registerLazySingleton<SurahUsecase>(() => SurahUsecase(sl()));
  sl.registerLazySingleton<RecitationsUsecase>(() => RecitationsUsecase(sl()));
  sl.registerLazySingleton<AudioUsecase>(() => AudioUsecase(sl()));

  sl.registerLazySingleton<ProfileUsecase>(() => ProfileUsecase(sl()));

  sl.registerLazySingleton<SettingsCubit>(
      () => SettingsCubit(settingsUsecase: sl()));
  sl.registerLazySingleton<SettingsUsecase>(() => SettingsUsecase(sl()));

  sl.registerLazySingleton<QuranAudiosUsecase>(() => QuranAudiosUsecase(sl()));

///////////////////**************************** // Repository //*****************************************//////////////////////


  sl.registerLazySingleton<HadeethRepository>(() => HadeethRepositoryImpl(
        hadeethRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<QuranRepository>(() => QuranRepositoryImpl(
        quranRemoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<RecitationsRepository>(
      () => RecitationsRepositoryImpl(
            recitationsRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
        profileLocalDataSource: sl(),
        profileRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(
        settingsRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<QuranAudiosRepository>(
      () => QuranAudioRepositoryImpl(
            quranAudioRemoteDataSource: sl(),
            networkInfo: sl(),
          ));

///////////////////***************************// Data Sources //**********************************************///////////////////

  sl.registerLazySingleton<HadeethRemoteDataSource>(
      () => HadeethRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<QuranRemoteDataSource>(
      () => QuranRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<RecitationsRemoteDataSource>(
      () => RecitationsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));


  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));


  sl.registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));

  sl.registerLazySingleton<QuranAudioRemoteDataSource>(
      () => QuranAudioRemoteDataSourceImpl(
            apiConsumer: sl(),
          ));



  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
