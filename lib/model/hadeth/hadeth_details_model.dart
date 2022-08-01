class HadethDetailsModel {
  List<Data>? data;
  Meta? meta;

  HadethDetailsModel({this.data, this.meta});

  HadethDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  List<String>? translations;

  Data({this.id, this.title, this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    translations = json['translations'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['translations'] = translations;
    return data;
  }
}

class Meta {
  String? currentPage;
  int? lastPage;
  int? totalItems;
  String? perPage;

  Meta({this.currentPage, this.lastPage, this.totalItems, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    totalItems = json['total_items'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total_items'] = totalItems;
    data['per_page'] = perPage;
    return data;
  }
}
