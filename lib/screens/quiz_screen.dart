import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/snow_widget.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().addListener(_onQuizUpdate);
    });
  }

  void _onQuizUpdate() {
    if (!mounted) return;
    final quiz = context.read<QuizProvider>();
    if (quiz.isFinished) {
      quiz.removeListener(_onQuizUpdate);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ResultScreen()));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, _) {
        if (quiz.questions.isEmpty) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF232526), Color(0xFF414345)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
              ),
              const SnowWidget(),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context)),
                          const Text("Winter Quiz",
                              style: TextStyle(color: Colors.white70, fontSize: 16)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: quiz.timeLeft <= 5 ? Colors.redAccent : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.timer, size: 16, color: Colors.white),
                                const SizedBox(width: 4),
                                Text('${quiz.timeLeft}s',
                                    style: const TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: quiz.progress,
                          minHeight: 10,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation(Colors.redAccent),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Question ${quiz.currentIndex + 1} / ${quiz.questions.length}",
                          style: const TextStyle(color: Colors.white54)),

                      const Spacer(),

                      // Question Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10))
                          ],
                        ),
                        child: Text(
                          quiz.currentQuestion.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),

                      const Spacer(),

                      // Options
                      ...List.generate(quiz.currentQuestion.options.length, (index) {
                        return _buildOptionButton(quiz, index);
                      }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(QuizProvider quiz, int index) {
    bool isSelected = quiz.selectedAnswer == index;
    bool isCorrect = index == quiz.currentQuestion.correctIndex;
    bool showResult = quiz.selectedAnswer != null;

    Color bgColor = Colors.white.withOpacity(0.1);
    Color borderColor = Colors.white.withOpacity(0.3);
    IconData? icon;

    if (showResult) {
      if (isCorrect) {
        bgColor = Colors.green.withOpacity(0.8);
        borderColor = Colors.green;
        icon = Icons.check_circle;
      } else if (isSelected) {
        bgColor = Colors.redAccent.withOpacity(0.8);
        borderColor = Colors.redAccent;
        icon = Icons.cancel;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => quiz.answerQuestion(index),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Text("${String.fromCharCode(65 + index)}.",
                  style: const TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  quiz.currentQuestion.options[index],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              if (icon != null) Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}