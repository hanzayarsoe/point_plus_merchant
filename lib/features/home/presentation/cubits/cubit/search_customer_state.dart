part of 'search_customer_cubit.dart';

@freezed
class SearchCustomerState with _$SearchCustomerState {
  const factory SearchCustomerState.initial() = _Initial;
  const factory SearchCustomerState.loading() = _Loading;
  const factory SearchCustomerState.loadedCustomer(CustomerEntity customer) =
      _LoadedCustomer;
  const factory SearchCustomerState.failed(Failure failure) = _Failed;
}
