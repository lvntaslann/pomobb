import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class BuildTimerContainer extends StatelessWidget {
  const BuildTimerContainer({
    super.key,
    required this.subject,
    required this.time,
    required this.iconPath,
    required this.containerBg,
    required this.isSuccess,
  });

  final String subject;
  final String time;
  final String iconPath;
  final Color containerBg;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 318,
      height: 118.67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: containerBg,
        border: Border.all(
          color: AppColors.timerContainerStrokeColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subject,
                  style: const TextStyle(
                    color: AppColors.timerContaninerTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.timerContaninerTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              iconPath,
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSuccess ? Colors.green : Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: isSuccess
                            ? Colors.green.withOpacity(0.5)
                            : Colors.red.withOpacity(0.5),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    isSuccess ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
