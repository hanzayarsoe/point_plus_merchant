import 'package:flutter/widgets.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class ChangeLocaleUseCase {
  final ProfileRepository profileRepository;
  ChangeLocaleUseCase(this.profileRepository);

  Future<void> call(Locale locale) async {
    return profileRepository.changeLocale(locale);
  }
}
