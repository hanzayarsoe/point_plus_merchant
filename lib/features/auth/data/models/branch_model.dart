import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/data/models/manager_model.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';

part 'branch_model.freezed.dart';
part 'branch_model.g.dart';

@freezed
abstract class BranchModel with _$BranchModel {
  const factory BranchModel({
    required int id,
    required String name,
    required String accountNumber,
    String? primaryPhoneNumber,
    String? secondaryPhoneNumber,
    String? email,
    required String? openTime,
    required String? closeTime,
    required int branchAmount,
    required String branchAddress,
    String? about,
    String? profileUrl,
    required int merchantId,
    required String merchantName,
    required ManagerModel manager,
  }) = _BranchModel;

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
}

extension BranchModelX on BranchModel {
  Branch toEntity() {
    return Branch(
      id: id,
      name: name,
      accountNumber: accountNumber,
      primaryPhoneNumber: primaryPhoneNumber,
      secondaryPhoneNumber: secondaryPhoneNumber,
      about: about,
      profileUrl: profileUrl,
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

extension BranchX on Branch {
  BranchModel toModel() {
    return BranchModel(
      id: id,
      name: name,
      accountNumber: accountNumber,
      primaryPhoneNumber: primaryPhoneNumber,
      secondaryPhoneNumber: secondaryPhoneNumber,
      about: about,
      profileUrl: profileUrl,
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
