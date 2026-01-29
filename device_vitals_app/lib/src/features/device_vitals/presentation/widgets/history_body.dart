import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_history/get_history_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_history/get_history_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/history_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({super.key});

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        elevation: 1,
        centerTitle: true,
        actions: [
          BlocBuilder<GetHistoryCubit, GetHistoryState>(
            builder: (context, state) {
              if (state is GetHistoryLoading) {
                return const SizedBox.shrink();
              }

              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _getHistory,
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getHistory,
        child: SafeArea(
          child: BlocConsumer<GetHistoryCubit, GetHistoryState>(
            listener: (context, state) {
              if (state is GetHistoryFailure) {
                context.showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              if (state is GetHistoryLoading) {
                return const LoadingWidget();
              } else if (state is GetHistorySuccess) {
                final deviceVitalsHistory = state.history;
                if (deviceVitalsHistory.isEmpty) {
                  return CenterMessageWidget();
                }
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: deviceVitalsHistory.length,
                  itemBuilder: (context, index) =>
                      HistoryItemCard(deviceVitals: deviceVitalsHistory[index]),
                );
              }
              return CenterMessageWidget();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getHistory() async {
    await context.read<GetHistoryCubit>().getHistory();
  }
}
