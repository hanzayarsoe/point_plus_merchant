import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/usecases/request_point_usecase.dart';

part 'point_request_event.dart';
part 'point_request_state.dart';
part 'point_request_bloc.freezed.dart';

class PointRequestBloc extends Bloc<PointRequestEvent, PointRequestState> {
  final RequestPointUsecase requestPointUsecase;
  PointRequestBloc(this.requestPointUsecase) : super(_Initial()) {
    on<_RequestPoint>(_onRequestPoint);
  }

  Future<void> _onRequestPoint(
    _RequestPoint event,
    Emitter<PointRequestState> emit,
  ) async {
    emit(PointRequestState.loading());
    final result = await requestPointUsecase
        .call(points: event.points, type: event.type)
        .run();
    result.fold(
      (failure) => emit(PointRequestState.failed(failure)),
      (_) => emit(PointRequestState.success()),
    );
  }
}
