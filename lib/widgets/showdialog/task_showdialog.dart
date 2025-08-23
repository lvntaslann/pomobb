import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/themes/app_colors.dart';

class TaskShowDialog extends StatelessWidget {
  final ContentModel content;

  const TaskShowDialog({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Color(content.timerPageColor),
      child: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/happy.json", width: 150, height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          AppColors.timerProgressColor2),
                    ),
                    onPressed: () async {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      final updatedContent = content.copyWith(isSuccess: true);
                      await context
                          .read<ContentCubit>()
                          .updateContent(updatedContent);
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}