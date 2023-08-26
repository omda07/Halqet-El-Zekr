class AzkarMoriningModel {
  List<Morning>? morning;

  AzkarMoriningModel({this.morning});

  AzkarMoriningModel.fromJson(Map<String, dynamic> json) {
    if (json['morning'] != null) {
      morning = <Morning>[];
      json['morning'].forEach((v) {
        morning!.add(Morning.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (morning != null) {
      data['morning'] = morning!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Morning {
  String? category;
  String? count;
  String? description;
  String? reference;
  String? zekr;
  double? percent;
  int? counter;

  Morning(
      {this.category,
      this.count,
      this.description,
      this.reference,
      this.zekr,
      this.percent,
      this.counter});

  Morning.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    zekr = json['zekr'];
    percent = json['percent'];
    counter = json['counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['count'] = count;
    data['description'] = description;
    data['reference'] = reference;
    data['zekr'] = zekr;
    data['percent'] = percent;
    data['counter'] = counter;
    return data;
  }
}
