import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/point_request_detail_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class GetRequestDetailUsecase {
  final HomeRepository homeRepository;
  GetRequestDetailUsecase(this.homeRepository);
  TaskEither<Failure, PointRequestDetailEntity> call({required int id}) {
    return homeRepository.getRequestDetail(id);
  }
}
