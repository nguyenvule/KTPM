part of '../screens/onboarding_screen.dart';

class GetStartedButton extends ConsumerWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.light,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: PrimaryButton(
          label: 'Bắt đầu',
          onPressed: () {
            if (context.mounted) context.push(Routes.getStarted); // route '/'
          },
        ),
      ),
    );
  }
}
