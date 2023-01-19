/// A Dart extension that allows to delay your Futures.
///
/// - [pub.dev](https://pub.dev/packages/delayed_future);
/// - [GitHub]( https://github.com/nivisi/delayed_future).
///
/// ### Example
///
/// ```dart
/// final apiCall = await fetchMyData().delayed();
/// ```
library delayed_future;

import 'dart:async';

/// Config of delayed_future.
/// Set [duration] to define the default delay duration.
class DelayedFuture {
  DelayedFuture._();

  /// Default duration of the [DelayedFutureExtension.delayed] extension.
  static Duration duration = const Duration(milliseconds: 350);
}

extension DelayedFutureExtension<T> on Future<T> {
  /// Delays your future to run for at least [duration] or, if not provided, [DelayedFuture.duration].
  ///
  /// ### Example
  ///
  /// ```dart
  /// final apiCall = await fetchMyData().delayed();
  /// ```
  ///
  /// ### Params
  ///
  /// - [duration] is the desired delay. If not provided,
  /// [DelayedFuture.duration] is used. You can change the default duration value
  /// by setting [DelayedFuture.duration].
  /// - [exitImmediatelyOnError] indicates whether not to wait until the delay expires
  /// in case the main future throws an error.
  Future<T> delayed({
    Duration? duration,
    bool exitImmediatelyOnError = false,
  }) async {
    final results = await Future.wait(
      [
        this,
        Future.delayed(duration ?? DelayedFuture.duration),
      ],
      eagerError: exitImmediatelyOnError,
    );

    delayed(
      exitImmediatelyOnError: true,
    );

    return results.first;
  }
}
