import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider()..loadHighScore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Christmas Quiz',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFC62828),
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF0F2027),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}