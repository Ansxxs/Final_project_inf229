import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/english_questions.dart';
import '../data/math_questions.dart';
import '../data/mobile_dev_questions.dart';
import '../models/question.dart';


enum Subject { math, english, mobile }

class QuizProvider extends ChangeNotifier {
  List<Question> _allQuestions = [];
  List<Question> _currentQuizSet = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  Timer? _timer;
  int _timeLeft = 15;
  int _highScore = 0;

  List<Question> get questions => _currentQuizSet;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get timeLeft => _timeLeft;
  int get highScore => _highScore;
  int? get selectedAnswer => _selectedAnswer;

  Question get currentQuestion => _currentQuizSet[_currentIndex];
  bool get isFinished => _currentIndex >= _currentQuizSet.length;
  double get progress => _currentQuizSet.isEmpty ? 0 : (_currentIndex + 1) / _currentQuizSet.length;

  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    notifyListeners();
  }

  void startQuiz(Subject subject) {
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;

    List<Question> targetList;
    switch (subject) {
      case Subject.math:
        targetList = mathQuestions;
        break;
      case Subject.english:
        targetList = englishQuestions;
        break;
      case Subject.mobile:
        targetList = mobileDevQuestions;
        break;
    }

    _allQuestions = List.from(targetList)..shuffle();
    _currentQuizSet = _allQuestions.take(10).toList();

    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _nextQuestion();
      }
    });
  }

  void answerQuestion(int index) {
    if (_selectedAnswer != null) return;
    _selectedAnswer = index;
    if (index == currentQuestion.correctIndex) _score++;
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), _nextQuestion);
  }

  void _nextQuestion() {
    if (_currentIndex < _currentQuizSet.length - 1) {
      _currentIndex++;
      _selectedAnswer = null;
      _startTimer();
    } else {
      _currentIndex++;
      _timer?.cancel();
      _saveHighScore();
    }
    notifyListeners();
  }

  Future<void> _saveHighScore() async {
    if (_score > _highScore) {
      _highScore = _score;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('highScore', _highScore);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

