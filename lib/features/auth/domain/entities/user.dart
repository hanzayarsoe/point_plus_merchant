import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String accountNumber,
    String? primaryPhoneNumber,
    String? email,
    required String? openTime,
    required String? closeTime,
    required int branchAmount,
    required String branchAddress,
    required int merchantId,
    required String merchantName,
    required Manager manager,
  }) = _User;
}
