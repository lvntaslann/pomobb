import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/content/content_cubit.dart';
import '../../model/content_model.dart';
import '../../model/theme_option.dart';
import '../../themes/app_colors.dart';
import '../container/color_select_box.dart';
import '../period_control.dart';


class AddEventDialog extends StatefulWidget {
  final TextEditingController subjectController;
  final TextEditingController timeController;
  final TextEditingController periodController;
  final TextEditingController breakTimeController;

  const AddEventDialog({
    Key? key,
    required this.subjectController,
    required this.timeController,
    required this.periodController,
    required this.breakTimeController,
  }) : super(key: key);

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  late Color containerBgColor;
  late Color timerPageColor;
  late Color timerStartProgressColor;
  late Color timerProgressColor;
  late Color timerTextColor;
  late String iconPath;

  @override
  void initState() {
    super.initState();
    containerBgColor = AppColors.timerContaninerColor1;
    timerPageColor = AppColors.timerBgColor1;
    timerStartProgressColor = AppColors.timerStartProgressColor1;
    timerProgressColor = AppColors.timerProgressColor1;
    timerTextColor = AppColors.timerTextColor1;
    iconPath = "assets/icon/venus.png";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: 500,
                height: 520,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık
                    const Padding(
                      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: Text(
                        "Etkinlik Ekle",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Form Alanları
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTextField(widget.subjectController, "subject"),
                          const SizedBox(height: 20),
                          _buildTimePicker(context),
                          const SizedBox(height: 20),

                          const Text(
                            "Tur sayısı",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          PeriodControl(
                            value: int.tryParse(widget.periodController.text) ?? 0,
                            onIncrement: () {
                              setState(() {
                                int currentValue =
                                    int.tryParse(widget.periodController.text) ?? 0;
                                widget.periodController.text =
                                    (currentValue + 1).toString();
                              });
                            },
                            onDecrement: () {
                              setState(() {
                                int currentValue =
                                    int.tryParse(widget.periodController.text) ?? 0;
                                if (currentValue <= 0) currentValue = 1;
                                widget.periodController.text =
                                    (currentValue - 1).toString();
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          _buildTextField(widget.breakTimeController, "break time(dk)"),
                          const SizedBox(height: 20),

                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 30),
                            child: const Text(
                              "Tema Seç",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < ThemeOption.themeOptions.length;
                                  i++) ...[
                                ColorSelectBox(
                                  color: ThemeOption.themeOptions[i].color,
                                  selected: timerPageColor ==
                                      ThemeOption.themeOptions[i].color,
                                  iconPath:
                                      ThemeOption.themeOptions[i].iconPath,
                                  onTap: () {
                                    setState(() {
                                      containerBgColor = ThemeOption
                                          .themeOptions[i].containerBgColor;
                                      timerPageColor =
                                          ThemeOption.themeOptions[i].color;
                                      timerStartProgressColor = ThemeOption
                                          .themeOptions[i]
                                          .timerStartProgressColor;
                                      timerProgressColor = ThemeOption
                                          .themeOptions[i]
                                          .timerProgressColor;
                                      timerTextColor = ThemeOption
                                          .themeOptions[i].timerTextColor;
                                      iconPath =
                                          ThemeOption.themeOptions[i].iconPath;
                                    });
                                  },
                                ),
                                if (i != ThemeOption.themeOptions.length - 1)
                                  const SizedBox(width: 10),
                              ]
                            ],
                          ),
                          const SizedBox(height: 20),

                          _buildAddButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          controller: controller,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            hintText: hint,
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () async{
        
        if (widget.subjectController.text.isEmpty ||
            widget.timeController.text.isEmpty) {
          return;
        }

        final newContent = ContentModel(
          id: DateTime.now().millisecondsSinceEpoch,
          subject: widget.subjectController.text,
          time: int.parse(widget.timeController.text),
          iconPath: iconPath,
          containerBgColor: containerBgColor.value,
          timerPageColor: timerPageColor.value,
          timerStartProgressColor: timerStartProgressColor.value,
          timerProgressColor: timerProgressColor.value,
          timerTextColor: timerTextColor.value,
          period: int.parse(widget.periodController.text),
          breakTime: int.parse(widget.breakTimeController.text) * 60,
          isSuccess: false,
        );

        await BlocProvider.of<ContentCubit>(context).addContent(newContent);
        Navigator.pop(context);
      },
      
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


Widget _buildTimePicker(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) {
          Duration tempDuration = Duration(
            seconds: int.tryParse(widget.timeController.text) ?? 0,
          );

          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Süre Seç",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    Expanded(
                      child: CupertinoTheme(
                        data: const CupertinoThemeData(
                          brightness: Brightness.dark, // Dark moda geç
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              color: Colors.white, // Süreler beyaz
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hms, // Saat + Dakika + Saniye
                          initialTimerDuration: tempDuration,
                          onTimerDurationChanged: (Duration value) {
                            setState(() {
                              widget.timeController.text =
                                  value.inSeconds.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.addButtonBgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Tamam",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
    child: Container(
      width: 200,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        widget.timeController.text.isEmpty
            ? "Zamanı belirle"
            : "${(int.tryParse(widget.timeController.text) ?? 0) ~/ 3600} sa "
              "${((int.tryParse(widget.timeController.text) ?? 0) % 3600) ~/ 60} dk "
              "${(int.tryParse(widget.timeController.text) ?? 0) % 60} sn",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}



}


