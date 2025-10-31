import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/home/domain/entities/transaction_entity.dart';
part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
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
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

extension TransactionModelX on TransactionModel {
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      type: type,
      amount: amount,
      fromAccount: fromAccount,
      toAccount: toAccount,
      action: action,
      customerName: customerName,
      branchName: branchName,
      merchantName: merchantName,
      createdAt: createdAt,
      description: description,
    );
  }
}
