import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/utils/task_either_helpers.dart';
import 'package:merchant/features/history/data/models/history_list_item_model.dart';
import 'package:merchant/features/home/data/datasources/home_datasource.dart';
import 'package:merchant/features/home/data/models/customer_model.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final DioHelper dioHelper;
  HomeDatasourceImpl(this.dioHelper);
  @override
  TaskEither<Failure, void> transferPoints(
    PointTransferEntity pointTransferEntity,
  ) {
    return tryCatchWithFailure(() async {
      final type = pointTransferEntity.type.toLowerCase();
      final isRequest = type.contains('request');
      final isRedeem = type.contains('redeem');
      final amount = int.tryParse(pointTransferEntity.amount ?? '');
      final customerQrCode = pointTransferEntity.customerQrCode;
      final accountNumber = pointTransferEntity.accountNumber;

      if (amount == null) {
        throw const Failure.network('Invalid or missing amount.');
      }

      if (isRequest && customerQrCode == null) {
        await dioHelper.post(ApiUrls.givePointByAccountNumber, {
          "accountNumber": accountNumber,
          "amount": amount,
        });
      } else if (isRedeem &&
          customerQrCode != null &&
          customerQrCode.isNotEmpty) {
        await dioHelper.post(ApiUrls.claimPointByQr, {
          "customerQrCode": customerQrCode,
          "amount": amount,
        });
      } else if (isRedeem && customerQrCode == null) {
        await dioHelper.post(ApiUrls.claimPointByAccountNumber, {
          "accountNumber": accountNumber,
          "amount": amount,
        });
      } else {
        throw const Failure.network(
          'Invalid transfer operation or missing details.',
        );
      }
    });
  }

  @override
  TaskEither<Failure, CustomerModel> searchCustomer(String accountNumber) {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.get(
        ApiUrls.searchCustomerByAccountNumber.replaceFirst(
          "{accountNumber}",
          accountNumber,
        ),
        {},
      );
      final data = response.data['data'];
      return CustomerModel.fromJson(data);
    });
  }

  @override
  TaskEither<Failure, List<HistoryListItemModel>> getRequestHistories(
    int page,
    int limit,
    RequestTransactionType? type,
    String? startDate,
    String? endDate,
  ) {
    return tryCatchWithFailure(() async {
      final String? apiType = switch (type) {
        RequestTransactionType.all => 'all',
        RequestTransactionType.recharge => 'recharge',
        RequestTransactionType.withdraw => 'withdraw',
        null => null,
      };
      final response = await dioHelper.get(
        ApiUrls.requestTransactionHistory,
        {},
        queryParameters: {
          "page": page,
          "limit": limit,
          if (apiType != null) "type": apiType,
          if (startDate != null) "startDate": startDate,
          if (endDate != null) "endDate": endDate,
        },
      );
      final List<dynamic> data = response.data['data']['item'];
      return data
          .map((transaction) => HistoryListItemModel.fromJson(transaction))
          .toList();
    });
  }
}
