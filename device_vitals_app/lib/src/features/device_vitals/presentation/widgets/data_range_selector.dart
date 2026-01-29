import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:flutter/material.dart';

class DateRangeSelector extends StatelessWidget {
  const DateRangeSelector({
    super.key,
    required this.value,
    this.onDateRangeChanged,
  });
  final DateRange value;

  final void Function(DateRange dateRange)? onDateRangeChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<DateRange>(
              initialValue: value,
              items: DateRange.values.map((range) {
                return DropdownMenuItem<DateRange>(
                  value: range,
                  child: Text(
                    range.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  onDateRangeChanged?.call(newValue);
                }
              },
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
