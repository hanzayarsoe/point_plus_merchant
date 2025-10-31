import 'package:freezed_annotation/freezed_annotation.dart';
import 'nrc.dart';

part 'manager.freezed.dart';

@freezed
abstract class Manager with _$Manager {
  const factory Manager({
    required int id,
    required String name,
    required String? email,
    required String? phoneNumber,
    required String? gender,
    required String? dob,
    required Nrc nrc,
  }) = _Manager;
}
