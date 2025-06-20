part of '../screens/settings_screen.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authStateProvider);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.darkAlpha30,
          radius: 50,
          child: CircleAvatar(
            backgroundColor: AppColors.tertiary800,
            backgroundImage: auth.profilePicture == null
                ? null
                : FileImage(File(auth.profilePicture!)),
            radius: 49,
          ),
        ),
        const Gap(AppSpacing.spacing12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              auth.name,
              style: AppTextStyles.body1,
            ),
            Text(
              'Người dùng',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.darkAlpha50,
              ),
            ),
            const Gap(AppSpacing.spacing8),
            CustomCurrencyChip(
              countryCode: auth.currency.countryCode,
              label: '${auth.currency.name} (${auth.currency.symbol})',
              background: AppColors.primaryAlpha10,
              foreground: AppColors.dark,
              borderColor: AppColors.primaryAlpha25,
            ),
          ],
        ),
      ],
    );
  }
}
