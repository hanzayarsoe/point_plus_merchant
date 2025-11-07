import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/auth/domain/entities/nrc.dart';

part 'nrc_model.freezed.dart';
part 'nrc_model.g.dart';

@freezed
abstract class NrcModel with _$NrcModel {
  const factory NrcModel({
    required int id,
    required String stateNumber,
    required String township,
    required String citizenType,
    required String code,
  }) = _NrcModel;

  factory NrcModel.fromJson(Map<String, dynamic> json) =>
      _$NrcModelFromJson(json);
}

extension NrcModelX on NrcModel {
  Nrc toEntity() {
    return Nrc(
      id: id,
      stateNumber: stateNumber,
      township: township,
      citizenType: citizenType,
      code: code,
    );
  }
}

extension NrcX on Nrc {
  NrcModel toModel() {
    return NrcModel(
      id: id,
      stateNumber: stateNumber,
      township: township,
      citizenType: citizenType,
      code: code,
    );
  }
}
