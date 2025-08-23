import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/widgets/showdialog/task_showdialog.dart';
import '../../widgets/button/timer_button.dart';
import '../../widgets/timer_paint.dart';

class TimerPage extends StatefulWidget {
  final ContentModel content;
  const TimerPage({Key? key, required this.content}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isTimeFinish = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.content.time * 60),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        func_showdialog();
      }
    });
    _controller.forward();
  }

  void changeTimerState() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void func_showdialog() {
    buildTaskFinishShowDialog();
  }

Future<dynamic> buildTaskFinishShowDialog() {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return TaskShowDialog(content: widget.content);
    },
  );
}

  @override
  Widget build(BuildContext context) {
    double circleSize = 250;
    double imageSize = 40;

    return Scaffold(
      backgroundColor: Color(widget.content.timerPageColor),
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
                          backgroundColor: Color(widget.content.timerStartProgressColor),
                          progressColor: Color(widget.content.timerProgressColor),
                          progress: _controller.value,
                        ),
                      ),
                      Positioned(
                        left: earthX,
                        top: earthY,
                        child: Image.asset(
                          widget.content.iconPath,
                          width: imageSize,
                          height: imageSize,
                        ),
                      ),
                      Center(
                        child: Text(
                          (() {
                            int remaining = widget.content.time * 60 -
                                (_controller.value * widget.content.time * 60)
                                    .round();
                            int hours = remaining ~/ 3600;
                            int minutes = (remaining ~/ 60) % 60;
                            int seconds = remaining % 60;
                            return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
                          })(),
                          style:  TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(widget.content.timerTextColor),
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TimerButton(
              onTap: () {
                _controller.reset();
                _controller.forward();
              },
              icon: Icons.refresh,
            ),
            const SizedBox(width: 20),
            TimerButton(
              onTap: () {
                changeTimerState();
              },
              icon: Icons.play_arrow,
            ),
            const SizedBox(width: 20),
            const SizedBox(),
          ])
        ],
      ),
    );
  }
}





 
