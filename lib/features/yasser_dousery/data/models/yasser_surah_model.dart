import '../../domain/entities/yasser_surah_entity.dart';

class QuranAudioModel extends QuranAudiosEntity {
  QuranAudioModel({
    bool? status,
    String? message,
    List<SurahEntity>? surahEntity,
  }) : super(
          message: message ?? '',
          status: status ?? false,
          surahEntity: surahEntity ?? [],
        );

  factory QuranAudioModel.fromJson(Map<String, dynamic> json) =>
      QuranAudioModel(
        surahEntity: List<SurahEntity>.from(
            json['QuranAudios'].map((e) => SurahModel.fromJson(e))),
        status: json['status'],
        message: json['message'],
      );
}

class SurahModel extends SurahEntity {
  const SurahModel({
    String? sId,
    int? reciterNum,
    int? number,
    String? title,
    String? content,
    String? quranAudioPath,
  }) : super(
          title: title ?? '',
          sId: sId ?? '',
          content: content ?? '',
          quranAudioPath: quranAudioPath ?? '',
          reciterNum: reciterNum ?? 0,
          number: number ?? 0,
        );

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        sId: json['_id'],
        title: json['title'],
        content: json['content'],
        quranAudioPath: json['quranAudioPath'],
        reciterNum: json['reciterNum'],
        number: json['number'],
      );
}
