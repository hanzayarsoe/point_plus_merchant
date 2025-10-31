import 'package:freezed_annotation/freezed_annotation.dart';
part 'transaction_entity.freezed.dart';

@freezed
abstract class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required int id,
    required String type,
    required int amount,
    required String fromAccount,
    required String toAccount,
    required String action,
    required String? customerName,
    required String branchName,
    required String? merchantName,
    int? commissionAmount,
    required String createdAt,
    required String? description,
    String? direction,
  }) = _TransactionEntity;
}
