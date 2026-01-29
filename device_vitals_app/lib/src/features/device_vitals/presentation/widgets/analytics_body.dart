import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_analytics/get_analytics_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_analytics/get_analytics_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/battery_level_analytics.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/data_range_selector.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        elevation: 1,
        centerTitle: true,
        actions: [
          BlocBuilder<GetAnalyticsCubit, GetAnalyticsState>(
            builder: (context, state) {
              if (state is GetAnalyticsLoading) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _getAnalytics(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<GetAnalyticsCubit, GetAnalyticsState>(
          listenWhen: (previous, current) =>
              current is GetAnalyticsFailure &&
              previous is! GetAnalyticsFailure,
          listener: (context, state) {
            if (state is GetAnalyticsFailure) {
              context.showSnackBar(state.message);
            }
          },
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is GetAnalyticsLoading) {
              return const LoadingWidget();
            } else if (state is GetAnalyticsSuccess) {
              return Column(
                children: [
                  DateRangeSelector(
                    value: state.dateRange,
                    onDateRangeChanged: (dateRange) {
                      _getAnalytics(dateRange: dateRange);
                    },
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _getAnalytics(),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ThermalStateAnalytics(analytics: state.analytics),
                            BatteryLevelAnalytics(analytics: state.analytics),
                            MemoryUsageAnalytics(analytics: state.analytics),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const CenterMessageWidget();
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
