import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';
import 'package:merchant/features/home/domain/usecases/search_customer_by_accout_number_usecase.dart';

part 'search_customer_state.dart';
part 'search_customer_cubit.freezed.dart';

class SearchCustomerCubit extends Cubit<SearchCustomerState> {
  final SearchCustomerByAccoutNumberUsecase searchCustomerByAccoutNumberUsecase;
  SearchCustomerCubit(this.searchCustomerByAccoutNumberUsecase)
    : super(SearchCustomerState.initial());

  Future<void> searchUser(String accountNumber) async {
    emit(SearchCustomerState.loading());
    final result = await searchCustomerByAccoutNumberUsecase
        .call(accountNumber)
        .run();
    result.fold(
      (failure) => emit(SearchCustomerState.failed(failure)),
      (customer) => emit(SearchCustomerState.loadedCustomer(customer)),
    );
  }
}
