import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/widgets/showdialog/task_showdialog.dart';
import 'package:pomobb/widgets/showdialog/sad_dialog.dart';
import 'package:pomobb/widgets/showdialog/break_alert_dialog.dart';
import 'package:pomobb/widgets/showdialog/resume_alert_dialog.dart';
import '../../utils/time_utils.dart';
import '../../widgets/button/timer_button.dart';
import '../../widgets/timer_paint.dart';

class TimerPage extends StatefulWidget {
  final ContentModel content;
  const TimerPage({Key? key, required this.content}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _breakTimeController;
  late int periodLeft;
  late int currentPeriod = 1;
  bool _isBreakActive = false;

  @override
  void initState() {
    super.initState();
    periodLeft = widget.content.period;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.content.time),
    );

    _breakTimeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.content.breakTime),
    );
    _breakTimeController.addListener(() {
      if (_isBreakActive) setState(() {});
    });

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        periodLeft -= 1;
        currentPeriod += 1;
        _controller.reset();

        if (periodLeft == 0) {
          buildTaskFinishShowDialog();
        } else {
          setState(() {
            _isBreakActive = true;
          });
          await _showBreakDialog();
          _breakTimeController.forward(from: 0);
        }
      }
    });

    _breakTimeController.addStatusListener((status) async {
      if (status == AnimationStatus.completed && periodLeft > 0) {
        _breakTimeController.reset();
        setState(() {
          _isBreakActive = false;
        });
        await _showResumeDialog();
        _controller.forward(from: 0);
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

  Future<void> _showBreakDialog() async {
    await showDialog(
      context: context,
      builder: (context) => BreakAlertDialog(
        breakMinutes: formatDuration(widget.content.breakTime),
      ),
    );
  }

  Future<void> _showResumeDialog() async {
    await showDialog(
      context: context,
      builder: (context) => const ResumeAlertDialog(),
    );
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
  void dispose() {
    _controller.dispose();
    _breakTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 250;
    double imageSize = 40;

    return Scaffold(
      backgroundColor: Color(widget.content.timerPageColor),
      body: Column(
        children: [
          const SizedBox(height: 150),
          Text("Tur: $currentPeriod / ${widget.content.period}"),
          const SizedBox(height: 50),
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
                          backgroundColor:
                              Color(widget.content.timerStartProgressColor),
                          progressColor:
                              Color(widget.content.timerProgressColor),
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
                          formatRemainingTime(
                              widget.content.time, _controller.value),
                          style: TextStyle(
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

          const SizedBox(height: 80),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerButton(
                onTap: () {
                  _controller.reset();
                  _controller.forward();
                },
                icon: Icons.refresh,
              ),
              const SizedBox(width: 20),
              TimerButton(
                onTap: (){
                  setState(() {
                    changeTimerState();
                  });
                },
                icon: _controller.isAnimating ? Icons.pause : Icons.play_arrow,
              ),
              const SizedBox(width: 20),
              TimerButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SadDialog(content: widget.content);
                    },
                  );
                },
                icon: Icons.cancel,
              ),
            ],
          ),

          const SizedBox(height: 20),

          _isBreakActive
              ? Column(
                  children: [
                    Text(
                      "Mola Süresi: ${formatDuration(widget.content.breakTime)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: LinearProgressIndicator(
                        value: _breakTimeController.value,
                        backgroundColor:
                            Color(widget.content.timerStartProgressColor),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(widget.content.timerProgressColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Kalan Mola: ${formatRemainingTime(widget.content.breakTime, _breakTimeController.value)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
