import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class SearchCustomerByAccoutNumberUsecase {
  final HomeRepository homeRepository;
  SearchCustomerByAccoutNumberUsecase(this.homeRepository);
  TaskEither<Failure, CustomerEntity> call(String accountNumber) {
    return homeRepository.searchCustomer(accountNumber);
  }
}
