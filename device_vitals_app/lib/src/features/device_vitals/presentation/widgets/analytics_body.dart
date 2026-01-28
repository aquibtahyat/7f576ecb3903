import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_analytics/get_analytics_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_analytics/get_analytics_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/battery_level_analytics.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/date_range_selection_row.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/memory_usage_analytics.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/thermal_state_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsBody extends StatefulWidget {
  const AnalyticsBody({super.key});

  @override
  State<AnalyticsBody> createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody> {
  @override
  void initState() {
    super.initState();
    _getAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getAnalytics,
      child: SafeArea(
        child: BlocConsumer<GetAnalyticsCubit, GetAnalyticsState>(
          listener: (context, state) {
            if (state is GetAnalyticsFailure) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            if (state is GetAnalyticsLoading) {
              return const LoadingWidget();
            } else if (state is GetAnalyticsSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DateRangeRow(
                        value: state.dateRange,
                        onDateRangeChanged: (dateRange) {
                          _getAnalytics(dateRange: dateRange);
                        },
                      ),
                      ThermalStateAnalytics(analytics: state.analytics),
                      const SizedBox(height: 16),
                      BatteryLevelAnalytics(analytics: state.analytics),
                      const SizedBox(height: 16),
                      MemoryUsageAnalytics(analytics: state.analytics),
                    ],
                  ),
                ),
              );
            }

            return CenterMessageWidget();
          },
        ),
      ),
    );
  }

  Future<void> _getAnalytics({
    DateRange dateRange = DateRange.last24Hours,
  }) async {
    await context.read<GetAnalyticsCubit>().getAnalytics(dateRange: dateRange);
  }
}
