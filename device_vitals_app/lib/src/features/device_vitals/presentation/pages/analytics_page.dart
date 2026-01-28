import 'package:device_vitals_app/src/core/injection/injector.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_analytics/get_analytics_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/analytics_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector.get<GetAnalyticsCubit>(),
      child: AnalyticsBody(),
    );
  }
}
