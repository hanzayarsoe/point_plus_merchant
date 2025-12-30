import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/entities/device_entity.dart';
import 'package:merchant/features/profile/domain/usecases/get_devices_usecase.dart';

part 'devices_event.dart';
part 'devices_state.dart';
part 'devices_bloc.freezed.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final GetDevicesUsecase getDevicesUsecase;
  DevicesBloc(this.getDevicesUsecase) : super(_Initial()) {
    on<_FetchDevices>(_onFetchDevices);
  }

  Future<void> _onFetchDevices(
    _FetchDevices event,
    Emitter<DevicesState> emit,
  ) async {
    emit(DevicesState.loading());
    final result = await getDevicesUsecase.call().run();
    result.fold(
      (failure) => emit(DevicesState.failed(failure)),
      (devices) => emit(DevicesState.loaded(devices)),
    );
  }
}
