class AzkarEveningModel {
  List<Evening>? evening;

  AzkarEveningModel({this.evening});

  AzkarEveningModel.fromJson(Map<String, dynamic> json) {
    if (json['evening'] != null) {
      evening = <Evening>[];
      json['evening'].forEach((v) {
        evening!.add(Evening.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (evening != null) {
      data['evening'] = evening!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Evening {
  String? category;
  String? count;
  String? description;
  String? reference;
  String? zekr;

  Evening(
      {this.category, this.count, this.description, this.reference, this.zekr});

  Evening.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    zekr = json['zekr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['count'] = count;
    data['description'] = description;
    data['reference'] = reference;
    data['zekr'] = zekr;
    return data;
  }
}
