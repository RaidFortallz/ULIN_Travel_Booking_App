import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulin/core/error/failure.dart';
import 'package:ulin/core/network/session_expired_notifier.dart';
import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {
  const AuthStarted();
}

class AuthLoginSubmitted extends AuthEvent {
  final String email;
  final String password;
  final bool remember;

  const AuthLoginSubmitted({
    required this.email,
    required this.password,
    required this.remember,
  });

  @override
  List<Object?> get props => [email, password, remember];
}

class AuthGoogleSubmitted extends AuthEvent {
  final bool remember;

  const AuthGoogleSubmitted({this.remember = true});

  @override
  List<Object?> get props => [remember];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthUserUpdated extends AuthEvent {
  final AppUser user;

  const AuthUserUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthSessionExpired extends AuthEvent {
  const AuthSessionExpired();
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AppUser? user;
  final bool isSubmitting;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.isSubmitting = false,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    bool clearUser = false,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, user, isSubmitting, errorMessage];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  late final StreamSubscription<void> _expiredSubcription;

  AuthBloc(this._repository, SessionExpiredNotifier notifier)
    : super(const AuthState()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthGoogleSubmitted>(_onGoogleSubmitted);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthUserUpdated>(_onUserUpdated);
    on<AuthSessionExpired>(_onSessionExpired);

    _expiredSubcription = notifier.stream.listen(
      (_) => add(const AuthSessionExpired()),
    );
  }

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final minimumSplash = Future<void>.delayed(
      const Duration(milliseconds: 1500),
    );

    try {
      final user = await _repository.restoreSession();
      await minimumSplash;

      if (user == null) {
        emit(
          state.copyWith(status: AuthStatus.unauthenticated, clearUser: true),
        );
      } else {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      }
    } on Failure catch (f) {
      await minimumSplash;
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          clearUser: true,
          errorMessage: f.message,
        ),
      );
    }
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final user = await _repository.login(
        email: event.email,
        password: event.password,
        remember: event.remember,
      );
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isSubmitting: false,
        ),
      );
    } on Failure catch (f) {
      emit(state.copyWith(isSubmitting: false, errorMessage: f.message));
    }
  }

  Future<void> _onGoogleSubmitted(
    AuthGoogleSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));

    try {
      final user = await _repository.loginWithGoogle(remember: event.remember);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isSubmitting: false,
        ),
      );
    } on Failure catch (f) {
      if (f.code == 'cancelled') {
        emit(state.copyWith(isSubmitting: false));
      } else {
        emit(state.copyWith(isSubmitting: false, errorMessage: f.message));
      }
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        clearUser: true,
        clearError: true,
      ),
    );
  }

  void _onUserUpdated(AuthUserUpdated event, Emitter<AuthState> emit) {
    if (state.status != AuthStatus.authenticated) return;
    emit(state.copyWith(user: event.user));
  }

  Future<void> _onSessionExpired(
    AuthSessionExpired event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status != AuthStatus.authenticated) return;

    await _repository.clearLocalSession();
    emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
  }

  @override
  Future<void> close() {
    _expiredSubcription.cancel();
    return super.close();
  }
}
