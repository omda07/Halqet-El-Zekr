class HadethInfoModel {
  String? id;
  String? title;
  String? hadeeth;
  String? attribution;
  String? grade;
  String? explanation;
  List<String>? hints;
  List<String>? categories;
  List<String>? translations;
  List<WordsMeanings>? wordsMeanings;
  String? reference;

  HadethInfoModel(
      {this.id,
      this.title,
      this.hadeeth,
      this.attribution,
      this.grade,
      this.explanation,
      this.hints,
      this.categories,
      this.translations,
      this.wordsMeanings,
      this.reference});

  HadethInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    hadeeth = json['hadeeth'];
    attribution = json['attribution'];
    grade = json['grade'];
    explanation = json['explanation'];
    hints = json['hints'].cast<String>();
    categories = json['categories'].cast<String>();
    translations = json['translations'].cast<String>();
    if (json['words_meanings'] != null) {
      wordsMeanings = <WordsMeanings>[];
      json['words_meanings'].forEach((v) {
        wordsMeanings!.add(WordsMeanings.fromJson(v));
      });
    }
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['hadeeth'] = hadeeth;
    data['attribution'] = attribution;
    data['grade'] = grade;
    data['explanation'] = explanation;
    data['hints'] = hints;
    data['categories'] = categories;
    data['translations'] = translations;
    if (wordsMeanings != null) {
      data['words_meanings'] = wordsMeanings!.map((v) => v.toJson()).toList();
    }
    data['reference'] = reference;
    return data;
  }
}

class WordsMeanings {
  String? word;
  String? meaning;

  WordsMeanings({this.word, this.meaning});

  WordsMeanings.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    meaning = json['meaning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['meaning'] = meaning;
    return data;
  }
}
