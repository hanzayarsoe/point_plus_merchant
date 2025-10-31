import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

@freezed
abstract class CustomerModel with _$CustomerModel {
  const factory CustomerModel({
    required int id,
    required String name,
    required String? email,
    required String? phoneNumber,
    required String accountNumber,
    required String? profileUrl,
    required String? gender,
    required int? pointBalance,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
}

extension CustomerModelX on CustomerModel {
  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      accountNumber: accountNumber,
      profileUrl: profileUrl,
      gender: gender,
      pointBalance: pointBalance,
    );
  }
}
