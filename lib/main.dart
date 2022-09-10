import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinterest_app/services/hive_db_service.dart';
import 'app.dart';

Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized(

  );
  await Hive.initFlutter();

  await Hive.initFlutter();
  await Hive.openBox(HiveService.dbName);

  runApp(const MyPinterestApp());
}