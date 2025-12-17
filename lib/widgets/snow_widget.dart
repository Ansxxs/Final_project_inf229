import 'dart:math';
import 'package:flutter/material.dart';

class SnowWidget extends StatefulWidget {
  final int snowCount;
  const SnowWidget({super.key, this.snowCount = 50});

  @override
  State<SnowWidget> createState() => _SnowWidgetState();
}

class _SnowWidgetState extends State<SnowWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Snowflake> _snowflakes = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    for (int i = 0; i < widget.snowCount; i++) {
      _snowflakes.add(_Snowflake(_random));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          for (var flake in _snowflakes) {
            flake.fall();
          }
          return CustomPaint(
            painter: _SnowPainter(_snowflakes),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _Snowflake {
  double x = 0;
  double y = 0;
  double radius = 0;
  double speed = 0;
  final Random random;

  _Snowflake(this.random) {
    reset(true);
  }

  void reset(bool initial) {
    x = random.nextDouble();
    y = initial ? random.nextDouble() : -0.1;
    radius = random.nextDouble() * 2 + 1; // Размер 1-3
    speed = random.nextDouble() * 0.005 + 0.002;
  }

  void fall() {
    y += speed;
    if (y > 1.1) reset(false);
  }
}

class _SnowPainter extends CustomPainter {
  final List<_Snowflake> flakes;
  _SnowPainter(this.flakes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    for (var flake in flakes) {
      canvas.drawCircle(Offset(flake.x * size.width, flake.y * size.height), flake.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}