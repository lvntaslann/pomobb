import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/cubit/content/content_state.dart';
import 'package:pomobb/pages/timer/timer_page.dart';
import '../../themes/app_colors.dart';
import '../../utils/time_utils.dart';
import '../../widgets/container/build_timer_container.dart';
import '../../widgets/showdialog/add_event_dialog.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController periodController = TextEditingController();
    TextEditingController breakTimeController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.homeBgColor,
      body: BlocBuilder<ContentCubit, ContentState>(
        builder: (context, state) {
          debugPrint("UI: allContent length: ${state.allContent.length}");
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.allContent.isEmpty) {
            return const Center(
              child: Text(
                "Henüz içerik eklenmemiş",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(left: 40, top: 50, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Etkinliklerin",
                  style: TextStyle(
                    color: AppColors.topTextColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.allContent.length,
                    itemBuilder: (context, index) {
                      final item = state.allContent[index];
                      String formattedTime = formatDuration(item.time);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TimerPage(content: item)));
                          },
                          child: BuildTimerContainer(
                            subject: item.subject,
                            time: formattedTime,
                            iconPath: item.iconPath,
                            containerBg: Color(item.containerBgColor),
                            isSuccess: item.isSuccess,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.addButtonBgColor,
          child: const Icon(
            Icons.add,
            color: AppColors.addButtonIconColor,
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => AddEventDialog(
                subjectController: subjectController,
                timeController: timeController,
                periodController: periodController,
                breakTimeController: breakTimeController,
              ),
            );
            subjectController.clear();
            timeController.clear();
            periodController.clear();
            breakTimeController.clear();
          }),
    );
  }
}
