import 'package:bloc/bloc.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/storage/secure_storage.dart';
import 'package:merchant/core/storage/user_preference.dart';
import 'package:merchant/features/profile/domain/usecases/register_token_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/unregister_token_usecase.dart';

class NotiCubit extends Cubit<bool> {
  final DioHelper dioHelper;
  final UserPreference userPreference;
  final RegisterTokenUsecase registerTokenUsecase;
  final UnregisterTokenUsecase unregisterTokenUsecase;
  NotiCubit(
    this.dioHelper,
    this.userPreference,
    this.registerTokenUsecase,
    this.unregisterTokenUsecase,
  ) : super(true);

  Future<bool> loadNoti() async {
    final isEnabled = await userPreference.areNotiEnabled();
    emit(isEnabled);
    return isEnabled;
  }

  Future<void> registerToken(String token) async {
    await registerTokenUsecase.call(token).run();
  }

  Future<void> unregisterToken(String token) async {
    await unregisterTokenUsecase.call(token).run();
  }

  Future<void> toggleNotifications(bool enable) async {
    await userPreference.setNotiEnabled(enable);
    emit(enable);
    try {
      final String? token = await sl<SecureStorage>().getFcmToken();
      if (enable) {
        if (token != null && token.isNotEmpty) await registerToken(token);
      } else {
        if (token != null && token.isNotEmpty) await unregisterToken(token);
      }
    } catch (e) {
      emit(state);
    }
  }
}
