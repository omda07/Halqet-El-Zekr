class PeopleModel {
  List<Data>? data;
  int? status;
  dynamic error;
  dynamic count;


  PeopleModel({this.data, this.status, this.error, this.count});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
    error = json['error'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['error'] = error;
    data['count'] = count;
    return data;
  }
}

class Data {
  int? id;
  String? createdAt;
  String? name;
  bool? approved;
  Data({this.id, this.createdAt, this.name,this.approved});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
    approved = json['approved'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    data['approved'] = approved;
    return data;
  }
}
