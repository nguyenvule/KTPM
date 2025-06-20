import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:moneynest/core/constants/app_radius.dart';

class CircleIconButton extends StatelessWidget {
  final double? radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? splashColor;
  final IconData icon;
  final Widget? child;
  final GestureTapCallback? onTap;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.child,
    this.radius = 38,
    this.backgroundColor,
    this.foregroundColor,
    this.splashColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.radiusFull),
      child: InkWell(
        onTap: onTap,
        radius: radius! * 2,
        splashColor: splashColor,
        highlightColor: splashColor,
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
        child: SizedBox(
          width: radius! * 2,
          height: radius! * 2,
          child: child ??
              HugeIcon(
                icon: icon,
                color: foregroundColor ?? Colors.black,
              ),
        ),
      ),
    );
  }
}
