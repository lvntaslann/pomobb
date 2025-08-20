import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/cubit/content/content_state.dart';
import 'package:pomobb/model/content_model.dart';
import '../../themes/app_colors.dart';
import '../../widgets/container/build_timer_container.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.homeBgColor,
      body: BlocBuilder<ContentCubit, ContentState>(
        builder: (context, state) {
          print("UI: allContent length: ${state.allContent.length}");
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
                          onTap: () => BlocProvider.of<ContentCubit>(context)
                              .deleteContent(item.id),
                          child: BuildTimerContainer(
                            subject: item.subject,
                            time: "${item.time}dk",
                            iconPath: item.iconPath,
                            containerBg: Color(item.containerBgColor),
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
                    context, subjectController, timeController));
          }),
    );
  }

  Widget _buildShowDialog(
      BuildContext context,
      TextEditingController subjectController,
      TextEditingController timeController) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.homeBgColor,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          height: 300,
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
                      iconPath: "assets/icon/earth.png",
                      containerBgColor: AppColors.timerContainerColor2.value,
                    );

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
