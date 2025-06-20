import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/components/buttons/primary_button.dart';
import 'package:moneynest/core/components/form_fields/custom_text_field.dart';
import 'package:moneynest/core/constants/app_colors.dart';
import 'package:moneynest/core/constants/app_constants.dart';
import 'package:moneynest/core/constants/app_radius.dart';
import 'package:moneynest/core/constants/app_spacing.dart';
import 'package:moneynest/core/constants/app_text_styles.dart';
import 'package:moneynest/core/router/routes.dart';
import 'package:moneynest/core/services/image_service/domain/image_state.dart';
import 'package:moneynest/core/services/image_service/image_service.dart';
import 'package:moneynest/core/services/image_service/riverpod/image_notifier.dart';
import 'package:moneynest/features/authentication/data/models/user_model.dart';
import 'package:moneynest/features/authentication/presentation/riverpod/auth_provider.dart';
import 'package:moneynest/features/currency_picker/presentation/components/currency_picker_field.dart';
import 'package:moneynest/features/currency_picker/presentation/riverpod/currency_picker_provider.dart';

part '../components/form.dart';
part '../components/logo.dart';
part '../components/login_info.dart';
part '../components/login_image_picker.dart';
part '../components/get_started_description.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final nameField = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.light,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            // color: Colors.yellow,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo(),
                const Gap(AppSpacing.spacing48),
                Form(nameField: nameField),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.light,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.spacing20,
                horizontal: AppSpacing.spacing20,
              ),
              child: PrimaryButton(
                label: 'Đăng nhập',
                onPressed: () {
                  final user = UserModel(
                    id: 1,
                    name: nameField.text,
                    email: 'user@mail.com',
                    profilePicture: ref.read(loginImageProvider).savedPath,
                    currency: ref.read(currencyProvider),
                  );

                  ref.read(authStateProvider.notifier).setUser(user);
                  context.push(Routes.main);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
