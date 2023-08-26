import 'package:hesn_elmuslim/features/hadeth/data/models/hadeeth_categ_model.dart';
import 'package:hesn_elmuslim/features/hadeth/data/models/hadeeth_info_model.dart';
import 'package:hesn_elmuslim/features/hadeth/data/models/hadeth_details_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';

abstract class HadeethRemoteDataSource {
  Future<HadeethCategoriesModel> hadeethCategories();

  Future<HadeethDetailsModel> hadeethDetails({
    String? categoryId,
    String? page,
  });

  Future<HadeethInfoModel> hadeethInfo({
    String? hadeethId,
  });
}

class HadeethRemoteDataSourceImpl implements HadeethRemoteDataSource {
  ApiConsumer apiConsumer;

  HadeethRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<HadeethCategoriesModel> hadeethCategories() async {
    final response = await apiConsumer.get(EndPoints.getHadeethCategories);

    return HadeethCategoriesModel.fromJson(response);
  }

  @override
  Future<HadeethDetailsModel> hadeethDetails(
      {String? categoryId, String? page}) async {
    final response = await apiConsumer.get(EndPoints.getHadeethDetails,
        queryParameters: {"category_id": categoryId, "page": page});

    return HadeethDetailsModel.fromJson(response);
  }

  @override
  Future<HadeethInfoModel> hadeethInfo({String? hadeethId}) async {
    final response = await apiConsumer
        .get(EndPoints.getHadeethInfo, queryParameters: {"id": hadeethId});

    return HadeethInfoModel.fromJson(response);
  }
}
