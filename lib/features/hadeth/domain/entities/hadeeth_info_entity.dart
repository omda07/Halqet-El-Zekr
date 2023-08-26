import 'package:equatable/equatable.dart';

class HadeethInfoEntity extends Equatable {
  final String id;
  final String title;
  final String hadeeth;
  final String attribution;
  final String grade;
  final String explanation;
  final List<String> hints;

  final List<WordsMeaningsEntity> wordsMeanings;
  final String reference;

  const HadeethInfoEntity(
      {required this.id,
      required this.title,
      required this.hadeeth,
      required this.attribution,
      required this.grade,
      required this.explanation,
      required this.hints,
      required this.wordsMeanings,
      required this.reference});

  @override
  List<Object?> get props => [
        id,
        title,
        hadeeth,
        attribution,
        grade,
        explanation,
        hints,
        wordsMeanings,
        reference,
      ];
}

class WordsMeaningsEntity extends Equatable {
  final String word;
  final String meaning;

  const WordsMeaningsEntity({required this.word, required this.meaning});

  @override
  List<Object> get props => [word, meaning];
}
