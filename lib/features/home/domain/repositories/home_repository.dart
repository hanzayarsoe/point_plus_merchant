import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';
import 'package:merchant/features/home/domain/entities/noti_entity.dart';
import 'package:merchant/features/home/domain/entities/point_request_detail_entity.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';

abstract interface class HomeRepository {
  TaskEither<Failure, void> transferPoint(
    PointTransferEntity pointTransferEntity,
  );
  TaskEither<Failure, CustomerEntity> searchCustomer(String phoneNumber);
  TaskEither<Failure, List<PointRequestEntity>> getRequestHistory(
    int page,
    int limit,
    RequestTransactionType? type,
    String? startDate,
    String? endDate,
  );
  TaskEither<Failure, void> requestPoints(
    RequestTransactionType type,
    int points,
  );
  TaskEither<Failure, PointRequestDetailEntity> getRequestDetail(int id);
  TaskEither<Failure, List<NotiEntity>> getNotifs({
    required int page,
    required int limit,
  });
  TaskEither<Failure, int> getUnreadCount();
  TaskEither<Failure, void> markAsRead(String notiId);
}
