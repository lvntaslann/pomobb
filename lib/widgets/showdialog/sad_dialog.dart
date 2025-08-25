import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/pages/home/home.dart';
import 'package:pomobb/themes/app_colors.dart';

class SadDialog extends StatelessWidget {
  final ContentModel content;
  const SadDialog({Key? key, required this.content}) : super(key: key);

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
              Lottie.asset("assets/lottie/sad.json", width: 150, height: 150),
              const SizedBox(height: 20),
              const Text(
                "Gidiyor musun ?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Kapat", style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          AppColors.timerProgressColor2),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Home()));
                    },
                    child: const Text(
                      "Ana sayfa",
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