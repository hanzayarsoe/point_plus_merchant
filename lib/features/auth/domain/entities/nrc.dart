import 'package:freezed_annotation/freezed_annotation.dart';

part 'nrc.freezed.dart';

@freezed
abstract class Nrc with _$Nrc {
  const factory Nrc({
    required int id,
    required String stateNumber,
    required String township,
    required String citizenType,
    required String code,
  }) = _Nrc;
}
