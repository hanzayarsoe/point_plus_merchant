import 'package:get_it/get_it.dart';
import 'package:merchant/features/home/data/datasources/home_datasource.dart';
import 'package:merchant/features/home/data/datasources/home_datasource_impl.dart';
import 'package:merchant/features/home/data/repositories/home_repository_impl.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';
import 'package:merchant/features/home/domain/usecases/get_request_transaction_usecase.dart';
import 'package:merchant/features/home/domain/usecases/search_customer_by_accout_number_usecase.dart';
import 'package:merchant/features/home/domain/usecases/transfer_point_usecase.dart';
import 'package:merchant/features/home/presentation/bloc/point_transfer_bloc/point_transfer_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/request_transaction_cubit/cubit/request_transaction_cubit.dart';
import 'package:merchant/features/home/presentation/cubits/search_customer_cubit/search_customer_cubit.dart';

class HomeInjection {
  HomeInjection._();
  static void init(GetIt sl) {
    sl
      ..registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl(sl()))
      ..registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()))
      ..registerLazySingleton(() => TransferPointUsecase(sl()))
      ..registerLazySingleton(() => SearchCustomerByAccoutNumberUsecase(sl()))
      ..registerLazySingleton(() => GetRequestTransactionUsecase(sl()))
      ..registerLazySingleton(() => PointTransferBloc(sl()))
      ..registerLazySingleton(() => SearchCustomerCubit(sl()))
      ..registerLazySingleton(() => RequestTransactionCubit());
  }
}
