import 'package:bloc/bloc.dart';
import 'package:merchant/core/storage/user_preference.dart';

class NotiCubit extends Cubit<bool> {
  final UserPreference userPreference;
  NotiCubit(this.userPreference) : super(true);

  Future<void> loadNoti() async {
    final isEnabled = await userPreference.areNotiEnabled();
    emit(isEnabled);
  }

  Future<void> setNoti(bool isEnabled) async {
    await userPreference.setNotiEnabled(isEnabled);
    emit(isEnabled);
  }
}
