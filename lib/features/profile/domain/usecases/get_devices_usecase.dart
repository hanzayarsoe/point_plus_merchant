import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/entities/device_entity.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class GetDevicesUsecase {
  final ProfileRepository profileRepository;
  GetDevicesUsecase(this.profileRepository);
  TaskEither<Failure, List<DeviceEntity>> call() {
    return profileRepository.getDevices();
  }
}
