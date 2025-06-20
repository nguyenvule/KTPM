import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/buttons/secondary_button.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/services/image_service/riverpod/image_notifier.dart';

class TransactionImagePicker extends ConsumerWidget {
  const TransactionImagePicker({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final imageNotifier = ref.read(imageProvider.notifier);

    return Row(
      children: [
        if (Platform.isAndroid || Platform.isIOS)
          Expanded(
            child: SecondaryButton(
              onPressed: () async {
                imageNotifier.takePhoto().then((value) {
                  imageNotifier.saveImage();
                });
              },
              label: 'Máy ảnh',
              icon: HugeIcons.strokeRoundedCamera01,
            ),
          ),
        if (Platform.isAndroid || Platform.isIOS)
          const Gap(AppSpacing.spacing8),
        Expanded(
          child: SecondaryButton(
            onPressed: () {
              imageNotifier.pickImage().then((value) {
                imageNotifier.saveImage();
              });
            },
            label: 'Thư viện',
            icon: HugeIcons.strokeRoundedImage01,
          ),
        ),
      ],
    );
  }
}
