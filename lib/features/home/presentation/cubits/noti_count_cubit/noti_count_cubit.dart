import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/usecases/get_unread_count_usecase.dart';
import 'package:merchant/features/home/domain/usecases/mark_as_read_noti_usecase.dart';

part 'noti_count_state.dart';
part 'noti_count_cubit.freezed.dart';

class NotiCountCubit extends Cubit<NotiCountState> {
  final GetUnreadCountUsecase getUnreadCountUsecase;
  final MarkAsReadNotiUsecase markAsReadNotiUsecase;
  NotiCountCubit(this.getUnreadCountUsecase, this.markAsReadNotiUsecase)
    : super(const NotiCountState.initial());
  Future<void> getUnreadCount() async {
    emit(const NotiCountState.loading());
    final result = await getUnreadCountUsecase.call().run();

    result.fold(
      (failure) => emit(NotiCountState.error(failure)),
      (count) => emit(NotiCountState.loaded(count)),
    );
  }

  void decrementCount() {
    state.mapOrNull(
      loaded: (currentState) {
        final currentCount = currentState.count;
        if (currentCount > 0) {
          emit(currentState.copyWith(count: currentCount - 1));
        }
      },
    );
  }

  Future<void> markAsRead(String notiId) async {
    final currentCount = state.maybeWhen(
      loaded: (count) => count,
      orElse: () => null,
    );
    if (currentCount == null) return;
    final result = await markAsReadNotiUsecase.call(notiId).run();

    result.fold((failure) {}, (_) {
      if (currentCount > 0) {
        emit(NotiCountState.loaded(currentCount - 1));
      }
    });
  }
}
