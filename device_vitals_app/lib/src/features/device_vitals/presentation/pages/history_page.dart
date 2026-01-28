import 'package:device_vitals_app/src/core/injection/injector.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_history/get_history_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/history_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector.get<GetHistoryCubit>(),
      child: HistoryBody(),
    );
  }
}
