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

  /// Default duration of the [DelayedFutureExtension.delayResult] extension.
  static Duration duration = const Duration(milliseconds: 350);

  /// Default config of [throwImmediatelyOnError].
  /// Indicates whether to throw the exception immediately or to delay throwing.
  static bool throwImmediatelyOnError = false;
}

extension DelayedFutureExtension<T> on Future<T> {
  /// Delays your future to run for at least [duration] or, if not provided, [DelayedFuture.duration].
  ///
  /// ### Params
  ///
  /// - [duration] is the desired delay. If not provided,
  /// [DelayedFuture.duration] is used. You can change the default duration value
  /// by setting [DelayedFuture.duration].
  /// - [throwImmediatelyOnError] indicates whether not to wait until the delay expires
  /// in case the main future throws an error.
  ///
  /// ### Watch out!
  ///
  /// This methods delays the _result_ of the execution.
  /// The future itself *will* be executed immediately.
  ///
  /// That means, if the future changes the state of the app in any way **during execution**,
  /// this change **won't** be delayed.
  ///
  /// ### Example
  ///
  /// ```dart
  /// // This will work as expected. We'll get the data after the delay.
  /// final apiCall = await fetchMyData().delayed();
  /// ```
  ///
  /// But let's look at the following example:
  ///
  /// ```dart
  /// Future<void> makePageCyan() async {
  ///   // Let's pretend it does something meaningful here ...
  ///
  ///   if (mounted) {
  ///     setState(() {
  ///       pageColor = Colors.cyan;
  ///     });
  ///   }
  /// }
  ///
  /// ...
  ///
  /// await makePageBlue().delayed();
  /// // This 👆 will make the page blue without any delay
  /// // because the future itself will be executed immediately.
  /// ```
  ///
  /// Consider refactoring it to this:
  ///
  /// ```dart
  /// await Future.delayed(const Duration(milliseconds: 300));
  /// await makePageBlue();
  /// ```
  Future<T> delayResult({
    Duration? duration,
    bool? throwImmediatelyOnError,
  }) async {
    final results = await Future.wait(
      [
        this,
        Future.delayed(duration ?? DelayedFuture.duration),
      ],
      eagerError:
          throwImmediatelyOnError ?? DelayedFuture.throwImmediatelyOnError,
    );

    return results.first;
  }
}
