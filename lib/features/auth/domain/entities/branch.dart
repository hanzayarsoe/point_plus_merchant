import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';

part 'branch.freezed.dart';

@freezed
abstract class Branch with _$Branch {
  const factory Branch({
    required int id,
    required String name,
    required String accountNumber,
    String? primaryPhoneNumber,
    String? secondaryPhoneNumber,
    String? email,
    required String? openTime,
    required String? closeTime,
    required int branchAmount,
    String? about,
    String? profileUrl,
    required String branchAddress,
    required int merchantId,
    required String merchantName,
    required Manager manager,
  }) = _Branch;
}
