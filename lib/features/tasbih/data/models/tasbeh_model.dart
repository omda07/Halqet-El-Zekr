class TasbehModel {
  List<Tasbeh>? tasbeh;

  TasbehModel({this.tasbeh});

  TasbehModel.fromJson(Map<String, dynamic> json) {
    if (json['Tasbeh'] != null) {
      tasbeh = <Tasbeh>[];
      json['Tasbeh'].forEach((v) {
        tasbeh!.add(Tasbeh.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasbeh != null) {
      data['Tasbeh'] = tasbeh!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasbeh {
  String? category;
  String? count;
  String? description;
  String? reference;
  String? content;
  int? counter;
  double? percent;
  Tasbeh(
      {this.category,
      this.count,
      this.description,
      this.reference,
      this.content,
      this.counter,
      this.percent});

  Tasbeh.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    content = json['content'];
    counter = json['counter'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['count'] = count;
    data['description'] = description;
    data['reference'] = reference;
    data['content'] = content;
    data['counter'] = counter;
    data['percent'] = percent;
    return data;
  }
}
