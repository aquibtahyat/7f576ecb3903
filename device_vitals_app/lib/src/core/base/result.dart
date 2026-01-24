import 'dart:async';
import 'dart:io';

import 'package:device_vitals_app/src/core/network/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

abstract class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  });
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  when<R>({
    required Function(T data) success,
    required Function(String message) failure,
  }) {
    return success(data);
  }
}

class Failure extends Result<Never> {
  final String message;
  const Failure(this.message);

  factory Failure.mapExceptionToFailure(Object e) {
    if (e is DioException) {
      return Failure(DioErrorHandler.handleError(e));
    }
    if (e is PlatformException) {
      return Failure(
        e.message ??
            'We couldn\'t get the information from your device. Please try again.',
      );
    }
    if (e is MissingPluginException) {
      return Failure(
        e.message ??
            'This feature isn\'t available on your device. Please try again or update the app.',
      );
    }
    if (e is SocketException) {
      return const Failure(
        'You appear to be offline. Please check your internet connection and try again.',
      );
    }
    if (e is TimeoutException) {
      return const Failure(
        'This is taking longer than usual. Please check your connection and try again.',
      );
    }
    if (e is FormatException) {
      return const Failure(
        'We received data we couldn\'t understand. Please try again.',
      );
    }
    if (e is TypeError) {
      return const Failure(
        'Something went wrong while loading. Please try again.',
      );
    }
    return const Failure('Something went wrong. Please try again.');
  }

  @override
  when<R>({
    required Function(Never data) success,
    required Function(String message) failure,
  }) {
    return failure(message);
  }
}
