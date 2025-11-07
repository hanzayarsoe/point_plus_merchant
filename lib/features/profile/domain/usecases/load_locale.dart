import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class LoadLocaleUseCase {
  final ProfileRepository profileRepository;
  LoadLocaleUseCase(this.profileRepository);

  Future<String> call() async {
    return profileRepository.loadLocale();
  }
}
