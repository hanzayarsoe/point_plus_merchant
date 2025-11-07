import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/data/models/manager_model.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
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
    required ManagerModel manager,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      name: name,
      accountNumber: accountNumber,
      openTime: openTime,
      closeTime: closeTime,
      branchAmount: branchAmount,
      branchAddress: branchAddress,
      merchantId: merchantId,
      merchantName: merchantName,
      manager: manager.toEntity(),
    );
  }
}

extension UserX on User {
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      accountNumber: accountNumber,
      openTime: openTime,
      closeTime: closeTime,
      branchAmount: branchAmount,
      branchAddress: branchAddress,
      merchantId: merchantId,
      merchantName: merchantName,
      manager: manager.toModel(),
    );
  }
}
