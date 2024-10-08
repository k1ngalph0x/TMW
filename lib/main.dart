import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tmw/screens/home_screen.dart';

import 'provider/workout_provider.dart';

Future<void> main() async {
  //sqfliteFfiInit();
  //databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  await getApplicationDocumentsDirectory();
  runApp(
    ChangeNotifierProvider(
      create: (context) => WorkoutProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
