import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/form_fields/custom_text_field.dart';

class TransactionNotesField extends HookConsumerWidget {
  final TextEditingController controller;

  const TransactionNotesField({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTextField(
      controller: controller,
      label: 'Write a note',
      hint: 'Write here...',
      prefixIcon: HugeIcons.strokeRoundedNote,
      minLines: 1,
      maxLines: 3,
    );
  }
}
