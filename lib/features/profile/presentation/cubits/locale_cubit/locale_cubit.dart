import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/profile/domain/usecases/change_locale_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/load_locale.dart';

part 'locale_state.dart';
part 'locale_cubit.freezed.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final LoadLocaleUseCase loadLocaleUseCase;
  final ChangeLocaleUseCase changeLocaleUseCase;
  LocaleCubit(this.loadLocaleUseCase, this.changeLocaleUseCase)
    : super(LocaleState.initial());

  Future<void> loadInitialLocale() async {
    final localeCode = await loadLocaleUseCase.call();
    emit(state.copyWith(locale: Locale(localeCode)));
  }

  Future<void> changeLocale(Locale newLocale) async {
    await changeLocaleUseCase.call(newLocale);
    emit(state.copyWith(locale: newLocale));
  }
}
