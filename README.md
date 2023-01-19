# delayed_future [![pub version][pub-version-img]][pub-version-url]

⏳ A Dart extension that allows to delay your Futures.

## Why?

Sometimes it makes sense to delay your futures. For example, if you're making an API call and showing a loader. The response might come too quick fast.

By making sure that the execution will run for at least a little, like 350 ms, we'll make the loader more noticeable and the UX more convenient.

## How to use

### Install the package

Add the dependency to **pubspec.yaml**:

```
dependencies:
  delayed_future: ^1.0.0
```

### Use it!

```dart
// This will use default values from the config.
await anyFuture().apiDelayed();

await anotherFuture().apiDelayed(
    // Custom duration!
    duration: const Duration(milliseconds: 150),

    // If throwImmediatelyOnError is true and `anotherFuture` throws an exception,
    // the execution will fail immediately.
    // Otherwise it will run for at least the given time.
    throwImmediatelyOnError: true,
);
```

#### Set the default values

You can change the default values of `duration` and `throwImmediatelyOnError` like this:

```dart
DelayedFuture.duration = const Duration(milliseconds: 500);
DelayedFuture.throwImmediatelyOnError = true;
```

<!-- References -->
[pub-version-img]: https://img.shields.io/badge/pub-v1.0.0-0175c2?logo=dart
[pub-version-url]: https://pub.dev/packages/delayed_future