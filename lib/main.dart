import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:offline_persistancy_hive/models/picture_model.dart';
import 'package:offline_persistancy_hive/screens/home_screen/home_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(PictureModelAdapter());
  await Hive.openBox<PictureModel>('pictureHive');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  HomeScreen(),
    );
  }
}
