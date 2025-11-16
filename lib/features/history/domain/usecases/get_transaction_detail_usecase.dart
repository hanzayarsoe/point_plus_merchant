import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/domain/repositories/history_repository.dart';
import 'package:merchant/features/home/domain/entities/transaction_entity.dart';

class GetTransactionDetailUsecase {
  final HistoryRepository historyRepository;
  GetTransactionDetailUsecase(this.historyRepository);
  TaskEither<Failure, TransactionEntity> call({required int id}) {
    return historyRepository.getTransactionDetail(id);
  }
}
