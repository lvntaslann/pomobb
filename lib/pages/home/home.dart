import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/cubit/content/content_state.dart';
import '../../themes/app_colors.dart';
import '../../widgets/container/build_timer_container.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBgColor,
      body: BlocBuilder<ContentCubit, ContentState>(
        
        builder: (context, state) {

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.allContent.isEmpty) {
            return const Center(
              child: Text(
                "Henüz içerik eklenmemiş",
                style: TextStyle(color: Colors.white, fontSize: 18),
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
                        child: BuildTimerContainer(
                          subject: item.subject,
                          time: "${item.time}dk",
                          iconPath: item.iconPath,
                          containerBg: item.containerBgColor,
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
    );
  }
}
