import '../../domain/entities/hadeeth_info_entity.dart';

class HadeethInfoModel extends HadeethInfoEntity {
  HadeethInfoModel({
    String? id,
    String? title,
    String? hadeeth,
    String? attribution,
    String? grade,
    String? explanation,
    List<String>? hints,
    List<WordsMeaningsEntity>? wordsMeanings,
    String? reference,
  }) : super(
          title: title ?? '',
          id: id ?? '',
          attribution: attribution ?? '',
          explanation: explanation ?? '',
          grade: grade ?? '',
          hadeeth: hadeeth ?? '',
          hints: hints ?? [],
          reference: reference ?? '',
          wordsMeanings: wordsMeanings!,
        );

  factory HadeethInfoModel.fromJson(Map<String, dynamic> json) =>
      HadeethInfoModel(
        id: json['id'],
        title: json['title'],
        hadeeth: json['hadeeth'],
        attribution: json['attribution'],
        grade: json['grade'],
        explanation: json['explanation'],
        hints: json['hints'].cast<String>(),
        reference: json['reference'],
        wordsMeanings: List.from(
            json['words_meanings'].map((e) => WordsMeaningsModel.fromJson(e))),
      );
}

class WordsMeaningsModel extends WordsMeaningsEntity {
  const WordsMeaningsModel({
    String? word,
    String? meaning,
  }) : super(
          meaning: meaning ?? '',
          word: word ?? '',
        );

  factory WordsMeaningsModel.fromJson(Map<String, dynamic> json) =>
      WordsMeaningsModel(
        word: json['word'],
        meaning: json['meaning'],
      );
}
