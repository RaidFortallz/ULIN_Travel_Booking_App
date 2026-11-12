import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulin/core/error/failure.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/auth/domain/repositories/auth_repository.dart';

class EmailVerificationState extends Equatable {
  final RequestStatus sendStatus;
  final RequestStatus verifyStatus;
  final int resendIn;
  final String? message;
  final AppUser? verifiedUser;

  const EmailVerificationState({
    this.sendStatus = RequestStatus.initial,
    this.verifyStatus = RequestStatus.initial,
    this.resendIn = 0,
    this.message,
    this.verifiedUser,
  });

  EmailVerificationState copyWith({
    RequestStatus? sendStatus,
    RequestStatus? verifyStatus,
    int? resendIn,
    String? message,
    bool clearMessage = false,
    AppUser? verifiedUser,
  }) {
    return EmailVerificationState(
      sendStatus: sendStatus ?? this.sendStatus,
      verifyStatus: verifyStatus ?? this.verifyStatus,
      resendIn: resendIn ?? this.resendIn,
      message: clearMessage ? null : (message ?? this.message),
      verifiedUser: verifiedUser ?? this.verifiedUser,
    );
  }

  @override
  List<Object?> get props => [
    sendStatus,
    verifyStatus,
    resendIn,
    message,
    verifiedUser,
  ];
}

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final AuthRepository _repository;
  Timer? _timer;

  EmailVerificationCubit(this._repository)
    : super(const EmailVerificationState());

  Future<void> sendCode() async {
    if (state.resendIn > 0 || state.sendStatus == RequestStatus.loading) {
      return;
    }

    emit(state.copyWith(sendStatus: RequestStatus.loading, clearMessage: true));

    try {
      final resendIn = await _repository.sendVerificationCode();
      emit(
        state.copyWith(sendStatus: RequestStatus.success, resendIn: resendIn),
      );
      _startTimer();
    } on Failure catch (f) {
      emit(
        state.copyWith(sendStatus: RequestStatus.failure, message: f.message),
      );
    }
  }

  Future<void> verify(String code) async {
    if (state.verifyStatus == RequestStatus.loading) return;

    emit(
      state.copyWith(verifyStatus: RequestStatus.loading, clearMessage: true),
    );

    try {
      final user = await _repository.verifyEmail(code);
      emit(
        state.copyWith(verifyStatus: RequestStatus.success, verifiedUser: user),
      );
    } on Failure catch (f) {
      emit(
        state.copyWith(verifyStatus: RequestStatus.failure, message: f.message),
      );
    }
  }

  void _startTimer() async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendIn <= 1) {
        timer.cancel();
        emit(state.copyWith(resendIn: 0));
      } else {
        emit(state.copyWith(resendIn: state.resendIn - 1));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
