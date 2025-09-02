import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/pages/splash/splash_screen.dart';
import 'package:pomobb/services/content_services.dart';
import 'package:pomobb/services/notification_services.dart';
import 'package:pomobb/background_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(ContentModelAdapter());
  var box = await Hive.openBox<ContentModel>('contentData');

  // notification services
  NotificationServices notificationServices = NotificationServices();
  await notificationServices.initNotification();
  debugPrint("Workmanager initialization starting");
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
  await Workmanager().registerPeriodicTask(
    id.toString(),
    dailyNotificationTask,
    frequency: const Duration(minutes: 15),
    inputData: {
      "title": "Pomobb Hatırlatma",
      "body": "Bu bildirim uygulama kapalıyken bile çalışır!"
    },
  );
  debugPrint("Workmanager initialization complete");

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ContentCubit(ContentServices(contentBox: box))..getAllContent()),
      ],
      child: MainApp(notificationServices: notificationServices),
    ),
  );
}

class MainApp extends StatelessWidget {
  final NotificationServices notificationServices;
  const MainApp({required this.notificationServices, super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
