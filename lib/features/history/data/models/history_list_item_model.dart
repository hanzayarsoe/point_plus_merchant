import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';

part 'history_list_item_model.freezed.dart';
part 'history_list_item_model.g.dart';

@Freezed(unionKey: 'type')
abstract class HistoryListItemModel with _$HistoryListItemModel {
  @FreezedUnionValue('monthHeader')
  const factory HistoryListItemModel.monthHeader({
    required String type,
    required String groupTitle,
    required int inflow,
    required int outflow,
  }) = MonthHeaderItem;

  @FreezedUnionValue('transaction')
  const factory HistoryListItemModel.transaction({
    required int id,
    required String date,
    required int amount,
    required String type,
    required String? title,
    required String party,
  }) = TransactionItem;

  factory HistoryListItemModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryListItemModelFromJson(json);
}

extension HistoryListItemModelX on HistoryListItemModel {
  HistoryListItemEntity toEntity() {
    return when(
      monthHeader: (type, groupTitle, inflow, outflow) {
        return HistoryListItemEntity.monthHeader(
          groupTitle: groupTitle,
          inflow: inflow.toString(),
          outflow: outflow.toString(),
          type: type,
        );
      },
      transaction: (id, date, amount, type, title, party) {
        // We get the properties from the TransactionItem model
        // and use them to create a TransactionEntity
        return HistoryListItemEntity.transaction(
          id: id,
          date: date,
          amount: amount,
          type: type,
          title: title,
          party: party,
        );
      },
    );
  }
}
