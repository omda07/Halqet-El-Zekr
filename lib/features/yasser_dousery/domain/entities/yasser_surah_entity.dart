import 'package:equatable/equatable.dart';

class QuranAudiosEntity extends Equatable {
  final bool status;
  final String message;
  final List<SurahEntity> surahEntity;

  const QuranAudiosEntity({
    required this.status,
    required this.message,
    required this.surahEntity,
  });

  @override
  List<Object> get props => [status, message, surahEntity];
}

class SurahEntity extends Equatable {
  final String sId;
  final int reciterNum;
  final int number;

  final String title;
  final String content;
  final String quranAudioPath;

  const SurahEntity({
    required this.sId,
    required this.reciterNum,
    required this.number,
    required this.title,
    required this.content,
    required this.quranAudioPath,
  });

  @override
  List<Object> get props => [
        sId,
        reciterNum,
        number,
        title,
        content,
        quranAudioPath,
      ];
}
