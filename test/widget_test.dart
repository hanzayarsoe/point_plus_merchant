import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/router/app_router.dart';
import 'package:merchant/core/storage/secure_storage.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/history/presentation/cubit/cubit/history_filter_cubit.dart';
import 'package:merchant/features/home/presentation/cubits/noti_count_cubit/noti_count_cubit.dart';
import 'package:merchant/features/home/presentation/cubits/request_filter_cubit/cubit/request_filter_cubit.dart';
import 'package:merchant/features/profile/presentation/bloc/branch_bloc/branch_bloc.dart';
import 'package:merchant/features/profile/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:merchant/features/profile/presentation/cubits/noti_cubit/noti_cubit.dart';
import 'package:merchant/main.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRouter extends Mock implements AppRouter {}

class MockAuthBloc extends Mock implements AuthBloc {}

class MockBranchBloc extends Mock implements BranchBloc {}

class MockNotiCubit extends Mock implements NotiCubit {}

class MockLocaleCubit extends Mock implements LocaleCubit {}

class MockNotiCountCubit extends Mock implements NotiCountCubit {}

class MockHistoryFilterCubit extends Mock implements HistoryFilterCubit {}

class MockRequestFilterCubit extends Mock implements RequestFilterCubit {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  final sl = GetIt.instance;
  late MockAuthBloc mockAuthBloc;
  late MockBranchBloc mockBranchBloc;
  late MockNotiCubit mockNotiCubit;
  late MockLocaleCubit mockLocaleCubit;
  late MockNotiCountCubit mockNotiCountCubit;
  late MockHistoryFilterCubit mockHistoryFilterCubit;
  late MockRequestFilterCubit mockRequestFilterCubit;
  late MockAppRouter mockAppRouter;

  setUpAll(() {
    registerFallbackValue(const AuthEvent.checkAuthStatus());
    registerFallbackValue(const BranchEvent.getBranchInfo());
    registerFallbackValue(const AuthState.initial());
    registerFallbackValue(const BranchState.initial());
    registerFallbackValue(const LocaleState(locale: Locale('en')));
    registerFallbackValue(const HistoryFilterState());
    registerFallbackValue(const RequestFilterState());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockBranchBloc = MockBranchBloc();
    mockNotiCubit = MockNotiCubit();
    mockLocaleCubit = MockLocaleCubit();
    mockNotiCountCubit = MockNotiCountCubit();
    mockHistoryFilterCubit = MockHistoryFilterCubit();
    mockRequestFilterCubit = MockRequestFilterCubit();
    mockAppRouter = MockAppRouter();

    sl.registerLazySingleton<AuthBloc>(() => mockAuthBloc);
    sl.registerLazySingleton<BranchBloc>(() => mockBranchBloc);
    sl.registerLazySingleton<NotiCubit>(() => mockNotiCubit);
    sl.registerLazySingleton<LocaleCubit>(() => mockLocaleCubit);
    sl.registerLazySingleton<NotiCountCubit>(() => mockNotiCountCubit);
    sl.registerLazySingleton<HistoryFilterCubit>(() => mockHistoryFilterCubit);
    sl.registerLazySingleton<RequestFilterCubit>(() => mockRequestFilterCubit);
    sl.registerLazySingleton<AppRouter>(() => mockAppRouter);
    sl.registerLazySingleton<SecureStorage>(() => MockSecureStorage());

    when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());
    when(
      () => mockAuthBloc.stream,
    ).thenAnswer((_) => Stream.value(const AuthState.initial()));
    when(() => mockAuthBloc.close()).thenAnswer((_) async {});
    when(() => mockAuthBloc.add(any())).thenReturn(null);

    when(() => mockBranchBloc.state).thenReturn(const BranchState.initial());
    when(
      () => mockBranchBloc.stream,
    ).thenAnswer((_) => Stream.value(const BranchState.initial()));
    when(() => mockBranchBloc.close()).thenAnswer((_) async {});
    when(() => mockBranchBloc.add(any())).thenReturn(null);

    when(
      () => mockLocaleCubit.state,
    ).thenReturn(const LocaleState(locale: Locale('en')));
    when(
      () => mockLocaleCubit.stream,
    ).thenAnswer((_) => Stream.value(const LocaleState(locale: Locale('en'))));
    when(() => mockLocaleCubit.close()).thenAnswer((_) async {});
    when(() => mockLocaleCubit.loadInitialLocale()).thenAnswer((_) async {});

    when(() => mockNotiCubit.state).thenReturn(true);
    when(() => mockNotiCubit.stream).thenAnswer((_) => Stream.value(true));
    when(() => mockNotiCubit.close()).thenAnswer((_) async {});
    when(() => mockNotiCubit.loadNoti()).thenAnswer((_) async => true);

    when(
      () => mockNotiCountCubit.state,
    ).thenReturn(const NotiCountState.loaded(0));
    when(
      () => mockNotiCountCubit.stream,
    ).thenAnswer((_) => Stream.value(const NotiCountState.loaded(0)));
    when(() => mockNotiCountCubit.close()).thenAnswer((_) async {});
    when(() => mockNotiCountCubit.getUnreadCount()).thenAnswer((_) async {});

    when(
      () => mockHistoryFilterCubit.state,
    ).thenReturn(const HistoryFilterState());
    when(
      () => mockHistoryFilterCubit.stream,
    ).thenAnswer((_) => Stream.value(const HistoryFilterState()));
    when(() => mockHistoryFilterCubit.close()).thenAnswer((_) async {});

    when(
      () => mockRequestFilterCubit.state,
    ).thenReturn(const RequestFilterState());
    when(
      () => mockRequestFilterCubit.stream,
    ).thenAnswer((_) => Stream.value(const RequestFilterState()));
    when(() => mockRequestFilterCubit.close()).thenAnswer((_) async {});

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('Home')),
        ),
      ],
    );
    when(() => mockAppRouter.router).thenReturn(router);
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('MyApp renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}
