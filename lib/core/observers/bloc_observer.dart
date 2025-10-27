import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logMessage('🟢 [BLoC Created] ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logMessage('📥 [Event] ${bloc.runtimeType} -> ${event.runtimeType}');
    _logMessage('   Event Details: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logMessage('🔄 [State Change] ${bloc.runtimeType}');
    _logMessage('   From: ${change.currentState.runtimeType}');
    _logMessage('   To: ${change.nextState.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logMessage('⚡ [Transition] ${bloc.runtimeType}');
    _logMessage('   Event: ${transition.event.runtimeType}');
    _logMessage('   Current: ${transition.currentState}');
    _logMessage('   Next: ${transition.nextState}');
    _logMessage('   ─────────────────────');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logMessage('❌ [Error] ${bloc.runtimeType}');
    _logMessage('   Error: $error');
    if (kDebugMode) {
      _logMessage('   Stack: $stackTrace');
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logMessage('🔴 [BLoC Closed] ${bloc.runtimeType}');
  }

  void _logMessage(String message) {
    // Use multiple logging methods to ensure visibility
    debugPrint(message);
    if (kDebugMode) {
      developer.log(message, name: 'BlocObserver');
    }
  }
}

// Alternative: Simplified observer for troubleshooting
class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('=== BLOC CREATED: ${bloc.runtimeType} ===');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('=== EVENT: ${bloc.runtimeType} -> $event ===');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('=== CHANGE: ${bloc.runtimeType} ===');
    debugPrint('FROM: ${change.currentState}');
    debugPrint('TO: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('=== TRANSITION: ${bloc.runtimeType} ===');
    debugPrint('EVENT: ${transition.event}');
    debugPrint('CURRENT: ${transition.currentState}');
    debugPrint('NEXT: ${transition.nextState}');
    debugPrint('=====================================');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('=== ERROR: ${bloc.runtimeType} -> $error ===');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('=== BLOC CLOSED: ${bloc.runtimeType} ===');
  }
}
