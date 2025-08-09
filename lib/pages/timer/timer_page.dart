import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomobb/themes/app_colors.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 250;
    double imageSize = 40;

    return Scaffold(
      backgroundColor: AppColors.timerBgColor1,
      body: Column(
        children: [
          const SizedBox(height: 200),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double angle = (2 * pi * _controller.value) - pi / 2;

                double centerX = circleSize / 2;
                double centerY = circleSize / 2;

                double radius = (circleSize / 2) - 5;

                double earthX = centerX + radius * cos(angle) - (imageSize / 2);
                double earthY = centerY + radius * sin(angle) - (imageSize / 2);

                return SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        size: Size(circleSize, circleSize),
                        painter: TimerPainter(
                          backgroundColor: AppColors.timerStartProgressColor2,
                          progressColor: AppColors.timerProgressColor2,
                          progress: _controller.value,
                        ),
                      ),
                      Positioned(
                        left: earthX,
                        top: earthY,
                        child: Image.asset(
                          "assets/icon/earth.png",
                          width: imageSize,
                          height: imageSize,
                        ),
                      ),
                      Center(
                        child: Text(
                          "${(10 * (1 - _controller.value)).ceil()}",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.timerProgressColor2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 100),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerButton(
                icon: Icons.refresh,
              ),
              SizedBox(width: 20),
              TimerButton(
                icon: Icons.play_arrow,
              ),
              SizedBox(width: 20),
              TimerButton(
                icon: Icons.cancel_outlined,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({
    required this.icon,
    super.key,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class TimerPainter extends CustomPainter {
  final Color backgroundColor;
  final Color progressColor;
  final double progress;

  TimerPainter({
    required this.backgroundColor,
    required this.progressColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.0;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth - 1
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, radius, bgPaint);

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + 0.001,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
