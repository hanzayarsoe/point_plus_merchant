import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/network/domain/network_info.dart';

part 'connection_state.dart';
part 'connection_cubit.freezed.dart';

class ConnectionCubit extends Cubit<ConnectionState> {
  final Connectivity connectivity;
  final NetworkInfo networkInfo;
  ConnectionCubit(this.connectivity, this.networkInfo)
    : super(ConnectionState.initial()) {
    _monitorConnection();
  }

  Future<void> _monitorConnection() async {
    await _checkInternet();

    connectivity.onConnectivityChanged.listen((_) async {
      await _checkInternet();
    });
  }

  Future<void> _checkInternet() async {
    if (await networkInfo.isConnected) {
      emit(ConnectionState.connected());
    } else {
      emit(ConnectionState.disconnected());
    }
  }
}
