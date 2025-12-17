import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/snow_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);

    final bool isWinner = quiz.score >= (quiz.questions.length * 0.7);

    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isWinner
                    ? [const Color(0xFF11998e), const Color(0xFF38ef7d)] // Зеленый успех
                    : [const Color(0xFFcb2d3e), const Color(0xFFef473a)], // Красный провал
              ),
            ),
          ),

          const SnowWidget(),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Icon(
                          isWinner ? Icons.emoji_events_rounded : Icons.sentiment_dissatisfied_rounded,
                          size: 120,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Text(
                    isWinner ? "Nice List! 📜" : "Naughty List? 🎅",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))]
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "You scored ${quiz.score} / ${quiz.questions.length}",
                    style: const TextStyle(fontSize: 24, color: Colors.white70),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Best score: ${quiz.highScore}",
                    style: const TextStyle(fontSize: 18, color: Colors.white54, fontStyle: FontStyle.italic),
                  ),

                  const SizedBox(height: 60),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.replay_rounded, color: Colors.black87),
                    label: const Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 10,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}