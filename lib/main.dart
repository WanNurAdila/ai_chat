import 'package:ai_chat/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
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
        fontFamily: 'Barlow',
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
