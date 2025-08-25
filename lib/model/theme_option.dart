import 'dart:ui';

import 'package:pomobb/themes/app_colors.dart';

class ThemeOption {
  final Color color;
  final Color containerBgColor;
  final Color timerStartProgressColor;
  final Color timerProgressColor;
  final Color timerTextColor;
  final String iconPath;

  ThemeOption({
    required this.color,
    required this.containerBgColor,
    required this.timerStartProgressColor,
    required this.timerProgressColor,
    required this.timerTextColor,
    required this.iconPath,
  });

 static final List<ThemeOption> themeOptions = [
  ThemeOption(
    color: AppColors.timerBgColor1,
    containerBgColor: AppColors.timerContaninerColor1,
    timerStartProgressColor: AppColors.timerStartProgressColor1,
    timerProgressColor: AppColors.timerProgressColor1,
    timerTextColor: AppColors.timerTextColor1,
    iconPath: "assets/icon/venus.png",
  ),
  ThemeOption(
    color: AppColors.timerBgColor2,
    containerBgColor: AppColors.timerContainerColor2,
    timerStartProgressColor: AppColors.timerStartProgressColor2,
    timerProgressColor: AppColors.timerProgressColor2,
    timerTextColor: AppColors.timerTextColor2,
    iconPath: "assets/icon/earth.png",
  ),
  ThemeOption(
    color: AppColors.timerBgColor3,
    containerBgColor: AppColors.timerContainerColor3,
    timerStartProgressColor: AppColors.timerStartProgressColor3,
    timerProgressColor: AppColors.timerProgressColor3,
    timerTextColor: AppColors.timerTextColor3,
    iconPath: "assets/icon/saturn.png",
  ),
];
}