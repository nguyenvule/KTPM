import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/date_picker/custom_date_picker.dart';
import 'package:moneynest/core/components/form_fields/custom_select_field.dart';
import 'package:moneynest/core/extensions/date_time_extension.dart';
import 'package:moneynest/features/budget/presentation/riverpod/date_picker_provider.dart';

class BudgetDateRangePicker extends HookConsumerWidget {
  const BudgetDateRangePicker({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedDate = ref.watch(datePickerProvider);
    final selectedDateNotifier = ref.read(datePickerProvider.notifier);
    final dateFieldController = useTextEditingController();

    return CustomSelectField(
      controller: dateFieldController,
      label: 'Set a date range',
      hint: '12 Nov 2024 - 12 Nov 2026',
      prefixIcon: HugeIcons.strokeRoundedCalendar01,
      isRequired: true,
      onTap: () async {
        final dateRange = await CustomDatePicker.selectDateRange(
          context,
          selectedDate,
          lastDate: DateTime.now().add(const Duration(days: 3 * 365)),
        );

        if (dateRange != null) {
          selectedDateNotifier.state = dateRange;
          dateFieldController.text =
              '${dateRange.first!.toDayShortMonthYear()} - ${dateRange.last!.toDayShortMonthYear()}';
        }
      },
    );
  }
}
