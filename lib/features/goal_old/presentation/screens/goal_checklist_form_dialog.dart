import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/core/components/bottom_sheets/custom_bottom_sheet.dart';
import 'package:moneynest/core/components/buttons/button_state.dart';
import 'package:moneynest/core/components/buttons/primary_button.dart';
import 'package:moneynest/core/components/form_fields/custom_numeric_field.dart';
import 'package:moneynest/core/components/form_fields/custom_text_field.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/core/extensions/double_extension.dart';
import 'package:moneynest/core/extensions/string_extension.dart';
import 'package:moneynest/core/utils/logger.dart';
import 'package:moneynest/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:moneynest/features/goal/data/model/checklist_item_model.dart';
import 'package:moneynest/features/goal/presentation/services/goal_form_service.dart';

class GoalChecklistFormDialog extends HookConsumerWidget {
  final int goalId;
  final ChecklistItemModel? checklistItemModel;
  const GoalChecklistFormDialog({
    super.key,
    required this.goalId,
    this.checklistItemModel,
  });

  @override
  Widget build(BuildContext context, ref) {
    final defaultCurrency = ref.read(authStateProvider).defaultCurrency;
    final titleController = useTextEditingController();
    final amountController = useTextEditingController();
    final linkController = useTextEditingController();
    bool completed = false;
    bool isEditing = false;

    useEffect(() {
      isEditing = checklistItemModel != null;

      if (isEditing) {
        titleController.text = checklistItemModel!.title;
        amountController.text =
            '$defaultCurrency ${checklistItemModel!.amount.toPriceFormat()}';
        linkController.text = checklistItemModel!.link;
        completed = checklistItemModel!.completed;
      }
      return null;
    }, const []);

    return CustomBottomSheet(
      title: '${isEditing ? 'Edit' : 'Add'} Checklist Item',
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.spacing16,
          children: [
            CustomTextField(
              controller: titleController,
              label: 'Title',
              hint: 'Mua sắm, du lịch',
              isRequired: true,
              prefixIcon: HugeIcons.strokeRoundedArrangeByLettersAZ,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
            CustomNumericField(
              controller: amountController,
              label: 'Price amount',
              hint: '$defaultCurrency 34',
              icon: HugeIcons.strokeRoundedCoins01,
              isRequired: true,
            ),
            CustomTextField(
              controller: linkController,
              label: 'Link or place to buy',
              hint: 'Insert or paste link here...',
              prefixIcon: HugeIcons.strokeRoundedLink01,
              suffixIcon: HugeIcons.strokeRoundedClipboard,
            ),
            PrimaryButton(
              label: 'Save',
              state: ButtonState.active,
              onPressed: () async {
                Log.d(titleController.text, label: 'title');
                Log.d(
                  amountController.text.takeNumericAsDouble(),
                  label: 'amount',
                );
                Log.d(linkController.text, label: 'link');

                final newItem = ChecklistItemModel(
                  id: checklistItemModel?.id,
                  goalId: goalId,
                  title: titleController.text,
                  amount: amountController.text.takeNumericAsDouble(),
                  link: linkController.text,
                  completed: completed,
                );

                // return;
                GoalFormService().saveChecklist(
                  context,
                  ref,
                  checklistItem: newItem,
                );
              },
            ),
            if (isEditing)
              TextButton(
                child: Text(
                  'Delete',
                  style: AppTextStyles.body2.copyWith(color: AppColors.red),
                ),
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                      title: Text('Delete Checklist'),
                      content: Text('Continue to delete this item?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            GoalFormService().deleteChecklist(
                              context,
                              ref,
                              checklistItem: checklistItemModel!,
                            );
                            context.pop();
                            context.pop();
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
