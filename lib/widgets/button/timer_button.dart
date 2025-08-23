import 'package:flutter/material.dart';
import 'package:pomobb/themes/app_colors.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({
    required this.onTap,
    required this.icon,
    super.key,
  });
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.timerButtonBgColor),
        child: Icon(
          icon,
          color: AppColors.timerIconColor,
          size: 40,
        ),
      ),
    );
  }
}