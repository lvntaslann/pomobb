import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pomobb/cubit/content/content_cubit.dart';
import 'package:pomobb/model/content_model.dart';
import 'package:pomobb/pages/home/home.dart';
import 'package:pomobb/services/content_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContentModelAdapter());
  var box= await Hive.openBox<ContentModel>('contentData');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ContentCubit(ContentServices(contentBox: box))..getAllContent()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}
