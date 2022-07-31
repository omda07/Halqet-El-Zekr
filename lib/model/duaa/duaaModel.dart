
import 'azkar_list.dart';

class AzkarModel {
   String? category;
   String? count;
   String? description;
   String? reference;
   String? zekr;

  AzkarModel(
      {required this.category, required this.count, required this.description, required this.reference, required this.zekr});

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'count': count,
      'description': description,
      'reference': reference,
      'zekr': zekr,
    };
  }

  factory AzkarModel.fromJson(Map<String, dynamic> map) {
    return AzkarModel(
      category: map['category'] ?? '',
      count: map['count'] ?? '',
      description: map['description'] ?? '',
      reference: map['reference'] ?? '',
      zekr: map['zekr'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Azkar(category: $category, count: $count, description: $description, reference: $reference, zekr: $zekr)';
  }

}
class AzkarByCategory {
  final List<AzkarModel> _azkarList = [];

  getAzkarByCategory(String category) {
    return allAzkar
        .where(
          (element) => element.containsValue(category),
    )
        .forEach(
          (element) {

        _azkarList.add(
          AzkarModel.fromJson(element),
        );
        print(element);
      },
    );
  }

  List<AzkarModel> get azkarList => _azkarList;
}