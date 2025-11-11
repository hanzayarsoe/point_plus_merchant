import 'package:get_it/get_it.dart';
import 'package:merchant/features/store/data/datasources/store_datasource.dart';
import 'package:merchant/features/store/data/datasources/store_datasource_impl.dart';
import 'package:merchant/features/store/data/repositories/store_repository_impl.dart';
import 'package:merchant/features/store/domain/repositories/store_repository.dart';
import 'package:merchant/features/store/domain/usecases/get_items_usecase.dart';
import 'package:merchant/features/store/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:merchant/features/store/presentation/bloc/store_bloc/store_bloc.dart';

class StoreInjection {
  StoreInjection._();

  static void init(GetIt sl) {
    sl
      ..registerLazySingleton<StoreDatasource>(() => StoreDatasourceImpl(sl()))
      ..registerLazySingleton<StoreRepository>(() => StoreRepositoryImpl(sl()))
      ..registerLazySingleton(() => GetItemsUsecase(sl()))
      ..registerLazySingleton(() => StoreBloc(sl()))
      ..registerLazySingleton(() => ItemBloc(sl()));
  }
}
