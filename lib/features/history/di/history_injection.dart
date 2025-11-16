import 'package:get_it/get_it.dart';
import 'package:merchant/features/history/data/datasources/history_datasource.dart';
import 'package:merchant/features/history/data/datasources/history_datasource_impl.dart';
import 'package:merchant/features/history/data/repositories/history_repository_impl.dart';
import 'package:merchant/features/history/domain/repositories/history_repository.dart';
import 'package:merchant/features/history/domain/usecases/get_histories_usecase.dart';
import 'package:merchant/features/history/domain/usecases/get_transaction_detail_usecase.dart';
import 'package:merchant/features/history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:merchant/features/history/presentation/bloc/transaction_detail_bloc/transaction_detail_bloc.dart';
import 'package:merchant/features/history/presentation/cubit/cubit/history_filter_cubit.dart';

class HistoryInjection {
  HistoryInjection._();
  static void init(GetIt sl) {
    sl
      ..registerLazySingleton<HistoryDatasource>(
        () => HistoryDatasourceImpl(sl()),
      )
      ..registerLazySingleton<HistoryRepository>(
        () => HistoryRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => GetHistoriesUsecase(sl()))
      ..registerLazySingleton(() => GetTransactionDetailUsecase(sl()))
      ..registerLazySingleton(() => HistoryFilterCubit())
      ..registerLazySingleton(() => HistoryBloc(sl()))
      ..registerLazySingleton(() => TransactionDetailBloc(sl()));
  }
}
