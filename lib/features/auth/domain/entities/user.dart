import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int userId,
    required String name,
    String? email,
    String? phoneNumber,
    required String accountNumber,
    required int pointsBalance,
    String? gender,
  }) = _User;
}
