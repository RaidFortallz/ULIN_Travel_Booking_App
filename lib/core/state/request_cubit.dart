import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulin/core/error/failure.dart';

enum RequestStatus { initial, loading, success, failure }

class RequestState<T> extends Equatable {
  final RequestStatus status;
  final String? message;
  final Map<String, String> fieldErrors;
  final T? data;

  const RequestState({
    this.status = RequestStatus.initial,
    this.message,
    this.fieldErrors = const {},
    this.data,
  });

  bool get isLoading => status == RequestStatus.loading;

  @override
  List<Object?> get props => [status, message, fieldErrors, data];
}

abstract class RequestCubit<T> extends Cubit<RequestState<T>> {
  RequestCubit() : super(RequestState<T>());

  Future<void> run(Future<T?> Function() action) async {
    if (state.isLoading) return;

    emit(RequestState<T>(status: RequestStatus.loading));

    try {
      final result = await action();
      emit(RequestState<T>(status: RequestStatus.success, data: result));
    } on Failure catch (f) {
      emit(
        RequestState<T>(
          status: RequestStatus.failure,
          message: f.message,
          fieldErrors: f.fieldErrors,
        ),
      );
    }
  }
}
