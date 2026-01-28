import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:equatable/equatable.dart';

sealed class GetAnalyticsState extends Equatable {
  const GetAnalyticsState();
}

class GetAnalyticsInitial extends GetAnalyticsState {
  const GetAnalyticsInitial({this.dateRange = DateRange.last24Hours});

  final DateRange dateRange;

  @override
  List<Object?> get props => [dateRange];
}

class GetAnalyticsLoading extends GetAnalyticsState {
  const GetAnalyticsLoading({required this.dateRange});

  final DateRange dateRange;

  @override
  List<Object?> get props => [dateRange];
}

class GetAnalyticsSuccess extends GetAnalyticsState {
  const GetAnalyticsSuccess({required this.analytics, required this.dateRange});

  final DeviceVitalsAnalyticsEntity analytics;
  final DateRange dateRange;

  @override
  List<Object?> get props => [analytics, dateRange];
}

class GetAnalyticsFailure extends GetAnalyticsState {
  const GetAnalyticsFailure({required this.message, required this.dateRange});

  final String message;
  final DateRange dateRange;

  @override
  List<Object?> get props => [message, dateRange];
}
