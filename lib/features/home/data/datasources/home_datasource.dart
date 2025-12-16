import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/data/models/customer_model.dart';
import 'package:merchant/features/home/data/models/noti_model.dart';
import 'package:merchant/features/home/data/models/point_request_detail_model.dart';
import 'package:merchant/features/home/data/models/point_request_model.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';

abstract interface class HomeDatasource {
  TaskEither<Failure, void> transferPoints(
    PointTransferEntity pointTransferEntity,
  );
  TaskEither<Failure, CustomerModel> searchCustomer(String accountNumber);
  TaskEither<Failure, List<PointRequestModel>> getRequestHistories(
    int page,
    int limit,
    RequestTransactionType? type,
    String? startDate,
    String? endDate,
  );

  TaskEither<Failure, void> requestPoints(
    int points,
    RequestTransactionType type,
  );
  TaskEither<Failure, PointRequestDetailModel> getRequestDetail(int id);
  TaskEither<Failure, List<NotiModel>> getNotifs(int page, int limit);
  TaskEither<Failure, int> getUnreadCount();
  TaskEither<Failure, void> markAsRead(String notiId);
}
