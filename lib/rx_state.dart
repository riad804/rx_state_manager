import 'package:rx_state_manager/rx_state_manager.dart';

abstract class RxStateBase<T> {
  const RxStateBase();

  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) onData,
    required R Function(Failure failure) onError,
  });
}

class RxIdle<T> extends RxStateBase<T> {
  const RxIdle();

  @override
  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) onData,
    required R Function(Failure failure) onError,
  }) {
    return idle();
  }
}

class RxLoading<T> extends RxStateBase<T> {
  const RxLoading();

  @override
  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) onData,
    required R Function(Failure failure) onError,
  }) {
    return loading();
  }
}

class RxData<T> extends RxStateBase<T> {
  final T data;
  const RxData(this.data);

  @override
  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) onData,
    required R Function(Failure failure) onError,
  }) {
    return onData(data);
  }
}

class RxError<T> extends RxStateBase<T> {
  final Failure failure;
  const RxError(this.failure);

  @override
  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) onData,
    required R Function(Failure failure) onError,
  }) {
    return onError(failure);
  }
}
