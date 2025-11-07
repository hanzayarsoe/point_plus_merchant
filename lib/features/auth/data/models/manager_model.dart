import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';
import 'nrc_model.dart';

part 'manager_model.freezed.dart';
part 'manager_model.g.dart';

@freezed
abstract class ManagerModel with _$ManagerModel {
  const factory ManagerModel({
    required int id,
    required String name,
    required String? email,
    required String? phoneNumber,
    required String? gender,
    required String? dob,
    required String? profileUrl,
    String? address,
    required NrcModel nrc,
  }) = _ManagerModel;

  factory ManagerModel.fromJson(Map<String, dynamic> json) =>
      _$ManagerModelFromJson(json);
}

extension ManagerModelX on ManagerModel {
  Manager toEntity() {
    return Manager(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      dob: dob,
      nrc: nrc.toEntity(),
      profileUrl: profileUrl,
      address: address,
    );
  }
}

extension ManagerX on Manager {
  ManagerModel toModel() {
    return ManagerModel(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      dob: dob,
      nrc: nrc.toModel(),
      profileUrl: profileUrl,
      address: address,
    );
  }
}
