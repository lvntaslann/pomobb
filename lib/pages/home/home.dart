import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/cubit/content/content_state.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/pages/timer/timer_page.dart';
import '../../themes/app_colors.dart';
import '../../widgets/container/build_timer_container.dart';

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
                            time: "${item.time}dk",
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => _buildShowDialog(
                    context,
                    subjectController,
                    timeController,
                    periodController,
                    breakTimeController));
          }),
    );
  }

  Widget _buildShowDialog(
      BuildContext context,
      TextEditingController subjectController,
      TextEditingController timeController,
      TextEditingController periodController,
      TextEditingController breakTimeController) {
    Color containerBgColor = AppColors.timerContaninerColor1;
    Color timerPageColor = AppColors.timerBgColor1;
    Color timerStartProgressColor = AppColors.timerStartProgressColor1;
    Color timerProgressColor = AppColors.timerProgressColor1;
    Color timerTextColor = AppColors.timerTextColor1;
    String iconPath = "assets/icon/venus.png";
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.homeBgColor,
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Etkinlik Ekle",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(subjectController, "subject"),
                  const SizedBox(height: 20),
                  _buildTextField(timeController, "time"),
                  const SizedBox(height: 20),
                  _buildTextField(periodController, "period"),
                  const SizedBox(height: 20),
                  _buildTextField(breakTimeController, "break time"),
                  const SizedBox(height: 20),
                  // color selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            containerBgColor = AppColors.timerContaninerColor1;
                            timerPageColor = AppColors.timerBgColor1;
                            timerStartProgressColor =
                                AppColors.timerStartProgressColor1;
                            timerProgressColor = AppColors.timerProgressColor1;
                            timerTextColor = AppColors.timerTextColor1;
                            iconPath = "assets/icon/venus.png";
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.timerBgColor1,
                            border: timerPageColor == AppColors.timerBgColor1
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            containerBgColor = AppColors.timerContainerColor2;
                            timerPageColor = AppColors.timerBgColor2;
                            timerStartProgressColor =
                                AppColors.timerStartProgressColor2;
                            timerProgressColor = AppColors.timerProgressColor2;
                            timerTextColor = AppColors.timerTextColor2;
                            iconPath = "assets/icon/earth.png";
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.timerBgColor2,
                            border: timerPageColor == AppColors.timerBgColor2
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            timerPageColor = AppColors.timerBgColor3;
                            containerBgColor = AppColors.timerContainerColor3;
                            timerStartProgressColor =
                                AppColors.timerStartProgressColor3;
                            timerProgressColor = AppColors.timerProgressColor3;
                            timerTextColor = AppColors.timerTextColor3;
                            iconPath = "assets/icon/saturn.png";
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.timerBgColor3,
                            border: timerPageColor == AppColors.timerBgColor3
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (builderContext) {
                      return _buildAddButton(() async {
                        if (subjectController.text.isEmpty ||
                            timeController.text.isEmpty) {
                          return;
                        }

                        final newContent = ContentModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            subject: subjectController.text,
                            time: int.parse(timeController.text),
                            iconPath: iconPath,
                            containerBgColor: containerBgColor.value,
                            timerPageColor: timerPageColor.value,
                            timerStartProgressColor:
                                timerStartProgressColor.value,
                            timerProgressColor: timerProgressColor.value,
                            timerTextColor: timerTextColor.value,
                            period: int.parse(periodController.text),
                            breakTime: int.parse(
                              breakTimeController.text,
                            ),
                            isSuccess: false);

                        await BlocProvider.of<ContentCubit>(context)
                            .addContent(newContent);
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.addButtonBgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Ekle",
            style: TextStyle(color: AppColors.addButtonIconColor),
          ),
        ),
      ),
    );
  }
}
