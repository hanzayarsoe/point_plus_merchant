import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_entity.freezed.dart';

@freezed
abstract class CustomerEntity with _$CustomerEntity {
  const factory CustomerEntity({
    required int id,
    required String name,
    required String? email,
    required String phoneNumber,
    required String accountNumber,
    required String? profile,
    required String? gender,
    required int? pointBalance,
  }) = _CustomerEntity;
}
