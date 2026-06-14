import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/hero_model.dart';
import 'screens/hero_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(HeroModelAdapter());

  await Hive.openBox<HeroModel>('heroesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1C1F),
        primaryColor: const Color(0xFFE53935),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF252529),
          elevation: 0,
        ),
      ),
      home: const HeroListScreen(),
    );
  }
}