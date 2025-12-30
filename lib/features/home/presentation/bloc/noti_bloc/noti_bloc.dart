import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/features/home/domain/entities/noti_entity.dart';
import 'package:merchant/features/home/domain/usecases/get_notifs_usecase.dart';

part 'noti_event.dart';
part 'noti_bloc.freezed.dart';

class NotiBloc extends Bloc<NotiEvent, PagingState<int, NotiEntity>> {
  final GetNotifsUsecase getNotifsUsecase;
  static const int _pageSize = 10;
  NotiBloc(this.getNotifsUsecase)
    : super(
        PagingState(
          pages: null,
          keys: null,
          hasNextPage: true,
          isLoading: false,
        ),
      ) {
    on<_getNotifs>(_onGetNotifs);
    on<_MarkAsRead>(_onMarkAsRead);
    on<_Reset>(_onReset);
  }

  void _onReset(_Reset event, Emitter<PagingState<int, NotiEntity>> emit) {
    emit(
      PagingState(pages: null, keys: null, hasNextPage: true, isLoading: false),
    );
  }

  void _onMarkAsRead(
    _MarkAsRead event,
    Emitter<PagingState<int, NotiEntity>> emit,
  ) {
    if (state.pages == null) return;

    final newPages = state.pages!.map((page) {
      return page.map((item) {
        return item.when(
          dateHeader: (groupTitle) =>
              NotiEntity.dateHeader(groupTitle: groupTitle),
          notification:
              (id, title, message, notificationType, read, createdAt, data) {
                if (id.toString() == event.id) {
                  return NotiEntity.notification(
                    id: id,
                    title: title,
                    message: message,
                    notificationType: notificationType,
                    read: true,
                    createdAt: createdAt,
                    data: data,
                  );
                }
                return item;
              },
        );
      }).toList();
    }).toList();

    emit(state.copyWith(pages: newPages));
  }

  Future<void> _onGetNotifs(
    _getNotifs event,
    Emitter<PagingState<int, NotiEntity>> emit,
  ) async {
    final currentState = state;
    if (currentState.isLoading || !currentState.hasNextPage) {
      return;
    }
    emit(currentState.copyWith(isLoading: true));
    try {
      final pageKeys = currentState.keys?.length ?? 0;
      final result = await getNotifsUsecase
          .call(page: pageKeys, limit: _pageSize)
          .run();
      result.fold(
        (failure) =>
            emit(currentState.copyWith(isLoading: false, error: failure)),
        (notifs) {
          final isLastPage = notifs.length < _pageSize;
          emit(
            currentState.copyWith(
              pages: [...?currentState.pages, notifs],
              keys: [...?currentState.keys, pageKeys],
              hasNextPage: !isLastPage,
              isLoading: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(currentState.copyWith(error: e, isLoading: false));
    }
  }
}
