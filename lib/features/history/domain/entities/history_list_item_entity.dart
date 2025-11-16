import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_list_item_entity.freezed.dart';

@freezed
abstract class HistoryListItemEntity with _$HistoryListItemEntity {
  const factory HistoryListItemEntity.monthHeader({
    required String type,
    required String groupTitle,
    required String inflow,
    required String outflow,
  }) = MonthHeaderItem;

  const factory HistoryListItemEntity.transaction({
    required int id,
    required String date,
    required int amount,
    required String type,
    required String? title,
    required String party,
  }) = TransactionItem;
}

// "items": [
//             {
//                 "outflow": "Outflow: 10200 Pts",
//                 "groupTitle": "November, 2025",
//                 "inflow": "Inflow: 2200 Pts",
//                 "type": "monthHeader"
//             },
//             {
//                 "date": "2025-11-05T02:46:29.590016Z",
//                 "amount": 200,
//                 "id": 89,
//                 "type": "transaction",
//                 "title": "Points Received",
//                 "party": "han"
//             },
//             {
//                 "date": "2025-11-05T02:46:29.590016Z",
//                 "amount": 200,
//                 "id": 89,
//                 "type": "transaction",
//                 "title": "Points Received",
//                 "party": "han"
//             },
//             {
//                 "date": "2025-11-05T02:46:29.590016Z",
//                 "amount": 200,
//                 "id": 89,
//                 "type": "transaction",
//                 "title": "Points Received",
//                 "party": "han"
//             },

// ],
