import 'package:cloud_firestore/cloud_firestore.dart';

class PeopleModel {
  String? id;
  Timestamp? dateTime;
  String? uid;
  bool? approved;
  String? name;

  PeopleModel({this.dateTime, this.uid, this.approved, this.name, this.id});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    uid = json['uid'];
    approved = json['approved'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateTime'] = dateTime;
    data['uid'] = uid;
    data['approved'] = approved;
    data['name'] = name;
    return data;
  }
}
