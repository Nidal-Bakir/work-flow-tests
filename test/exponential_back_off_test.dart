import 'dart:math';

import 'package:exponendfasfdsfs/exponential_back_off.dart';
import 'package:test/test.dart';

class TestException implements Exception {
  final dynamic message;

  TestException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "TextException";
    return "TextException: $message";
  }
}

void main() {
  test('attemptCounter should equals maxAttempts', () async {
    // arrange
    final maxAttempts = 3;
    final expo = ExponentialBackOff(
      maxAttempts: maxAttempts,
      interval: Duration(milliseconds: 200),
      maxDelay: Duration(seconds: 10),
      maxRandomizationFactor: 0.15,
    );
    int callCounter = 0;

    // act
    await expo.start(() {
      ++callCounter;
      throw TestException('test throw');
    });

    // assert
    expect(expo.attemptCounter, equals(maxAttempts));
    expect(callCounter, equals(maxAttempts));
  });
}
