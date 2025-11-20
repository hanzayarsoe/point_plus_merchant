import 'package:get_it/get_it.dart';
import 'package:merchant/features/home/data/datasources/home_datasource.dart';
import 'package:merchant/features/home/data/datasources/home_datasource_impl.dart';
import 'package:merchant/features/home/data/repositories/home_repository_impl.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';
import 'package:merchant/features/home/domain/usecases/get_notifs_usecase.dart';
import 'package:merchant/features/home/domain/usecases/get_request_detail_usecase.dart';
import 'package:merchant/features/home/domain/usecases/get_request_histories_usecase.dart';
import 'package:merchant/features/home/domain/usecases/get_request_transaction_usecase.dart';
import 'package:merchant/features/home/domain/usecases/request_point_usecase.dart';
import 'package:merchant/features/home/domain/usecases/search_customer_by_accout_number_usecase.dart';
import 'package:merchant/features/home/domain/usecases/transfer_point_usecase.dart';
import 'package:merchant/features/home/presentation/bloc/noti_bloc/noti_bloc.dart';
import 'package:merchant/features/home/presentation/bloc/request_history_bloc/request_history_bloc.dart';
import 'package:merchant/features/home/presentation/bloc/point_request_bloc/point_request_bloc.dart';
import 'package:merchant/features/home/presentation/bloc/point_transfer_bloc/point_transfer_bloc.dart';
import 'package:merchant/features/home/presentation/bloc/request_transaction_detail_bloc/request_transaction_detail_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/request_filter_cubit/cubit/request_filter_cubit.dart';
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
      ..registerLazySingleton(() => GetRequestHistoriesUsecase(sl()))
      ..registerLazySingleton(() => GetRequestDetailUsecase(sl()))
      ..registerLazySingleton(() => GetNotifsUsecase(sl()))
      ..registerLazySingleton(() => RequestPointUsecase(sl()))
      ..registerLazySingleton(() => PointTransferBloc(sl()))
      ..registerLazySingleton(() => PointRequestBloc(sl()))
      ..registerLazySingleton(() => RequestHistoryBloc(sl()))
      ..registerLazySingleton(() => SearchCustomerCubit(sl()))
      ..registerLazySingleton(() => RequestTransactionDetailBloc(sl()))
      ..registerLazySingleton(() => NotiBloc(sl()))
      ..registerLazySingleton(() => RequestFilterCubit());
  }
}
