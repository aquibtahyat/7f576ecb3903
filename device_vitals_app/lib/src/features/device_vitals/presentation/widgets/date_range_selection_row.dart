import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:flutter/material.dart';

class DateRangeRow extends StatelessWidget {
  const DateRangeRow({super.key, required this.value, this.onDateRangeChanged});
  final DateRange value;

  final void Function(DateRange dateRange)? onDateRangeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Analytics',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        DropdownButton<DateRange>(
          value: value,
          underline: Container(),
          items: DateRange.values.map((range) {
            return DropdownMenuItem<DateRange>(
              value: range,
              child: Text(range.label),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onDateRangeChanged?.call(newValue);
            }
          },
        ),
      ],
    );
  }
}
