import 'package:ai_chat/home_screen/views/home_screen_page.dart';
import 'package:ai_chat/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  Gemini.init(apiKey: 'AIzaSyCpeEKaPc1FInU5X1ggg3USQLKqYiGBwjM');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      theme: ThemeData(
        // colorScheme: const ColorScheme.dark(),
        fontFamily: 'Barlow',
        useMaterial3: true,
      ),
      home: const HomeScreenPage(),
    );
  }
}
