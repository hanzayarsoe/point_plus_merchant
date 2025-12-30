import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/utils/task_either_helpers.dart';
import 'package:merchant/features/store/data/datasources/store_datasource.dart';
import 'package:merchant/features/store/data/models/item_model.dart';

class StoreDatasourceImpl implements StoreDatasource {
  final DioHelper dioHelper;
  StoreDatasourceImpl(this.dioHelper);
  @override
  TaskEither<Failure, List<ItemModel>> getItems({
    required int page,
    required int limit,
    required int merchantId,
    required bool allItems,
    required bool promoItems,
  }) {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.get(
        ApiUrls.items,
        queryParameters: {
          "merchantId": merchantId,
          "page": page,
          "size": limit,
          "allItems": allItems,
          "promoItems": promoItems,
        },
      );
      final List<dynamic> data = response.data['data']['content'];
      return data.map((item) => ItemModel.fromJson(item)).toList();
    });
  }
}
