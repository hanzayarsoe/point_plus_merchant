import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_message_model.freezed.dart';
part 'remote_message_model.g.dart';

@freezed
abstract class RemoteMessageModel with _$RemoteMessageModel {
  const factory RemoteMessageModel({
    required String message,
    String? transactionId,
    String? requestId,
  }) = _RemoteMessageModel;

  factory RemoteMessageModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteMessageModelFromJson(json);
}
