import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int userId,
    required String name,
    String? email,
    String? phoneNumber,
    required String accountNumber,
    required int pointsBalance,
    String? gender,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() {
    return User(
      userId: userId,
      name: name,
      accountNumber: accountNumber,
      pointsBalance: pointsBalance,
    );
  }
}
