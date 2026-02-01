import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:equatable/equatable.dart';

sealed class GetMemoryUsageState extends Equatable {
  const GetMemoryUsageState();
}

final class GetMemoryUsageInitial extends GetMemoryUsageState {
  const GetMemoryUsageInitial();

  @override
  List<Object?> get props => [];
}

final class GetMemoryUsageLoading extends GetMemoryUsageState {
  const GetMemoryUsageLoading();
  @override
  List<Object?> get props => [];
}

final class GetMemoryUsageSuccess extends GetMemoryUsageState {
  final MemoryUsageEntity memoryUsage;
  const GetMemoryUsageSuccess(this.memoryUsage);

  @override
  List<Object?> get props => [memoryUsage];
}

final class GetMemoryUsageFailure extends GetMemoryUsageState {
  final String message;
  final bool isLoadAll;
  const GetMemoryUsageFailure(this.message, {this.isLoadAll = false});

  @override
  List<Object?> get props => [message, isLoadAll];
}
